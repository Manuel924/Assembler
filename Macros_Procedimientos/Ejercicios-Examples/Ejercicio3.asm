;@Autor: Manuel Uc Nicoli
;Crea un programa que emplee macros y procedimientos para leer una cadena 
;y la muestre en una coordenada indicada por el usuario. Validar las coordenadas.
STACK SEGMENT STACK
DW 64 DUP(?)
STACK ENDS
include "Macro-procedimiento.asm"
;--- PILA ----

DATA SEGMENT
Cadena1 db 10 dup (' '),'$'
Var1 db 0
Var2 db 0
txt1 db 10,13,'Introduzca su palabra',10,13,'$'
txt2 db 10,13,'Indique su cordenada "Y"',10,13,'$'
txt3 db 10,13,'Indique su cordenada "X"',10,13,'$'
txt4 db 10,13,'Cordenada fuera de lugar, intente de nuevo!',10,13,'$'
txt5 db 10,13,'Programa finalizado!$'
DATA ENDS
;--- DATOS ---
CODE SEGMENT
        ASSUME DS:DATA, CS:CODE, SS:STACK
INICIO:	PortadaEjer
		mov AX , DATA
        mov DS, AX
	
INICIO2:Mensaje txt1
		LecturaSI 10
		
EJER3:	Introducir
		cmp al, 13
		je CORDENADAS
		Call Cadena
		Loop EJER3 
		jmp CORDENADAS
		
CORDENADAS:	Mensaje txt2	;Validar cordenada Y
		Introducir
		cmp al,'9'
		ja RETORN
		cmp al,'0'
		jb RETORN
		sub al,48
		mov dl,al
		mov Var1,dl
		Mensaje txt3		;Validar cordenada X
		Introducir
		cmp al,'9'
		ja RETORN
		cmp al,'0'
		jb RETORN
		sub al,48
		mov dl,al
		mov Var2,dl
		Call LimpiarP
		Puntero2 Var1,Var2	;Puntero
		Mensaje Cadena1
		Mensaje txt5
		Fin
		
RETORN:	Mensaje txt4
		jmp INICIO2

Cadena proc near
       mov cadena1[si],al
       inc si
	   ret
Cadena endp

LimpiarP proc near	;limpiar pantalla.
		;funcion para hacer scroll tambien con 7h
		mov ax,0600h
		mov bh,07h;atributos de color fondo y texto
        mov CX,0000h;fila inicial en ch, columna inicial en cl
        mov DX,184fh;fila final en dh, columna final en cl
        int 10h;ejecuta las interrupciones de video
		ret
limpiarP endp	

CODE ENDS
ENDS INICIO