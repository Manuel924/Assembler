;@Autor Manuel Uc Nicoli
;Desarrollar un porgrama que permita teclear 2 letras y mostrar en grande
;en 2 colores diferentes.
 
STACK SEGMENT STACK
DW 64 DUP(?)
STACK ENDS
;--- PILA ----
DATA SEGMENT
bucle db 0
txt db 10,13,'Introduzca una letra',10,13,'$'
letraM db 10,13,'##         ##',10,13,'## ##   ## ##',10,13,'##   ##    ##',10,13,'##         ##',10,13,'##         ##',10,13,'##         ##',10,13,'##         ##',10,13,'##         ##',10,13,'$'
letraU db 10,13,'##     ##',10,13,'##     ##',10,13,'##     ##',10,13,'##     ##',10,13,'##     ##',10,13,'##     ##',10,13,'##     ##',10,13,'#########',10,13,'$'
Noexiste db 10,13,'No existe esta letra',10,13,'$'
DATA ENDS
;--- DATOS ---

CODE SEGMENT
        ASSUME DS:DATA, CS:CODE, SS:STACK
INICIO: mov AX, DATA
		mov DS, AX
		mov bl,0

comparar:
		inc bl
		cmp bl,3
		je fin
		
		mov ah,09h
		lea dx, txt
		int 21h
		
		mov ah, 01h
		int 21h
		
		cmp al, 'm'
		je LETRA1
		cmp al, 'M'
		je LETRA1
		cmp al, 'u'
		je LETRA2
		cmp al, 'U'
		je LETRA2
		cmp bl,2
		je fin
		
		mov ah,09h
		lea dx, Noexiste
		int 21h
		jmp comparar
		
LETRA1: 
		mov ah,06h
		mov bh,04h
        mov al,00h
        mov cx,00h
        mov dx,30a0h
        int 10h
		
		mov ah, 09h
		lea dx, letraM
		int 21h
		jmp comparar
		
letra2:	mov ah,06h
        mov bh,02h
        mov al,00h
        mov cx,00h
        mov dx,30a0h
        int 10h
		
		mov ah, 09h
		lea dx, letraU
		int 21h
		jmp comparar

FIN:	mov ah, 4ch
        int 21h
CODE ENDS
END INICIO