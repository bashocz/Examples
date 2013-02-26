    bits 32

    section .data

extern float_min, float_max

%define idx(a,b) ((a) + (b)*4 - 4)
%define idx2(a,b) ((a) + (b)*4)

    section .text

    global fpuinit, asm_sum, asm_findmin, asm_findmax, asm_dev, asm_mulmatrix, asm_coslaw, asm_cos, asm_sqrt

fpuinit:
    finit
    ret

asm_sum:
    enter 0,0

    push ecx

    mov eax,[ebp + 8]
    mov ecx,[ebp + 12]

    fldz
sum_loop:
    fadd dword [idx(eax, ecx)]
    loop sum_loop

    pop ecx

    leave
    ret

asm_findmin:
    enter 4,0

    push ecx

    mov eax,[ebp + 8]
    mov ecx,[ebp + 12]

    fld dword [float_max]
findmin_loop:
    fld dword [idx(eax, ecx)]
    fcomi st1
    fcmovnb st1
    ffree st1
    loop findmin_loop

    pop ecx

    leave
    ret

asm_findmax:
    enter 0,0

    push ecx

    mov eax,[ebp + 8]
    mov ecx,[ebp + 12]

    fld dword [float_min]
findmax_loop:
    fld dword [idx(eax, ecx)]
    fcomi st1
    fcmovb st1
    ffree st1
    loop findmax_loop

    pop ecx

    leave
    ret

asm_dev:
    enter 0,0

    push ecx

    push dword [ebp + 12]
    push dword [ebp + 8]
    call asm_sum
    add esp, 8

    fidiv dword [ebp + 12]

    mov eax,[ebp + 8]
    mov ecx,[ebp + 12]

dev_loop:
    fld dword [idx(eax, ecx)]
    fsub st1
    fstp dword [idx(eax, ecx)]
    loop dev_loop

    pop ecx

    leave
    ret

asm_mulmatrix:
    enter 12,0 ; i, j, k

    mov edi,[ebp + 8]  ; m = m1 * m2
    mov esi,[ebp + 12] ; m1
    mov edx,[ebp + 16] ; m2
    mov ecx,[ebp + 20] ; N

    mov [ebp - 4], dword 0  ; i = 0
i_loop:
    mov [ebp - 8], dword 0  ; j = 0
j_loop:
    mov [ebp - 12], dword 0 ; k = 0
    fldz
k_loop:
    mov eax, dword [ebp - 4]  ; i
    mov ebx, dword [ebp - 12] ; k
    call matrix_index
    fld dword [idx2(esi,eax)]  ; m1[i, k]

    mov eax, dword [ebp - 12] ; k
    mov ebx, dword [ebp - 8]  ; j
    call matrix_index
    fld dword [idx2(edx,eax)]  ; m2[k, j]

    fmulp st1 ; m1[i, k] * m2[k, j]
    faddp st1 ; m[i, j] + ...

    inc dword[ebp - 12] ; k++
    cmp dword[ebp - 12], ecx
    jnz k_loop

    mov eax, dword [ebp - 4]  ; i
    mov ebx, dword [ebp - 8]  ; j
    call matrix_index
    fstp dword [idx2(edi,eax)]  ; m[i, j] = ...

    inc dword[ebp - 8] ; j++
    cmp dword[ebp - 8], ecx
    jnz j_loop

    inc dword[ebp - 4] ; i++
    cmp dword[ebp - 4], ecx
    jnz i_loop

    leave
    ret

matrix_index:
    push edx
    mul ecx          ; i * N
    add eax, ebx     ; i * N + j
    pop edx
    ret

asm_coslaw:
    enter 0,0

    fld dword [ebp + 8]  ; a
    fmul st0             ; a * a

    fld dword [ebp + 12] ; b
    fmul st0             ; b * b

    faddp st1            ; a^2 + b^2

    fld1
    fadd st0             ; 2
    fld dword [ebp + 8]  ; a
    fmulp st1            ; 2 * a
    fld dword [ebp + 12] ; b
    fmulp st1            ; 2 * a * b
    fld dword [ebp + 16] ; alpha
    fcos                 ; cos(alpha)
    fmulp st1            ; 2 * a * b * cos(alpha)

    fsubp st1            ; a^2 + b^2 - 2 * a * b * cos(alpha)
    fsqrt                ; sqrt(...)

    leave
    ret

asm_cos:
    enter 0,0

    fld dword [ebp + 8]
    fcos

    leave
    ret

asm_sqrt:
    enter 0,0

    fld dword [ebp + 8]
    fsqrt

    leave
    ret

asm_empty:
    enter 0,0

    leave
    ret


