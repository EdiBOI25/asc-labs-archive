; Scrieți un program în limbaj de asamblare care să rezolve expresia aritmetică, considerând domeniile de definiție ale variabilelor
; a,b,c,d - word
; 25. (a+b-c)-d
bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 
	a dw 10
	b dw 20
    c dw 40
    d dw 30
segment  code use32 class=code ; segmentul de cod
start: 
    mov ax, [a] ; AX = a
    add ax, [b] ; AX = a + b
    sub ax, [c] ; AX = a + b - c
    
    mov bx, [d] ; BX = d
    sub ax, bx ; AX = (a + b - c) - d
    
	
	push   dword 0 ;se pune pe stiva codul de retur al functiei exit
	call   [exit] ;apelul functiei sistem exit pentru terminarea executiei programului