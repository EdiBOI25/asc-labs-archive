; Reads n strings
; read_strings(number of strings, string array address)

bits 32

extern scanf, printf
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32
    input_prompt db 'Enter string: ', 0
    string_format db '%s', 0

segment code use32 public code
global read_strings

read_strings:
    ; loop ecx times
    mov ecx, [esp + 4] ; number of strings
    mov edi, [esp + 8] ; address of first string
    
    jecxz final
    input_loop:
        push dword ecx
        ; print input prompt
        push dword input_prompt
        call [printf]
        add esp, 1 * 4
        
        ; input string
        push dword edi
        push dword string_format
        call [scanf]
        add esp, 2 * 4
        add edi, 100
        
        pop ecx
        loop input_loop
    
final:
    ret 2 * 4