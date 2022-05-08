;@Autor: Manuel Uc
STACK SEGMENT STACK	;segmento pila
DW 64 DUP(?)
STACK ENDS
;-------------------

DATA SEGMENT 
txt db 'Hola mundo',10,13,'hola mundo2$';usar 10,13 despues del primer texto
txt2 db 'ah$'
DATA ENDS 
;----------------------------

CODE SEGMENT
	ASSUME DS:DATA , CS:CODE, SS:STACK
	
	INICIO: MOV AX,DATA
			MOV DS,AX

LIMPIARPANTALLA:
		mov ah,06h
		mov bh,07h;atributo de fondo y texto
		mov cx,0000h;fila inicial, columna inicial
		mov dx,00000h;fila final, columan final
		int 10h
		
		
;----------- USANDO LA MANERA DE VIDEO O AVANZADA -------------		
parte_derecha:
		mov ax,0600h
		mov bh,27h ;verde 
		mov cx,00h;linea inicial 
		mov dx,0a0ah ;lineas hacia abajo
		;mov dl, 4h;lineas hacia el lado derecho
		int 10h

parte_medio:
		mov ax,0600h
		mov bh,0f7h ;verde 
		mov cx,000bh;linea inicial 
		mov dh,0ah ;lineas hacia abajo
		mov dl,15h;lineas hacia el lado derecho
		int 10h
		
parte_izquierda:
		mov ax,0600h
		mov bh,47h ;verde 
		mov cx,0015h;linea inicial 
		mov dx,0a21h ;lineas hacia abajo
		;mov dl, 4h;lineas hacia el lado derecho
		int 10h
		
		
;------ USANDO TEXTOS ---------
puntero:
		mov ah,02h
		mov bh,0h
		mov dh,0ah ;cordenada hacia abajo
		mov dl,21h ;cordenada hacia lado derecho
		int 10h
		
		mov ah,09h
		lea dx, txt
		int 21h
		
		mov ah,02h
		mov bh,0h
		mov dh,11h ;cordenada hacia abajo
		mov dl,14h ;cordenada hacia lado derecho sin utilizar 10,13
		int 10h
		
		mov ah,09h
		lea dx, txt
		int 21h
CODE ENDS 
ENDS INICIO	