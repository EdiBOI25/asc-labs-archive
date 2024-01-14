bits 32

global start

extern exit, printf, scanf, fprintf, fopen, fclose
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import fopen msvcrt.dll


segment data use32 class=data
    file_name db 'bilet1_output.txt', 0
    file_descriptor dd -1
    access_mode_write db 'w', 0
    
    n dd 0
    string times 100 db 0
    format_read_dec db '%d', 0
    format_read_str db '%s', 0
    format_print_str db '%s', 10, 0


segment code use32 class=code
start:
    ; open file
    push dword access_mode_write
    push dword file_name
    call [fopen]
    add esp, 8
    ; check for errors
    cmp eax, 0
    je .exit_program
    mov [file_descriptor], eax

    ; read no. of strings
    push dword n
    push dword format_read_dec
    call [scanf]
    add esp, 8
    
    .read_strings_loop:
        ; read string
        push dword string
        push dword format_read_str
        call [scanf]
        add esp, 8
        
        ; check if chr is #
        cmp [string], byte '#'
        je .after_read_loop
        
        mov eax, 0 ; eax = number of vowels
        mov esi, 0
        .vowel_loop:
            ; check if we reached the end of the word
            cmp [string + esi], byte 0
            je .after_vowel_loop
            
            ; check if letter is vowel
            cmp byte [string + esi], 'a'
            je .is_vowel
            cmp byte [string + esi], 'e'
            je .is_vowel
            cmp byte [string + esi], 'i'
            je .is_vowel
            cmp byte [string + esi], 'o'
            je .is_vowel
            cmp byte [string + esi], 'u'
            je .is_vowel
            cmp byte [string + esi], 'A'
            je .is_vowel
            cmp byte [string + esi], 'E'
            je .is_vowel
            cmp byte [string + esi], 'I'
            je .is_vowel
            cmp byte [string + esi], 'O'
            je .is_vowel
            cmp byte [string + esi], 'U'
            je .is_vowel
            jmp .after_check
            .is_vowel:
            inc eax
            
            .after_check:
            inc esi
            jmp .vowel_loop
        
        .after_vowel_loop:
        ; check if no. of vowels is above n
        cmp eax, [n]
        jb .after_check_number
        
        ; printf word in file
        push dword string
        push dword format_print_str
        push dword [file_descriptor]
        call [fprintf]
        add esp, 12
        
        .after_check_number
        
        ; repeat read_loop
        jmp .read_strings_loop
        
    .after_read_loop:
    
    ; close file
    push dword [file_descriptor]
    call [fclose]
    add esp, 4

.exit_program:
    push dword 0
    call [exit]