; Scrieți un program în limbaj de asamblare care să rezolve expresia aritmetică, considerând domeniile de definiție ale variabilelor
; a,b,c,d - word
; 10. b+c+d+a-(d+c)
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
    mov ax, [b] ; AX = b
    add ax, [c] ; AX = b + c
    add ax, [d] ; AX = b + c + d
    add ax, [a] ; AX = b + c + d + a
    
    mov bx, [d] ; BX = d
    add bx, [c] ; BX = d + c
    
    sub ax, bx ; AX = b + c + d + a - (d + c)
	
	push   dword 0 ;se pune pe stiva codul de retur al functiei exit
	call   [exit] ;apelul functiei sistem exit pentru terminarea executiei programului