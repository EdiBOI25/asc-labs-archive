;31. Se dau cuvintele A, B si C. Sa se formeze cuvantul D ca suma a numerelor reprezentate de:
;   biţii de pe poziţiile 1-5 ai lui A
;   biţii de pe poziţiile 6-10 ai lui B
;   biţii de pe poziţiile 11-15 ai lui C


bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;                        bitii din cerinta
    a dw 0011110100101001b ; 10100
    b dw 1000100011001100b ; 00011
    c dw 1101001010010010b ; 11010
    d resw 1 ;    suma este 110001

; our code starts here
segment code use32 class=code
    start:
        mov ax, 0 ; calculam rezultatul in AX
        
        mov bx, [a]
        and bx, 0000000000111110b ; izolam bitii 1-5 ai lui A
        mov cl, 1
        shr bx, cl ; shiftam bitii spre dreapta
        add ax, bx ; adaugam rezultatul in AX
        
        mov bx, [b]
        and bx, 0000011111000000b ; izolam bitii 6-10 ai lui B
        mov cl, 6
        shr bx, cl ; shiftam bitii spre dreapta
        add ax, bx ; adaugam rezultatul in AX
        
        mov bx, [c]
        and bx, 1111100000000000b ; izolam bitii 11-15 ai lui C
        mov cl, 11
        shr bx, cl ; shiftam bitii spre dreapta
        add ax, bx ; adaugam rezultatul in AX
        
        mov [d], ax
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
