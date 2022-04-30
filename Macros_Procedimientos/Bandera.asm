;@Manuel Uc Nicoli
;Desarrollar un programa en ensamblador que permita limpiar la pantalla 
;y mostrar una bandera de algún país, indicando abajo el nombre de la bandera.

STACK SEGMENT STACK
DW 64 DUP(?)
STACK ENDS
include "Macros-procedimientos.asm" ;incluimos nuestras macros de la msima carpeta en otro caso especificar ruta - C:\ruta\ruta.extension
;--- PILA ----

DATA SEGMENT 
txt1 db 10,13,'Programa finalizado',10,13,'$'
txtB db 10,13,'Bandera de Ucrania',10,13,'$'
DATA ENDS 
;--- DATOS ---

CODE SEGMENT
        ASSUME DS:DATA, CS:CODE, SS:STACK
INICIO: mov AX, DATA
		mov DS, AX

BANDERA:
		Call LimpiarP
		BanderaSuperior
		BanderaInferior
		Puntero 9
		Mensaje txtB
		Call Fin
		
LimpiarP proc near	;limpiar pantalla.
		;funcion para hacer scroll tambien con 7h
		mov ax,0600h
		mov bh,07h;atributos de color fondo y texto
        mov CX,0000h;fila inicial en ch, columna inicial en cl
        mov DX,0000h;fila final en dh, columna final en cl
        int 10h;ejecuta las interrupciones de video
		ret
limpiarP endp		
		
Fin proc near		;Procedimiento finalizar el programa
  	Puntero 15
  	Mensaje txt1
	mov ah,04ch
  	int 21h
	ret
Fin endp	
	
CODE ENDS
END INICIO