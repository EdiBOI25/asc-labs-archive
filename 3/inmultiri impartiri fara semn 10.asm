;Înmulțiri, împărțiri - Interpretare fara semn
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
        mov ah, 0 ; conversie fara semn
        mul word[b]; DX:AX = AX * b = a * b
        
        mov bx, 7
        mov cx, 0 ; CX:BX = 7
        sub bx, ax ; BX = BX - AX = 7 - a*b
        sbb dx, cx ; CX = CX - DX - CF
        ; CX:BX = 7-a*b
        
        add bx, [c] ; BX = BX + c
        adc cx, 0 ; adunam CF in CX
        ; CX:BX = 7 - a * b + c
        
        mov ax, bx
        mov dx, cx
        ; DX:AX = (7-a*b+c)
        mov bl, [a]
        mov bh, 0 ; conversie fara semn
        div bx ; AX = DX:AX / BX ; DX = DX:AX % BX
        ; AX = (7 - a * b + c) / a
        
        mov ebx, 0
        mov bx, ax ; BX = AX = (7 - a * b + c) / a
        mov eax, [d]
        sub eax, ebx ; EAX = EAX - EBX
        ; EAX = d - (7 - a * b + c) / a
        sub eax, 6 ; EAX = d - (7 - a * b + c) / a - 6
        
        push EAX ; EAX in stiva
        
        mov eax, dword[x]
        mov edx, dword[x+4] ; EDX:EAX = x
        mov ebx, 2
        div ebx ; EAX = EDX:EAX / EBX  ;  EDX = EDX:EAX % EBX
        ; EAX = x / 2
        
        pop ebx ; EBX = d - (7 - a * b + c) / a - 6
        add eax, ebx
        adc edx, 0
        ; EAX = d - (7 - a * b + c) / a - 6 + x / 2
        
        
        push dword 0
        call [exit]