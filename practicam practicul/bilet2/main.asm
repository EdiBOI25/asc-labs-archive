bits 32

global start

extern exit, fopen, fclose, printf, fread
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
import fread msvcrt.dll

segment data use32 class=data
    file_descriptor dd -1
    file_name db 'input.txt', 0
    access_read db 'r', 0
    
    digits times 100 db 0
    print_format db '%X - %d', 13, 10, 0
    
    print_string db '%s', 13, 10, 0
    print_dec db '%d', 13, 10, 0


segment code use32 class=code
start:
    ; open file
    push dword access_read
    push dword file_name
    call [fopen]
    add esp, 8
    ; check for errors
    cmp eax, 0
    je exit_program
    mov [file_descriptor], eax
    
    ; read digits
    push dword [file_descriptor]
    push dword 100
    push dword 1
    push dword digits
    call [fread]
    add esp, 16
    
    ; loop through digits
    mov esi, 0
    .digits_loop:
        mov eax, 0
        mov al, [digits + esi]
        
        ; end of digits
        cmp al, 0
        je .after_digits_loop
        
        ; space character -> next digit
        cmp al, ' '
        je .next_digit
        
        
        
        ; check if digit is [A, F]
        cmp al, 'A'
        jb .not_letter
        ; 'C' - 'A' + 10 = 12 (hex -> dec)
        sub al, 'A'
        add al, 10
        jmp .after_transf
        
        .not_letter:
        ; '3' - '0' = 3 (str -> dec)
        sub al, '0'
        
        .after_transf:
        push eax ; save digit in str form
        ; find no. of bits
        mov ebx, 0
        mov ecx, 4
        .bits_loop:
            shr al, 1
            adc ebx, 0
            loop .bits_loop
        
        pop eax ; digit in str form
        push ebx
        push eax
        push dword print_format
        call [printf]
        add esp, 12
        
        .next_digit:
        inc esi
        jmp .digits_loop
    
    .after_digits_loop:

    
    ; close file
    push dword [file_descriptor]
    call [fclose]
    add esp, 4


exit_program:
    push dword 0
    call [exit]