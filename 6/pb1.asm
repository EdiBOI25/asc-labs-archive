bits 32
global start
extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32
    s1 dd 127F5678h, 0ABCDABCDh
    len1 equ ($ - s1) / 4
    s2 times len1 dd 0
    format db 'Sirul 2: %x, %x', 13, 10, 0

segment code use32
start:
    mov esi, s1
    mov edi, s2
    mov ecx, len1
    jecxz final
    cld
    big_loop:
        mov eax, 0
        lodsw
        mov ebx, 0
        mov edx, 0
        mov bl, al
        mov dl, ah
        
        lodsw
        add bl, al
        adc bh, 0
        add dl, ah
        adc dh, 0
        
        mov ax, bx
        test ah, 01h
        jz not_signed1
        cbw
        not_signed1:
        stosw
        
        
        mov ax, dx
        test ah, 01h
        jz not_signed2
        cbw
        not_signed2:
        stosw
        
        loop big_loop
        
    push dword [s2 + 4]
    push dword [s2]
    push dword format
    call [printf]
    add esp, 12
final:
    push dword 0
    call [exit]