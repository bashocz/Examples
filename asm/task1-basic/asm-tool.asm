    bits 32

    section .data

; DISCRIMINANT
global asm_disc_a, asm_disc_b, asm_disc_c, asm_disc_d

; STRING LENGTH
extern c_strlen_str
global asm_strlen_len

; STRING REVERT TO OTHER
extern c_strrev1_str1, c_strrev1_str2

; STRING REVERT TO SAME
extern c_strrev2_str1

; MULTIPLICATION TABLE
global asm_multab_num, asm_multab_tab

; DIVIDE BY TWO LIST
global asm_divtwo_num, asm_divtwo_tab

; FACTORIAL LIST TABLE
global asm_faclist_tab


; LOCAL VARIABLES
asm_disc_a dd 0
asm_disc_b dd 0
asm_disc_c dd 0
asm_disc_d dd 0

asm_strlen_len dd 0

asm_multab_num dd 0
asm_multab_tab dd 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

asm_divtwo_num dd 0
asm_divtwo_tab dd 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

asm_faclist_mul dd 0
asm_faclist_tab dd 0, 0, 0, 0, 0, 0, 0, 0, 0, 0



    section .text

; PUBLIC LABELS
global asm_disc, asm_strlen, asm_strrev1, asm_strrev2, asm_multab, asm_divtwo, asm_faclist


; DISCRIMINANT
; there is not check if multiplying overflowed 32b
; high 32b from multiplying is stored in edx
asm_disc:
    enter 0,0

; d = b*b
    mov eax, [asm_disc_b]
    imul dword [asm_disc_b]
    mov [asm_disc_d], eax

; eax = (-4)*a*c
    mov eax, -4
    imul dword [asm_disc_a]
    imul dword [asm_disc_c]

; eax += d
    add eax, [asm_disc_d]
    mov [asm_disc_d], eax

    leave
    ret

; STRING LENGTH
asm_strlen:
    enter 0,0

    mov ecx, 0
    mov eax, 0

asm_strlen_cnt:
    mov cl, [c_strlen_str + eax]
    jcxz asm_strlen_end
    inc eax
    jmp asm_strlen_cnt

asm_strlen_end:
    mov [asm_strlen_len], eax

    leave
    ret

; STRING REVERT TO OTHER
asm_strrev1:
    enter 0,0

    mov ecx, 0
    mov eax, 0

asm_strrev1_cnt:
    mov cl, [c_strrev1_str1 + eax]
    jcxz asm_strrev1_cont
    inc eax
    jmp asm_strrev1_cnt

asm_strrev1_cont:
    mov ebx, 0
    mov [c_strrev1_str2 + eax], byte 0

asm_strrev1_loop:
    mov cl, [c_strrev1_str1 + ebx]
    dec eax
    mov [c_strrev1_str2 + eax], cl
    jcxz asm_strrev1_end
    inc ebx
    jmp asm_strrev1_loop

asm_strrev1_end:
    leave
    ret

; STRING REVERT TO SAME
asm_strrev2:
    enter 0,0

    mov ecx, 0
    mov eax, 0 ; string length

asm_strrev2_cnt:
    mov cl, [c_strrev2_str1 + eax]
    jcxz asm_strrev2_cont
    inc eax
    jmp asm_strrev2_cnt

asm_strrev2_cont:
    mov ebx, eax ; store string length, index from end of string
    mov ecx, 2 ; for dividing by 2
    mov edx, 0
    div cx ; dividing
    mov ecx, 0
    mov cx, ax ; step count
    mov eax, 0 ; index from start of string

asm_strrev2_loop:
    dec ebx
    mov dl, [c_strrev2_str1 + ebx] ; getting last character
    xchg dl, [c_strrev2_str1 + eax] ; exchange with first character
    mov [c_strrev2_str1 + ebx], dl ; storing new last character
    inc eax
    loop asm_strrev2_loop

    leave
    ret

; MULTIPLICATION TABLE
asm_multab:
    enter 0,0

    mov eax, 0
    mov ebx, 0 ; array index
    mov ecx, 10 ; step count

asm_multab_loop:
    add eax, dword [asm_multab_num]
    mov [asm_multab_tab + 4 * ebx], eax
    inc ebx
    loop asm_multab_loop

    leave
    ret

; DIVIDE BY TWO LIST
asm_divtwo:
    enter 0,0

    mov ecx, [asm_divtwo_num]
    mov ebx, 0 ; array index

asm_divtwo_loop:
    jcxz asm_divtwo_end

    mov [asm_divtwo_tab + 4 * ebx], ecx ; store number to array

    mov edx, 0
    mov eax, ecx ; divident
    mov ecx, 2 ; dividing by 2
    div ecx
    
    inc ebx
    mov ecx, eax
    jmp asm_divtwo_loop

asm_divtwo_end:
    leave
    ret

; FACTORIAL LIST TABLE
asm_faclist:
    enter 0,0

    mov eax, 1 ; init
    mov ebx, 0 ; array index
    mov ecx, 10 ; step count
    mov [asm_faclist_mul], dword 1

asm_mulfaclist_loop:
    mul dword [asm_faclist_mul]
    mov [asm_faclist_tab + 4 * ebx], eax
    inc ebx
    inc dword [asm_faclist_mul]
    loop asm_mulfaclist_loop

    leave
    ret

next_fnc:
    enter 0,0

    leave
    ret
