;10. Sa se inlocuiasca bitii 0-3 ai octetului B cu bitii 8-11 ai cuvantului A.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 1010101010010110b ; = AA96h
    b db 10110101b ; = B5h
    ; b devine 101101010b = BAh

; our code starts here
segment code use32 class=code
    start:
        mov bx, 0 ; calculam rezultatul in BX
        
        mov ax, [a]
        and ax, 0000111100000000b ; izolam bitii 8-11 ai lui A
        mov cl, 8
        shr ax, cl ; shiftam bitii spre dreapta
        or bx, ax ; momentan in bl e 0000[bitii 8-11 ai lui a]
        
        mov al, [b]
        and al, 11110000b ; izolam bitii 4-7 ai lui b
        or bl, al ; bl = [bitii 4-7 ai lui b][bitii 8-11 ai lui a]
        
        mov [b], bl ; rezultat final
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
