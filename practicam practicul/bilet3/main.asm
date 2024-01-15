;Se da in data segment un sir de 10 caract si numele unui fisier
;Fisierul dat contine un nr de la 0-9.
; Sa se citeasca acel nr, sa se creeze n fisiere cu numele output-i.txt
; Sa se scrie in fiecare fisier ultimele [i+1] caract din sirul dat in ordine inversa.

bits 32

global start

extern exit, fopen, fclose, fscanf, fprintf, printf
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fscanf msvcrt.dll
import fprintf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    text db 'abcdefghij', 0
    input_file_name db 'input.txt', 0
    access_read db 'r', 0
    input_file_desc dd -1
    n dd 0
    
    output_file_name db 'output-i.txt', 0
    access_write db 'w', 0
    output_file_desc dd -1
    i_position equ 7
    reverse_text resb 10
    
    format_dec db '%d', 0
    format_str db '%s', 0

segment code use32 class=code
start:
    ; open input file
    push dword access_read
    push dword input_file_name
    call [fopen]
    add esp, 8
    cmp eax, 0
    je .exit_program
    mov [input_file_desc], eax
    
    ; read number from file
    push dword n
    push dword format_dec
    push dword [input_file_desc]
    call [fscanf]
    add esp, 8
    
    ; create output files
    mov edi, 0 ; index for reverse_text ; also serves as "i" from problem
    mov ecx, [n]
    jecxz .close_input_file
    .create_files_loop:
        push ecx
        ; move "i" and place it in file name
        mov eax, edi
        add eax, '0'
        mov [output_file_name + i_position], al
        
        
        ; create/open file
        push dword access_write
        push dword output_file_name
        call [fopen]
        add esp, 8
        cmp eax, 0
        je .after_create_files_loop
        mov [output_file_desc], eax
        
        ; add letter to reverse_text
        mov eax, 0
        lea eax, [text + 9]
        sub eax, edi
        mov al, [eax] ; al = text[9 - edi]
        mov [reverse_text + edi], al ; reverse_text[edi] = al
        inc edi
        
        push dword reverse_text
        push dword format_str
        push dword [output_file_desc]
        call [fprintf]
        add esp, 12
        
        ; close output file
        push dword [output_file_desc]
        call [fclose]
        add esp, 4
        
        pop ecx
        loop .create_files_loop
    
    .after_create_files_loop:
    
    
    .close_input_file:
    push dword [input_file_desc]
    call [fclose]
    add esp, 4

.exit_program:
    push dword 0
    call [exit]