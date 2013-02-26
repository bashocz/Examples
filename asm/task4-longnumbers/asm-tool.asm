    bits 32

    section .data

    section .text

    global add_int64_int64
    global mul_int64_int64
    global div_int64_int32

    global div_intN_int32
    global add_intN_int32
    global mul_intN_int32

    global shl_intN
    global shr_intN
    global shld_intN
    global shrd_intN

    global add_intN_intN
    global sub_intN_intN


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
    ; zahazuji edx

    mov eax, [ebp + 12]  ; Ha
    mul dword [ebp + 16] ; * Lb
    add ecx, eax
    ; zahazuji edx

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
    ; necham edx (zbytek) do dalsiho kola

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
    mov ebx,[ebp + 8]  ; *n

    mov edx,0
zpet:
    mov eax,[ebx + ecx * 4 - 4]
    div dword [ebp + 16]
    mov [ebx + ecx * 4 - 4], eax
    loop zpet

    mov eax, edx ; zbytek

    pop ecx
    pop ebx

    leave
    ret

add_intN_int32:
    enter 0,0

    push ebx
    push ecx

    mov ecx,[ebp + 12] ; N
    mov ebx,[ebp + 8]  ; *n

    mov eax,[ebp + 16] ; y
    add [ebx], eax     ; n[0] += y
    
    dec ecx
    mov eax, 1
zpet2:
    jnc konec ; optimalizace pokud cf zmizi
    adc [ebx + eax * 4], dword 0 ; N[eax] += cf
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
    mov ebx, [ebp + 8]  ; *n

    mov edi, 0
    mov esi, 0
    clc ; nulovani cf

zpet3:
    mov eax, [ebx + esi * 4]
    pushf
    mul dword [ebp + 16] ; x[esi] * y
    popf
    adc eax, edi ; scitani vcetne cf
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

shl_intN:
    enter 0,0

    push ebx
    push ecx

    mov ecx, [ebp + 12] ; N
    mov ebx, [ebp + 8]  ; *n
    mov edx, 0
    clc ; nulovani cf

zpet4:
    rcl dword[ebx + edx * 4], 1
    inc edx
    loop zpet4

    ; adc [ebx], 0 ; rotace...

    pop ecx
    pop ebx

    leave
    ret

shr_intN:
    enter 0,0

    push ebx
    push ecx

    mov ecx, [ebp + 12] ; N
    mov ebx, [ebp + 8]  ; *n
    clc ; nulovani cf

zpet5:
    rcr dword[ebx + ecx * 4 - 4], 1
    loop zpet5

    pop ecx
    pop ebx

    leave
    ret

shld_intN:
    enter 0,0

    push ebx
    push ecx
    push edi

    mov edi, [ebp + 12] ; N
    mov ebx, [ebp + 8]  ; *n
    mov ecx, [ebp + 16] ; o kolik bitu

zpet6:
    dec edi
    cmp edi, 0
    jz konec1
    mov edx, [ebx + edi * 4 - 4]
    shld [ebx + edi * 4], edx, cl
    jmp zpet6

konec1:
    mov edx, 0
    shld [ebx], edx, cl

    pop edi
    pop ecx
    pop ebx

    leave
    ret

shrd_intN:
    enter 0,0

    push ebx
    push ecx
    push edi

    mov edi, [ebp + 12] ; N
    mov ebx, [ebp + 8]  ; *n
    mov ecx, [ebp + 16] ; o kolik bitu
    mov eax, 0

zpet7:
    dec edi
    cmp edi, 0
    jz konec2
    mov edx, [ebx + eax * 4 + 4]
    shrd [ebx + eax * 4], edx, cl
    inc eax
    jmp zpet7

konec2:
    mov edx, 0
    shrd [ebx + eax * 4], edx, cl

    pop edi
    pop ecx
    pop ebx

    leave
    ret

add_intN_intN:
    enter 0,0

    push ebx
    push ecx
    push edi
    push esi

    mov edi,[ebp + 8]  ; *n1
    mov esi,[ebp + 12] ; *n2
    mov ecx,[ebp + 16] ; N

    mov eax, [esi]     ; n2[0]
    add [edi], eax     ; n1[0] += n2[0]
    dec ecx            ; N - 1

    mov ebx, 1
zpet8:
    mov eax, [esi + ebx * 4]
    adc [edi + ebx * 4], eax ; n1[eax] += n2[ebx] + cf
    inc ebx
    loop zpet8

    pop esi
    pop edi
    pop ecx
    pop ebx

    leave
    ret

sub_intN_intN:
    enter 0,0

    push ebx
    push ecx
    push edi
    push esi

    mov edi,[ebp + 8]  ; *n1
    mov esi,[ebp + 12] ; *n2
    mov ecx,[ebp + 16] ; N

    mov eax, [esi]     ; n2[0]
    sub [edi], eax     ; n1[0] += n2[0]
    dec ecx            ; N - 1

    mov ebx, 1
zpet9:
    mov eax, [esi + ebx * 4]
    sbb [edi + ebx * 4], eax ; n1[eax] += n2[ebx] + cf
    inc ebx
    loop zpet9

    pop esi
    pop edi
    pop ecx
    pop ebx

    leave
    ret


