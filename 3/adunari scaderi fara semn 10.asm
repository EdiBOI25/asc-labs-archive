; a - byte, b - word, c - double word, d - qword - Interpretare fara semn
; 10. (a+d+d)-c+(b+b)
bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 1
    b dw 1
    c dd 1
    d dq 1
    
segment code use32 class=code
    start:
        mov eax, 0
        mov al, [a] ; AL = a
        add eax, dword[d]
        adc edx, dword[d+4]
        ; EDX:EAX = a + d
        
        add eax, dword[d]
        adc edx, dword[d+4]
        ; EDX:EAX = a + d + d
        
        sub eax, [c]
        sbb edx, 0
        ; EDX:EAX = (a + d + d) - c
        
        mov ebx, 0
        mov bx, [b]
        add bx, [b] ; BX = b + b
        
        add eax, ebx
        adc edx, 0
        ; EDX:EAX = (a + d + d) - c + (b + b)
        
        
        push dword 0
        call [exit]