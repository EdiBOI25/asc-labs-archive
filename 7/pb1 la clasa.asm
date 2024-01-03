bits 32
global start

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    n dd 0
    citit db "%d", 0
    ; afisare dd "Numarul n vazut ca numar unsigned este %u, iar in hexa este %x"
    mes1 db "Numarul vazut ca unsigned este %u.", 0
    mes2 db 10, 13, "Numarul vazut ca hexa este %x", 0 ; 10, 13 reprezinta \n

segment code use32 class=code
start:
    push dword n
    push dword citit
    call [scanf]
    add esp, 4*2
    mov eax, [n]
    
    push dword[n]
    push dword mes1
    call [printf]
    add esp, 4*2
    
    mov eax, [n]
    push dword[n]
    push dword mes2
    call [printf]
    add esp, 4*2
    
    push dword 0
    call [exit]
    
