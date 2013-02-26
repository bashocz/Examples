    bits 32

    section .data

    section .text

    global add_int64_int64
    global mul_int64_int64
    global div_int64_int32

    global div_intN_int32
    global add_intN_int32
    global mul_intN_int32

add_int64_int64:
    enter 0,0

    mov eax, [ebp + 8]  ;La
    add eax, [ebp + 16] ;Lb
    mov edx, [ebp + 12] ;Ha
    adc edx, [ebp + 20] ;Hb

    leave
    ret

mul_int64_int64:
    enter 0,0

    push ebx
    push ecx

    mov eax, [ebp + 8]   ;La
    mul dword [ebp + 16] ; * Lb
    mov ebx, eax
    mov ecx, edx

    mov eax, [ebp + 8]   ; La
    mul dword [ebp + 20] ; * Hb
    add ecx, eax
    ; forget edx

    mov eax, [ebp + 12]  ; Ha
    mul dword [ebp + 16] ; * Lb
    add ecx, eax
    ; forget edx

    mov eax, ebx
    mov edx, ecx

    pop ecx
    pop ebx

    leave
    ret

div_int64_int32:
    enter 0,0

    push ebx

    mov edx, 0
    mov eax, [ebp + 12]  ; Ha
    div dword [ebp + 16] ; / b
    mov ebx, eax
    ; remember edx (rest) to the next step

    mov eax, [ebp + 8]   ; La
    div dword [ebp + 16] ; / b

    mov edx, ebx

    pop ebx

    leave
    ret

div_intN_int32:
    enter 0,0

    push ebx
    push ecx

    mov ecx,[ebp + 12] ; N
    mov ebx,[ebp + 8]  ; x

    mov edx,0
zpet:
    mov eax,[ebx + ecx * 4 - 4]
    div dword [ebp + 16]
    mov [ebx + ecx * 4 - 4], eax
    loop zpet

    mov eax, edx ; rest

    pop ecx
    pop ebx

    leave
    ret

add_intN_int32:
    enter 0,0

    push ebx
    push ecx

    mov ecx,[ebp + 12] ; N
    mov ebx,[ebp + 8]  ; x

    mov eax,[ebp + 16] ; y
    add [ebx], eax     ; x[0] += y
    
    dec ecx
    mov eax, 1
zpet2:
    jnc konec ; optimization whether cf disappaered
    adc [ebx + eax * 4], dword 0 ; x[eax] += cf
    inc eax
    loop zpet2

konec:
    pop ecx
    pop ebx

    leave
    ret

mul_intN_int32:
    enter 0,0

    push ebx
    push ecx
    push edi
    push esi

    mov ecx, [ebp + 12] ; N
    mov ebx, [ebp + 8]  ; x

    mov edi, 0
    mov esi, 0
    clc ; clear cf

zpet3:
    mov eax, [ebx + esi * 4]
    pushf
    mul dword [ebp + 16] ; x[esi] * y
    popf
    adc eax, edi ; addition with cf
    mov edi, edx
    mov [ebx + esi * 4], eax
    inc esi
    loop zpet3

    pop esi
    pop edi
    pop ecx
    pop ebx

    leave
    ret


