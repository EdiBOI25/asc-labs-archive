; Scrieți un program în limbaj de asamblare care să rezolve expresia aritmetică, considerând domeniile de definiție ale variabilelor
; a,b,c,d - byte
; 10. (a+d+d)-c+(b+b)
bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 
	a db 10
	b db 20
    c db 40
    d db 30
segment  code use32 class=code ; segmentul de cod
start: 
    mov al, [a] ; AL = a
    add al, [d] ; AL = a + d
    add al, [d] ; AL = a + d + d
    sub al, [c] ; AL = (a+d+d)-c
    mov bl, [b] ; BL = b
    add bl, [b] ; BL = b + b
    add al, bl ; AL = AL + BL = (a+d+d)-c+(b+b)
	
	push   dword 0 ;se pune pe stiva codul de retur al functiei exit
	call   [exit] ;apelul functiei sistem exit pentru terminarea executiei programului