bits 32
global start
extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32
    s db 1, 4, 2, 3, 8, 4, 9, 5
    len equ $-s
    max_poz_pare db 0
    min_poz_impare db 15
    
    format db 'Max pozitii pare: %d. Min pozitii impare: %d', 13, 10, 0

segment code use32
start:
    mov esi, 0
    mov ecx, len
    jecxz final
    array_loop:
        mov eax, 0
        mov al, [s + esi]
        test esi, 01h
        jz poz_para
    
    ; poz_impara:        
        cmp al, [min_poz_impare]
        jnl after_check
        mov [min_poz_impare], al        
        jmp after_check

    poz_para:
        cmp al, [max_poz_pare]
        jng after_check
        mov [max_poz_pare], al
        
    after_check:
        inc esi
        loop array_loop
        
    mov eax, 0
    mov al, [min_poz_impare]
    push eax
    mov eax, 0
    mov al, [max_poz_pare]
    push eax
    push dword format
    call [printf]
    add esp, 12

final:
    push dword 0
    call [exit]