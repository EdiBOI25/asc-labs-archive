;Se da un fisier text. Sa se citeasca continutul fisierului, sa se contorizeze numarul de consoane si sa se afiseze aceasta valoare. Numele fisierului text este definit in segmentul de date.
bits 32
global start

extern exit, printf, fread, fopen, fclose
import exit msvcrt.dll
import printf msvcrt.dll
import fread msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll

segment data use32
    file_name db 'input2.txt', 0
    file_access_mode db 'r', 0
    file_descriptor dd -1
    characters_read dd 0
    buffer_len equ 100
    buffer resb buffer_len+1
    
    number_of_consonants dd 0
    format db '%d', 0
    format_c db '%c', 0

segment code use32
start:
    ; open file
    push dword file_access_mode
    push dword file_name
    call [fopen]
    add esp, 8
    mov [file_descriptor], eax
    
    ; check if it exists
    cmp eax, 0
    je final
    
    ; read buffer
    read_loop:
        push dword [file_descriptor]
        push dword buffer_len
        push dword 1
        push dword buffer
        call [fread]
        add esp, 16
        cmp eax, 0 ; end of file
        je close_file
        mov [characters_read], eax
        
        ; loop through string
        mov ecx, [characters_read]
        mov esi, 0
        buffer_loop:
            mov eax, 0
            mov al, [buffer + esi]
            
            ; check if lowercase -> transform to uppercase
            cmp al, 'z'
            ja not_lowercase
            cmp al, 'a'
            jb not_lowercase
            sub al, 32
            not_lowercase:
            
            ; check if letter
            cmp al, 'Z'
            ja not_letter
            cmp al, 'A'
            jb not_letter
            
            ; check if vowel -> if not increase consonant count
            cmp al, 'A'
            je not_consonant
            cmp al, 'E'
            je not_consonant
            cmp al, 'I'
            je not_consonant
            cmp al, 'O'
            je not_consonant
            cmp al, 'U'
            je not_consonant
            inc byte [number_of_consonants]
            
            not_consonant:
            not_letter:
            inc esi
            loop buffer_loop
    
        ; clear buffer
        clear_buffer:
            mov edi, 0
            mov ecx, buffer_len
            clear:
                mov byte [buffer + edi], 0
                inc edi
                loop clear
        jmp read_loop
    
    
    ; close file
    close_file:
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
    ; print result
    push dword [number_of_consonants]
    push dword format
    call [printf]
    add esp, 8

final:
    push dword 0
    call [exit]