;13. Dandu-se 4 octeti, sa se obtina in AX suma numerelor intregi reprezentate de bitii 4-6 ai celor 4 octeti.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;                bitii 4-6
    a db 00101001b ; 010
    b db 11001100b ; 100
    c db 10010010b ; 001
    d db 01010011b ; 101
    ;   suma lor e  1100

; our code starts here
segment code use32 class=code
    start:
        mov ax, 0 ; calculam rezultatul in AX
        
        mov bl, [a]
        and bx, 0000000001110000b ; izolam bitii 4-6 ai lui A
        mov cl, 4
        shr bx, cl ; shiftam bitii spre dreapta
        add ax, bx ; adaugam rezultatul in AX
        
        mov bl, [b]
        and bx, 0000000001110000b ; izolam bitii 4-6 ai lui B
        mov cl, 4
        shr bx, cl ; shiftam bitii spre dreapta
        add ax, bx ; adaugam rezultatul in AX
        
        mov bl, [c]
        and bx, 0000000001110000b ; izolam bitii 4-6 ai lui C
        mov cl, 4
        shr bx, cl ; shiftam bitii spre dreapta
        add ax, bx ; adaugam rezultatul in AX
        
        mov bl, [d]
        and bx, 0000000001110000b ; izolam bitii 4-6 ai lui D
        mov cl, 4
        shr bx, cl ; shiftam bitii spre dreapta
        add ax, bx ; adaugam rezultatul in AX
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
