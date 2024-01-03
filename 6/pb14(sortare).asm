bits 32
global start
extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32
    s dd 12345607h, 1A2B3C15h
    len_s_bytes equ $ - s
    d times len_s_bytes db 0
    format db '%X ', 0
    format2 db '%X < %X?', 13, 10, 0

segment code use32
start:
    ; copy bytes from s to d
    mov ecx, len_s_bytes
    mov esi, s
    mov edi, d
    cld
    ;jecxz final
    copy_loop:
        mov eax, 0
        lodsb
        stosb
    loop copy_loop
    
    ; sort d
    mov ecx, len_s_bytes
    ;jecxz final
    mov esi, 0
    mov eax, 0
    mov edx, 0
    sort_loop_big:
        push ecx
        mov edi, esi
        sort_loop_small:
            mov al, [d + esi]
            mov dl, [d + edi]
            
            cmp al, dl
            jb no_swap
            
            mov [d + esi], dl
            mov [d + edi], al
            
            no_swap:            
            inc edi
            cmp edi, len_s_bytes
            jne sort_loop_small
        
        pop ecx
        inc esi
    loop sort_loop_big
    
    ; print d
    mov ecx, len_s_bytes
    jecxz final
    mov esi, 0
    print_loop:
        push ecx
        mov eax, 0
        mov al, [d + esi]
        push eax
        push format
        call [printf]
        add esp, 8
        inc esi
        pop ecx
    loop print_loop

final:
    push dword 0
    call [exit]