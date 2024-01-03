; E = a + b / c - d * 2 - e
; a - double
; b, d - byte
; c - word
; e - quad

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 125 ; 125 - 4 octeti
    b db 2 ; 02h - 1 octet
    c dw 15 ; 00 0Fh - 2 octet
    d db 200 ; 100 = 64h = 0110 0100b => 200 = 100 * 2 = (mutam bitul la stanga) 1100 1000b
    e dq 80 ; 8 octeti

; our code starts here
segment code use32 class=code
    start:
        ; a + b / c - d * 2 - e
        mov al, [b] ; AL = b = 02h
        mov ah, 0 ; extindem fara semn ; AX = 00 02h
        mov dx, 0 ; extindem in double: DX:AX = 0000 0002h
        div word [c] ; impartire pe 16 biti (de aia e word): DX:AX / c => AX <- cat , DX <- rest
        
        mov bx, ax ; BX = AX pt ca inmultirea se face automat in AL, deci eliberam AX
        mov al, 2 ; AL = 2
        mul byte[d] ; AX = AL * d = d * 2
        
        sub bx,ax ; bx = bx - ax
        
        mov cx, 0 ; extindem BX in CX:BX
        ; vrem sa il aducem pe a (doubleword) in DX:AX
        mov ax, word[a] ; primii 2 octeti
        mov dx, word[a+2] ; ultimii 2 octeti
        
        add ax, bx ; adunare pe perechi/jumatati
        adc dx, cx
        
        push dx 
        push ax
        pop eax ; EAX <- DX:AX prin stiva
        
        ; e este quad, asa ca extindem pe EDX:EAX
        mov edx, 0
        sub eax, dword[e] ;scadem pe jumatati/perechi
        sbb edx, dword[e+4]
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
