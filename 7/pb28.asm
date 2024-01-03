bits 32
global start
extern printf, scanf, exit
import printf msvcrt.dll
import scanf msvcrt.dll
import exit msvcrt.dll

segment data use32
    number dd 0
    max dd 0
    format db '%d', 0

segment code use32
start:
    read_loop:
        ;read number
        push dword number
        push dword format
        call [scanf]
        add esp, 8
        
        ;check if number is 0
        cmp dword [number], 0
        je print_result
        
        ;check if number is bigger than max
        mov eax, [number]
        cmp eax, [max]
        jbe after_if ; jle for signed
        mov [max], eax
        after_if:
        jmp read_loop
        
        
    print_result:
    push dword [max]
    push dword format
    call [printf]
    add esp, 8

final:
    push dword 0
    call [exit]