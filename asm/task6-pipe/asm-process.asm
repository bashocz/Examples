    bits 32

    section .data

; strings
error_pipe	db	"Error pipe()", 0
error_fork	db	"Error fork()", 0
str_pipe	db	"I", 0


; local variables
%define		pid_adr		4
%define		status_adr	8
%define		args_adr	12
%define		arge_adr	16
%define		cmdi_adr	20
%define		last_cmd_adr	24
%define		inputpipe_adr1	28
%define		inputpipe_adr0	32
%define		outputpipe_adr1	36
%define		outputpipe_adr0	40
%define		idx_adr		44
%define		top_adr		48

%define		enter_stack	top_adr - 4

%define		argc		ebp + 8
%define		argv		ebp + 12
%define		pid		ebp - pid_adr
%define		status		ebp - status_adr
%define		args		ebp - args_adr
%define		arge		ebp - arge_adr
%define		cmdi		ebp - cmdi_adr
%define		last_cmd	ebp - last_cmd_adr
%define		input_pipe1	ebp - inputpipe_adr1
%define		input_pipe0	ebp - inputpipe_adr0
%define		output_pipe1	ebp - outputpipe_adr1
%define		output_pipe0	ebp - outputpipe_adr0
%define		idx		ebp - idx_adr

; macros
%define index(a,b) ((a) + (b)*4)





    section .text

    global asm_bash
    extern printf, strcmp, pipe, fork, wait, close, dup2, execvp, perror




asm_bash:
    enter enter_stack,0

    ; push all registers
    pushad

    ; variables init
    mov [args], dword 1
    mov [arge], dword 1
    mov [cmdi], dword 0
    mov [last_cmd], dword 0
    mov [idx], dword 1

main_idx_loop:

    ; check, if parameter is "I" pipe
    push str_pipe		; second parameter of function ("I")
    mov eax, [argv]
    mov ecx, [idx]
    push dword [index(eax, ecx)]	; first parameter of function (argv[idx])
    call strcmp
    add esp, 8
    cmp eax,0			; ? strcmp = 0
    jz exec_cmd			; jump, it is "I" pipe, call command

    ; check, if it is last argument
    mov eax, [argc]
    dec eax
    cmp eax, [idx]		; ? (argc - 1) > idx
    jnz next_main_idx		; jump, it is not last argument, continue

    mov [last_cmd], dword 1	; set flag of last argument

exec_cmd:

    ; copy pipe variables
    mov eax, [output_pipe0]
    mov [input_pipe0], eax	; input_pipe[0] = output_pipe[0]
    mov eax, [output_pipe1]
    mov [input_pipe1], eax	; input_pipe[1] = output_pipe[1]

    ; check, if it is flag of last argument
    mov eax, [last_cmd]
    cmp eax, 0			; ? last_cmp != 0
    jnz do_fork			; jump, it is last argument, continue fork()

    ; call function pipe(...)
    mov eax, ebp		; adress of output_pipe
    sub eax, outputpipe_adr0
    push eax			
    call pipe
    add esp, 4

    ; check, for error
    cmp eax, -1			; ? pipe() != -1
    jnz do_fork			; jump, no error

    ; error, end
    push error_pipe
    call perror
    add esp, 4

    mov eax, dword -1
    leave
    ret

do_fork:

    ; call fork()
    call fork

    cmp eax, -1			; ? fork() != -1
    jnz check_main_process		; jump, no error

    ; error, end
    push error_fork
    call perror
    add esp, 4

    mov eax, dword -1
    leave
    ret

check_main_process:

    cmp eax, 0			; ? fork() == 0
    jz forked_process		; jump, it is child process

    ; it is main process
    ; check, if it is first command
    mov eax, [cmdi]
    cmp eax, 0			; ? cmdi != 0
    jz next_cmd_idx		; jump, first command, don't close pipe

    ; close input pipe
    push dword [input_pipe0]	; parameter (input_pipe[0])
    call close
    add esp, 4
    push dword [input_pipe1]	; parameter (input_pipe[1])
    call close
    add esp, 4

next_cmd_idx:

    inc dword [cmdi]		; cmdi++
    mov eax, [idx]
    inc eax
    mov [args], eax		; args = idx + 1

next_main_idx:

    ; continue with next index of argument
    inc dword [idx]		; idx++
    mov eax, [argc]
    cmp eax, [idx]		; argc > idx
    jnz main_idx_loop		; it is not last argument, continue

    ; end of main process
    ; wiat loop to finish all sub processes
    mov ecx, [cmdi]

wait_cmd_end:

    pushad			; function wait lost register ecx!!!

    mov eax, ebp		; adress of status
    sub eax, status_adr
    push eax			
    call wait
    add esp, 4

    popad			

    loop wait_cmd_end

    popad

    ; end of main process...

    leave
    ret

forked_process:

    mov eax, [idx]
    mov [arge], eax		; arge = idx

    ; check, if it is flag of last argument
    mov eax, [last_cmd]
    cmp eax, 0			; ? last_cmp != 0
    jnz else_last_cmd		; jump, it is last argument

    ; duplicate output pipe
    push dword [output_pipe0]	; parameter (output_pipe[0])
    call close
    add esp, 4
    push dword 1		; second parameter
    push dword [output_pipe1]	; first parameter (output_pipe[1])
    call dup2
    add esp, 8
    push dword [output_pipe1]	; parameter (output_pipe[1])
    call close
    add esp, 4

    jmp dup_input_pipe

else_last_cmd:

    mov eax, [argc]
    mov [arge], eax		; arge = idx

dup_input_pipe:

    ; check, if it is first command
    mov eax, [cmdi]
    cmp eax, 0			; ? last_cmp != 0
    jz create_exec_args		; jump, it is first argument

    ; duplicate input pipe
    push dword [input_pipe1]	; parameter (input_pipe[1])
    call close
    add esp, 4
    push dword 0		; second parameter
    push dword [input_pipe0]	; first parameter (input_pipe[0])
    call dup2
    add esp, 8
    push dword [input_pipe0]	; parameter (input_pipe[0])
    call close
    add esp, 4

create_exec_args:

    ; create array of arguments
    mov eax, [arge]
    sub eax, [args]
    mov ecx, eax		; ecx = N
    inc eax			; number of  elements (N = arge - args + 1)
    shl eax, 2			; N * 4B
    sub esp, eax		; alocate local array N * 4B

    ; copy arguments
    mov esi, [argv]		; array of arguments
    mov eax, [args]
    shl eax, 2			; number byte to begin argument
    add esi, eax		; adress argument argv[args]
    mov edi, esp
    add edi, dword 4		; adress lokal array
    mov ebx, dword 0		; index...

cpy_arg_loop:
    mov eax, [index(esi, ebx)]	; <- argv[args + ebx]
    mov [index(edi, ebx)], eax	; -> loc_arr[ebx]
    inc ebx
    loop cpy_arg_loop

    mov eax, 0		; NULL
    mov [index(edi, ebx)], eax	; -> loc_arr[last]

    ; call command
    push edi			; second parameter
    push dword [edi]		; first parameter
    call execvp

    ; it is here just for some mistake in program :-D
    add esp, 8

    leave
    ret

