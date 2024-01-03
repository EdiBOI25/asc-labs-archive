; a - byte, b - word, c - double word, d - qword - Interpretare cu semn
; b+c+d+a-(d+c)

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
        mov eax, [c] ; EAX = c
        cdq ; EAX -> EDX:EAX (conversie cu semn)
        add eax, dword[d]
        adc edx, dword[d+4]
        ; EDX:EAX = d + c
        
        push edx
        push eax
        ; EDX:EAX in stiva
        
        mov ax, [b] ; AX = b
        cwde ; AX -> EAX (conversie cu semn)
        add eax, [c] ; EAX = EAX + c = b + c
        
        add eax, dword[d]
        adc edx, dword[d+4]
        ; EDX:EAX = b + c + d
        
        mov bl, [a] ; BL = a
        cbw ; BL -> BX
        cwde ; BX -> EBX
        add eax, ebx
        adc edx, 0
        ; EDX:EAX = b + c + d + a
        
        pop ebx
        pop ecx
        ; ECX;EBX = d + c
        
        sub eax, ebx
        sbb edx, ecx
        ; EDX:EAX = b+c+d+a-(d+c)
        
        
        push dword 0
        call [exit]