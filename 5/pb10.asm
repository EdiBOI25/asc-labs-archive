;Se dau doua siruri de caractere S1 si S2. Sa se construiasca sirul D prin concatenarea elementelor sirului S2 in ordine inversa cu elementele de pe pozitiile pare din sirul S1.
bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    s1 db '+', '2', '2', 'b', '8', '6', 'X', '8'
    len1 equ $-s1 ; lungimea sirului s1
    s2 db 'a', '4', '5'
    len2 equ $-s2 ; lungimea sirului s2
    d times len1+len2 db 0 ; rezervam len1+len2 octeti pentru sirul D
    
segment code use32 class=code
start:
    mov ecx, len2 ; ecx = lungimea s2 pentru a putea realiza loop-ul de len2 ori
    mov esi, len2 ; indexul sursa
    dec esi ; esi devine pozitia ultimului element din s2
    mov edi, 0 ; indexul destinatie
    
    jecxz Sfarsit ; sare la eticheta Sfarsit in cazul in care ecx e 0 (safety measure)
    ParcurgereSir2:
        mov al, [s2+esi] ; al devine caracterul din s2[esi]
        mov [d+edi], al ; d[edi] devine AL
        inc edi ; edi++
        dec esi ; esi-- (parcurgem s2 in sens invers)
    loop ParcurgereSir2 ; repetam loop-ul
    
    mov ecx, len1 ; ecx devine len1 (acelasi motiv ca mai sus)
    mov esi, 0
    jecxz Sfarsit ; safety measure
    
    ParcurgereSir1:
        ; pozitii pare = esi impar
        test esi, 01h ; testam daca esi e par
        jnz PozPara ; daca esi e impar (ZF=0), atunci sarim la eticheta ePar
        ;tratam cazul in care esi e par (ZF=1), adica pozitia e impara
        inc esi ; crestem indexul sursa indiferent daca e par sau impar
        loop ParcurgereSir1 ; repetam loop-ul
        jmp Sfarsit ; cand loop-ul e gata, sarim direct la Sfarsit
        
    PozPara: ; tratam cazul esi e par (ZF=1)
        mov al, [s1+esi] ; punem in AL caracterul s1[esi]
        mov [d+edi], al ; punem in d[edi] caracterul din AL
        inc edi ; crestem edi doar daca am pus caracter in sirul D
        inc esi ; crestem esi indiferent daca e par sau impar
        loop ParcurgereSir1 ; repetam loop-ul
    
    Sfarsit:
    push dword 0
    call [exit]