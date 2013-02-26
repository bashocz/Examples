    bits 32

    section .data


    section .text

; PUBLIC LABELS
global asm_sum, asm_findmax, asm_removechar, asm_sort, asm_strtoint


asm_sum:
    enter 0,0

    push ebx
    push ecx
    push edi
    push esi

    mov esi,[ebp + 8]
    mov ecx,[ebp + 12]
    mov eax,0
    mov ebx,0
    mov edi,0

sum_loop:
    mov eax,[esi + ecx*4 - 4]
    cdq
    add ebx,eax
    adc edi,edx
    loop sum_loop

    mov eax,ebx
    mov edx,edi

    pop esi
    pop edi
    pop ecx
    pop ebx

    leave
    ret


asm_findmax:
    enter 0,0

    push ebx
    push ecx
    push esi

    mov esi,[ebp + 8]
    mov ecx,[ebp + 12]
    mov eax,0
    mov edx,0

findmax_loop:
    mov ebx,[esi + ecx*4 - 4]
    cmp eax,ebx
    jge findmax_less
    mov eax,ebx
findmax_less:
    loop findmax_loop

    pop esi
    pop ecx
    pop ebx

    leave
    ret


asm_removechar:
    enter 0,0

    push ecx
    push edi
    push esi

    mov esi,[ebp + 8]
    mov edi,esi
    mov dl,[ebp + 12]
    mov ecx,0

removechar_loop:
    mov cl,[esi]
    inc esi
    cmp cl,dl
    jz removechar_remove

    mov [edi],cl
    inc edi

removechar_remove:
    jcxz removechar_end
    jmp removechar_loop

removechar_end:
    pop esi
    pop edi
    pop ecx

    leave
    ret


asm_sort:
    enter 0,0

    push ebx

    mov eax,[ebp + 8]
    mov ebx,[ebp + 12]
    call sort_compare

    mov eax,[ebp + 8]
    mov ebx,[ebp + 16]
    call sort_compare

    mov eax,[ebp + 12]
    mov ebx,[ebp + 16]
    call sort_compare

    pop ebx

    leave
    ret

sort_compare:
    push ecx
    push edx

    mov ecx,[eax]
    mov edx,[ebx]
    
    cmp ecx,edx
    jge sort_compare_end
    
    mov [eax],edx
    mov [ebx],ecx

sort_compare_end:
    pop edx
    pop ecx

    ret


asm_strtoint:
    enter 0,0

    push ebx
    push ecx
    push esi

    mov esi,[ebp + 8]
    mov ecx,0
    mov eax,0
    mov ebx,10

strtoint_loop:
    mov cl,[esi]
    jcxz strtoint_end

    mul ebx
    sub cl,48
    add eax,ecx

    inc esi
    jmp strtoint_loop

strtoint_end:
    pop esi
    pop ecx
    pop ebx

    leave
    ret
