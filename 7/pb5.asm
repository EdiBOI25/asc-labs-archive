; Se dau doua numere naturale a si b (a, b: word, definite in segmentul de date). Sa se calculeze a/b si sa se afiseze catul si restul impartirii in urmatorul format: "Cat = <cat>, rest = <rest>"
; Exemplu: pentru a=23 si b=10 se va afisa: "Cat = 2, rest = 3"
; Valorile vor fi afisate in format decimal (baza 10) cu semn.
bits 32
global start
extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32
    a dd 1
    b dd 1
    read_format db '%d %d', 0
    print_format db 'Cat = %d rest = %d', 0
    cat dd 1
    r dd 1

segment code use32
start:
    push dword b
    push dword a
    push dword read_format
    call [scanf]
    add esp, 12
    
    mov eax, [a]
    mov edx, 0 ; cdq pt cu semn
    mov ebx, [b]
    div ebx
    
    mov [cat], eax
    mov [r], edx
    
    push dword [r]
    push dword [cat]
    push dword print_format
    call [printf]
    add esp, 12

final:
    push dword 0
    call [exit]