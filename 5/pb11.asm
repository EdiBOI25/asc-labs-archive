;Se da un sir de octeti S. Sa se obtina sirul D1 ce contine toate numerele pare din S si sirul D2 ce contine toate numerele impare din S.
bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    s db 1, 5, 3, 8, 2, 9
    len equ $-s ; lungimea sirului S
    d1 times len db 0 ; rezervam len octeti pentru sirul D1
    d2 times len db 0 ; rezervam len octeti pentru sirul D2
    
segment code use32 class=code
start:
    mov ecx, len ; de cate ori vrem sa repetam loop-ul
    mov esi, 0 ; indexul sursa
    mov edi, 0 ; indexul destinatie, pt D1
    mov ebx, 0 ; indexul pentru D2
    
    jecxz Sfarsit ; sare la eticheta Sfarsit in cazul in care ecx e 0 (safety measure)
    Repeta:
        mov al, [s+esi] ; AL = s[esi]
        test al, 01h ; testam daca s[esi] e par
        jz ePar ; daca e par (ZF=1) sarim spre ePar
        ; tratam cazul in care s[esi] e impar
        mov [d2+ebx], al ; d2[ebx] = s[esi]
        inc ebx ; crestem indexul lui D2
        inc esi ; crestem indexul lui S
        loop Repeta ; repetam loop-ul
    jmp Sfarsit ; cand se termina loop-ul, sarim la Sfarsit
    
    ePar: ; tratam cazul s[esi] e par
        mov [d1+edi], al ; d1[edi] = s[esi]
        inc edi ; crestem indexul lui D1
        inc esi ; crestem indexul lui S
        loop Repeta ; repetam loop-ul
    
    Sfarsit:
    push dword 0
    call [exit]