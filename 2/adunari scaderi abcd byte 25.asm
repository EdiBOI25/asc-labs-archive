; Scrieți un program în limbaj de asamblare care să rezolve expresia aritmetică, considerând domeniile de definiție ale variabilelor
; a,b,c,d - byte
; 25. (c+d+d)-(a+a+b)
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
    mov al, [c] ; AL = c
    add al, [d] ; AL = c + d
    add al, [d] ; AL = c + d + d
    
    mov bl, [a] ; BL = a
    add bl, [a] ; BL = a + a
    add bl, [b] ; BL = a + a + b
    
    sub al, bl ; AL = AL - BL = (c + d + d) - (a + a + b)
	
	push   dword 0 ;se pune pe stiva codul de retur al functiei exit
	call   [exit] ;apelul functiei sistem exit pentru terminarea executiei programului