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
        mov esi, 0 ; esi va fi offset-ul pt sirul A
        mov edi, 0 ; edi va fi offset-ul pt sirurile B1 si B2 (le parcurgem deodata)
        mov ecx, len ; repetam loop-ul de len ori
        jecxz Sfarsit
        Repeta:
            mov ax, [a+esi] ; punem in AX cuvantul din A+ESI
            mov [b2+edi], al ; punem in B2+EDI partea inferioara a cuvantului din AX
            mov [b1+edi], ah ; punem in B1+EDI partea superioara a cuvantului din AX
            inc edi ; incrementam EDI
            add esi, 2 ; crestem ESI cu 2 pt ca sirul A e format din cuvinte
            loop Repeta
    Sfarsit:
        push    dword 0
        call    [exit]
