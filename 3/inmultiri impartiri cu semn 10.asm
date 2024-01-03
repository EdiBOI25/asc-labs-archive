;Înmulțiri, împărțiri - Interpretare cu semn
;10. d-(7-a*b+c)/a-6+x/2
; a,c-byte; b-word; d-doubleword; x-qword
bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 2
    c db 1
    b dw 1
    d dd 1
    x dq 4
    
segment code use32 class=code
    start:
        ;d - (7 - a * b + c) / a - 6 + x / 2
        mov al, [a]
        cbw ; AL -> AX
        imul word[b]; DX:AX = AX * b = a * b
        
        mov bx, 7
        mov cx, 0 ; CX:BX = 7
        sub bx, ax ; BX = BX - AX = 7 - a*b
        sbb dx, cx ; CX = CX - DX - CF
        ; CX:BX = 7-a*b
        
        add bx, [c] ; BX = BX + c
        adc cx, 0 ; adunam CF in CX
        ; CX:BX = 7 - a * b + c
        
        mov al, [a]
        cbw ; AL -> AX = a
        push ax ; AX in stiva
        
        mov ax, bx
        mov dx, cx
        ; DX:AX = (7-a*b+c)
        pop bx ; BX = a (din stiva)
        idiv bx ; AX = DX:AX / BX ; DX = DX:AX % BX
        ; AX = (7 - a * b + c) / a
        
        cwde ; AX -> EAX = (7 - a * b + c) / a
        
        mov ebx, [d]
        sub ebx, eax ; EBX = EBX - EAX
        ; EBX = d - (7 - a * b + c) / a
        sub ebx, 6 ; EBX = d - (7 - a * b + c) / a - 6
        
        mov eax, dword[x]
        mov edx, dword[x+4] ; EDX:EAX = x
        mov ecx, 2
        idiv ecx ; EAX = EDX:EAX / ECX  ;  EDX = EDX:EAX % ECX
        ; EAX = x / 2
        
        add eax, ebx
        adc edx, 0
        ; EAX = d - (7 - a * b + c) / a - 6 + x / 2
        
        
        push dword 0
        call [exit]