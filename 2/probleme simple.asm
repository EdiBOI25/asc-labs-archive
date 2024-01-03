bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 
	a  db 10
	b  dw 40
segment  code use32 class=code ; segmentul de cod
start: 
    mov eax, 0
    mov ebx, 0
    ;int 3 ; breakpoint ca altfel nu stiu sa folosesc debuggerul
    
    ;1. 1+9
;	mov al,1 ; punem 1 in al
;    mov bl, 9 ; punem 9 in bl
;    add al, bl ; adunam in al pe bl => 10d
    
    ;2. 1+15
;    mov al,1 ; al = 1
;    mov bl, 15 ; bl = 15
;    add al, bl ; al => 16
    
    ;3. 128+128
;    mov al, 128 ;al = 128
;    mov bl, 128 ;bl = 128
;    add ax, bx ;ax => 256
    
    ;4. 5-6
;    mov ax, 5 ; ax = 5
;    mov bx, 6; bx = 6
;    sub ax, bx; ax = -1
    
    ;5. 10/4
;    mov ax, 10 ; ax = 10
;    mov bx, 4 ; bx = 4
;    div bl ; al = ax/bl, ah = ax % bl
    
    ;6. 256*1
;    mov ax, 256
;    mov bl, 1
;    mul bx
    
    ;7. 256/1
;    mov ax, 256
;    mov bl, 1
;    div bl

    ;8. 128+127
;    mov al, 128
;    mov bl, 127
;    add al, bl

    ;9. 3*4
;    mov al, 3
;    mov bl, 4
;    mul bl

    ;10. 9+7
;    mov al, 9
;    mov bl, 7
;    add al, bl

    ;11. 128*2
;    mov al, 128
;    mov bl, 2
;    mul bl

    ;12. 4-5
;    mov al, 4
;    mov bl, 5
;    sub al, bl

    ;14. -2 * 5
;    mov ax, -2
;    mov bx, 5
;    mul bx

    ;15. 6 * 3
;    mov al, 6
;    mov bl, 3
;    mul bl

    ;20. 13/3
;    mov al, 13
;    mov bl, 3
;    div bl

    ;22. 16/4
;    mov ax, 16
;    mov bl, 4
;    div bl

    ;25 64*4
    mov al, 64
    mov bl, 4
    mul bl

	push   dword 0 ;se pune pe stiva codul de retur al functiei exit
	call   [exit] ;apelul functiei sistem exit pentru terminarea executiei programului	