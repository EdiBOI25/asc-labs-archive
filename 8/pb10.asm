;Sa se citeasca de la tastatura un nume de fisier si un text. Sa se creeze un fisier cu numele dat in directorul curent si sa se scrie textul in acel fisier. Observatii: Numele de fisier este de maxim 30 de caractere. Textul este de maxim 120 de caractere.
bits 32
global start

extern exit, fprintf, scanf, fopen, fclose, printf
import exit msvcrt.dll
import fprintf msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    nume_fisier resb 31
    text resb 121
    format db "%s", 0
    mod_acces db "w", 0
    descriptor_fis dd -1
    msg1 db "numele fisierului: ", 0
    msg2 db "text: ", 0


segment code use32 class=code
start:
    push dword msg1
    call [printf]
    add esp, 4
    ; citim numele fisierului
    ; scanf(%s, nume_fisier)
    push dword nume_fisier
    push dword format
    call [scanf]
    add esp, 4*2
    
    
    push dword msg2
    call [printf]
    add esp, 4
    ; citim textul pe care vrem sa il punem in fisier
    ; scanf(%s, text)
    push dword text
    push dword format
    call [scanf]
    add esp, 4 * 2
    mov eax, text
    
    
    ; cream fisierul
    ; fopen(nume_fisier, w)
    push dword mod_acces
    push dword nume_fisier
    call [fopen]
    add esp, 4*2
    ; daca operatia da eroare, terminam programul
    cmp eax, 0
    je final
    ; daca operatia a reusit, salvam valoarea descriptorului in variabila
    mov [descriptor_fis], eax
    
    
    ; punem textul in fisier
    ; fprintf(descriptor_fisier, text)
    push dword text
    push dword [descriptor_fis]
    call [fprintf]
    add esp, 4*2
    
    
final:
    ; inchidem fisierul
    ; fclose(descriptor_fisier)
    push dword [descriptor_fis]
    call [fclose]
    add esp, 4
    push dword 0
    call [exit]