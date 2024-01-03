bits 32
global start
extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32
    s1 dw 1432h, 8675h, 0ADBCh
    len1_bytes equ $ - s1
    s2 times len1_bytes / 2 dd 0
    format db 'S2: %x, %x, %x', 13, 10, 0
    

segment code use32
start:
    ; EXPAND NIBBLES TO BYTES
    mov esi, s1
    mov edi, s2
    mov ecx, len1_bytes
    jecxz final
    cld
    expand_nibbles_loop:
        mov eax, 0
        lodsb ; al = 32h
        shl ax, 4 ; ax = 0320h
        shr al, 4 ; ax = 0302h
        stosw
    loop expand_nibbles_loop
    
    ; SORT S2
    mov ecx, len1_bytes / 2 ; nr of dwords
    jecxz final
    mov ebx, s2 ; address of s2
    ; we sort each dword of s2
    sort_s2:
        push ecx
        
        mov ecx, 4
        mov esi, 0 ; s2[i]
        sort_loop_big:
            push ecx
            
            mov ecx, 4
            mov edi, 0 ; s2[j]
            sort_loop_small:
                push ecx
                mov al, [ebx + esi] ; al = a[i]
                mov dl, [ebx + edi] ; dl = a[j]
                cmp al, dl ; al < dl ?
                jb no_swap
                
                mov [ebx + esi], dl ; swap
                mov [ebx + edi], al
                
                no_swap:
                pop ecx
                inc edi ; j++
                loop sort_loop_small
                
            pop ecx
            inc esi ; i++
            loop sort_loop_big
            
        pop ecx
        add ebx, 4 ; next dword
        loop sort_s2
    
    ; PRINT S2
    push dword [s2 + 8]
    push dword [s2 + 4]
    push dword [s2]
    push dword format
    call [printf]
    add esp, 16
    
final:
    push dword 0
    call [exit]