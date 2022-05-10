;@Autor: Manuel Uc Nicoli

;--- INSTRUCCIONES ---
;Desarrollar un programa en ensamblador utilizando macros y procedimientos que permita realizar lo siguiente
;a) Pedir que presione una tecla para iniciar y limpiar pantalla.
;b) Pedir el nombre y edad dentro de un cuadro centrado en la pantalla.
;c) Validar la edad a 2 dígitos.
;d) Limpiar la pantalla y mostrar el mensaje "gracias por utilizar el software" y colocar el nombre que proporcionaron en el inciso b.
;Entregar el código fuente y capturas del funcionamiento

STACK SEGMENT STACK
DW 64 DUP(?)
STACK ENDS
;---------- PILA ---------
include 'macro-procedimiento.asm'	;macro y procedimiento creados por mi 
include 'emu8086.inc'

DATA segment 
Nombre db 10 dup (' '),'$'
txt1 db 'Presione cualquier tecla para iniciar el programa!$'
txtNombre db 'Introduzca su nombre: $'
txt2 db 'Por favor, introduzca su edad actual: $'
txt3 db 'GRACIAS POR UTILIZAR EL SOFTWARE!$'
txt4 db 'EDAD INVALIDA!$'
txt5 db 'Hasta luego, $'
DATA ends
;--------- DATOS ---------
CODE SEGMENT
        ASSUME DS:DATA, CS:CODE, SS:STACK
INICIO:	MOV AX, DATA
		MOV DS , AX
		
BOOT: 	Puntero2 12,14
		Mensaje txt1
		EnEspera
		LimpiezaPantalla
		CuadroCentrado
		Puntero2 11,11
		Mensaje txtNombre
		
Puntero:LecturaSI 10
		
EXAM:	Introducir
		cmp al, 13
		je NEXT
		Call CADENA
		Loop EXAM 
		jmp NEXT		
		
NEXT:	Puntero2 12,11
		Mensaje txt2
		Call   SCAN_NUM
		
		cmp cx, 99
		ja FinalizarE

Fin:	LimpiezaPantalla
		Puntero2 11,15
		Mensaje txt3
		Puntero2 12,15
		Mensaje txt5
		Mensaje Nombre
		mov dl,'!'
		mov ah,02h
		int 21h 
		Fin

FinalizarE: LimpiezaPantalla 
		Puntero2 12,30
		Mensaje txt4
		Fin

CADENA proc near
       mov Nombre[si],al
       inc si
	   ret
CADENA endp		
		
;define's con funciones matematicas y entrada de numeros
DEFINE_SCAN_NUM

CODE ENDS
ENDS INICIO