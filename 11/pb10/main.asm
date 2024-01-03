bits 32
global start

extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

extern read_strings, find_substring

segment data use32
    strings_nr db 5
    ok_message db 'First string found in every other string', 13, 10, 0
    not_ok_message db 'First string not found in every other string', 13, 10, 0
    strings times 5 * 100 db 0
    found dd -10
    current_string dd 0
    format_dec db '%d', 13, 10, 0
    format_curent db 'Current string: %s. Is substring in it: ', 0

segment code use32 public code
start:
    ; read 5 strings
    ; read_strings(strings_nr, strings)
    push dword strings
    mov eax, 0
    mov al, [strings_nr]
    push eax
    call read_strings
    
    ; loop through all strings
    mov ecx, 4
    mov eax, strings ; strings[0]
    mov [current_string], eax
    jecxz final
    compare_loop:
        push ecx
        mov eax, [current_string]
        add eax, 100
        mov [current_string], eax ; next string
        
        push dword [current_string]
        push dword format_curent
        call [printf]
        add esp, 8
        
        ; find_substring(string1, string2, found)
        push dword found
        push dword [current_string]
        push dword strings
        call find_substring
        
        push dword [found]
        push dword format_dec
        call [printf]
        add esp, 8
        
        
        mov eax, 0
        mov eax, [found]
        cmp eax, 0
        je not_found
        
        pop ecx
        loop compare_loop
    
    
    is_found:
        push dword ok_message
        call [printf]
        add esp, 4
        jmp final
    
    not_found:
        push dword not_ok_message
        call [printf]
        add esp, 4
    
final:
    push dword 0
    call [exit]
