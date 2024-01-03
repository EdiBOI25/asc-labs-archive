; Sa se citeasca de la tastatura un numar in baza 10 si sa se afiseze valoarea acelui numar in baza 16.
; Exemplu: Se citeste: 28; se afiseaza: 1C
bits 32
global start

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    n dd 0 ; variabila pe care vrem sa o citim
    format db "%d", 0 ; formatul numarului pe care il citim
    mesaj db "%X", 0 ; mesajul de afisat

segment code use32 class=code
start:
    ; citim n
    push dword n
    push dword format
    call [scanf]
    add esp, 4*2
    mov eax, [n]
    
    ; afisam n in reprezentare hexa
    push eax
    push dword mesaj
    call [printf]
    add esp, 4*2
    
    
    push dword 0
    call [exit]