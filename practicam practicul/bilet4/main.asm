bits 32
global start

extern exit, fopen, fclose, scanf, printf, fscanf, fprintf
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
import fscanf msvcrt.dll
import fprintf msvcrt.dll


segment data use32 class=data
    in_file resb 100
    access_read db 'r', 0
    in_desc dd -1
    
    out_file db 'output.txt', 0
    access_write db 'w', 0
    out_desc dd -1
    
    char db 0
    buffer resb 100
    
    format_read_str db '%s', 0
    format_read_char db '%c', 0
    format_print_str db '%s', 10, 0

segment code use32 class=code
start:
    ; read input file name
    push dword in_file
    push dword format_read_str
    call [scanf]
    add esp, 8
    
    ; read null/endl? character (remained from string)
    push dword char
    push dword format_read_char
    call [scanf]
    add esp, 8
    
    ; read character
    push dword char
    push dword format_read_char
    call [scanf]
    add esp, 8

    ; open input file
    push dword access_read
    push dword in_file
    call [fopen]
    add esp, 8
    cmp eax, 0
    je final
    mov [in_desc], eax
    
    ; open output file
    push dword access_write
    push dword out_file
    call [fopen]
    add esp, 8
    cmp eax, 0
    je .close_input_file
    mov [out_desc], eax
    
    ; loop through words from file
    .input_file_loop:
        ; read word from file
        push dword buffer
        push dword format_read_str
        push dword [in_desc]
        call [fscanf]
        add esp, 12
        cmp eax, -1 ; no more words to read
        je .after_input_file_loop
        
        ; check if character char is in word
        mov esi, 0
        .check_loop:
            mov eax, 0
            mov al, [char]
            cmp [buffer + esi], al
            je .go_to_next_word
            
            cmp [buffer + esi], byte 0 ; end of word
            je .print_word
            
            inc esi
            jmp .check_loop
            
        .print_word:
        push dword buffer
        push dword format_print_str
        push dword [out_desc]
        call [fprintf]
        add esp, 12
        
        .go_to_next_word:
        jmp .input_file_loop
        
    .after_input_file_loop:
    
    .close_out_file:
    push dword [out_desc]
    call [fclose]
    add esp, 4
    
    .close_input_file
    push dword [in_desc]
    call [fclose]
    add esp, 4

final:
    push dword 0
    call [exit]