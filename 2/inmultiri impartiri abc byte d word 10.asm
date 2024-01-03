; Scrieți un program în limbaj de asamblare care să rezolve expresia aritmetică, considerând domeniile de definiție ale variabilelor
; a, b, c - byte, d - word
; 3*[20*(b-a+2)-10*c]/5
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
segment  code use32 class=code ; segmentul de cod
start: 
	mov al, [b] ; AL = b
    sub al, [a] ; AL = b - a
    add al, 2 ; AL = b - a + 2
    
    mov bl, 20 ; BL = 20
    mul bl ; AX = BL * AL = 20 * (b - a + 2)
    
    mov bx, ax ; BX = AX = 20 * (b - a + 2)
    mov al, [c] ; AL = c
    mov dl, 10 ; DL = 10
    mul dl ; AX = DL * AL = 10 * c
    
    sub bx, ax ; BX = BX - AX = 20 * (b - a + 2) - (10 * c)
    mov ax, bx ; AX = BX
    
    mov bx, 3 ; BX = 3
    mul bx ; DX:AX = AX * BX = 3 * [20 * (b - a + 2) - (10 * c)]
    
    mov bx, 5 ; bx = 5
    div bx ; AX = DX:AX / BX = 3 * [20 * (b - a + 2) - (10 * c)] / 5
    
    
	
	
	push   dword 0 ;se pune pe stiva codul de retur al functiei exit
	call   [exit] ;apelul functiei sistem exit pentru terminarea executiei programului