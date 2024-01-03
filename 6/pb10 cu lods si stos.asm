;10. Se da un sir A de cuvinte. Construiti 2 siruri de octeti:
; - B1: contine ca elemente partea superioara a cuvintelor din A
; - B2: contine ca elemente partea inferioara a cuvintelor din A

bits 32
global start        
extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 1234h, 4619h, 12AAh, 2A32h ; sir initial
    len equ ($-a)/2 ; lungimea sirului in cuvinte
    b1 times len db 0 ; rezervam len cuvinte pentru sirul b1
    ; 12h, 46h, 12h, 2Ah
    b2 times len db 0 ; rezervam len cuvinte pentru sirul b2
    ; 34h, 19h, AAh, 32h

segment code use32 class=code
    start:
        mov esi, a ; esi va retine offset-ul primului element din A
        mov edi, b1 ; edi va retine offset-ul primului elem din B1
        cld ; DF = 0 pt ca parcurgem de la stanga la dreapta
        mov ecx, len ; repetam loop-ul de len ori
        jecxz Sfarsit
        RepetaB1:
            lodsw ; in AX retinem cuvantul din DS:ESI (adica A)
            shr AX, 8 ; shiftam spre dreapta cu 1 byte
            stosb ; AL se incarca in ES:EDI (adica B1)
            loop RepetaB1
        
        mov esi, a ; esi va retine offset-ul primului element din A
        mov edi, b2 ; edi va retine offset-ul primului element din B2
        cld ; DF = 0 pt ca parcurgem de la stanga la dreapta
        mov ecx, len ; repetam loop-ul de len ori
        jecxz Sfarsit
        RepetaB2:
            lodsw ; in AX retinem cuvantul din ED:ESI (adica A)
            stosb ; AL se incarca in ES:EDI (adica B2)
            loop RepetaB2
    Sfarsit:
        push    dword 0
        call    [exit]
