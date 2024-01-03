; Scrieți un program în limbaj de asamblare care să rezolve expresia aritmetică, considerând domeniile de definiție ale variabilelor
; a, b, c, d - byte    e, f, g, h - word
; a*d+b*c
bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 
	a db 10
	b db 40
    c db 30
    d db 20
segment  code use32 class=code ; segmentul de cod
start: 
	mov al, [a] ; AL = a
    mul byte [d] ; AX = AL * d = a * d
    
    mov bx, ax ; BX = AX
	mov al, [b] ; AL = b
    mul byte [c] ; AX = AL * c = b * c
    
    add ax, bx ; AX = AX + BX = b * c + a * d
	
	push   dword 0 ;se pune pe stiva codul de retur al functiei exit
	call   [exit] ;apelul functiei sistem exit pentru terminarea executiei programului