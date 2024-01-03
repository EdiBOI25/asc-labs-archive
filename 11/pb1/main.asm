bits 32
global start

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

extern count_digits

segment data use32
    number dd 876543210
    digits dd 0
    power_of_ten dd 1
    
    format_digits db '%d: %d digits', 13, 10, 0
    format_dec_print db '%d', 13, 10, 0


segment code use32
start:
    ; get digits of number
    ; eax = count_digits(number)
    push dword [number]
    call count_digits
    
    mov [digits], eax
    
    ; print digits
    push dword [digits]
    push dword [number]
    push dword format_digits
    call [printf]
    add esp, 12
    
    ; find power of ten based off digits
    mov ecx, [digits]
    dec ecx
    jecxz final
    mov eax, 1
    mov edx, 0
    mov ebx, 10
    .multiply_loop:
        mul ebx
        loop .multiply_loop
    mov [power_of_ten], eax
    
    ; permutate digits
    mov ecx, [digits]
    dec ecx ; repeat digits-1 times
    jecxz final
    mov eax, [number]
    .permutate_loop:
        ; imparte la 10
        mov edx, 0 ; number -> edx:eax
        mov ebx, 10 ; number / 10
        div ebx ; cat in eax, rest in edx
        
        push eax
        
        mov eax, edx ; eax = last digit
        mov edx, 0
        mov ebx, [power_of_ten]
        mul ebx ; eax contains last_digit * 1000...
        
        mov edx, eax
        pop eax
        
        add eax, edx
        
        pushad
        
        push eax
        push dword format_dec_print
        call [printf]
        add esp, 8
        
        popad
    
    
        loop .permutate_loop
        
        

final:
    push dword 0
    call [exit]