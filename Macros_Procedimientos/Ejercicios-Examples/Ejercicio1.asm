;@Autor: Manuel Uc Nicoli
;Crea un programa que emplee macros y procedimientos para calcular el promedio 
;de 3 calificaciones de un alumno ( 3 dígitos máximo) e indique si el alumno esta aprobado o reprobado. 
STACK SEGMENT STACK
DW 64 DUP(?)
STACK ENDS
include 'emu8086.inc' 	;Incluye funciones de libreria emu8086
include 'Macro-procedimiento.asm'

;--- PILA ----

DATA SEGMENT
Salto db 10,13,'$'
NombreA db 10 dup (' '),'$'
txt1 db 10,13,'Introduzca nombre del alumno: $'
txt2 db 10,13,'Introduzca la calificacion: $'
txtA db ' esta aprobado con: $'
txtR db ' esta reprobado con: $'
calificacion1 dw ?	;dw vaariables de 2 bytes
calificacion2 dw ?
calificacion3 dw ?
resultado dw ?
DATA ENDS

CODE SEGMENT
        ASSUME DS:DATA, CS:CODE, SS:STACK
INICIO: PortadaEjer
		mov AX , DATA
        mov DS, AX
		mov ES, AX
		Mensaje txt1
		LecturaSI 10
		
EJER3:	Introducir
		cmp al, 13
		je CALIFICACION
		Call Cadena
		Loop EJER3 
		jmp CALIFICACION		
		
		
CALIFICACION:
		Mensaje txt2
		CALL   scan_num       ; get number in CX.
		MOV calificacion1,cx
		
		Mensaje txt2
		CALL   scan_num       ; get number in CX.
		MOV calificacion2,cx		
		
		Mensaje txt2
		CALL   scan_num       ; get number in CX.
		MOV calificacion3,cx
		
		LimpiezaReg
		
		mov ax, calificacion1
		add ax, calificacion2
		add ax, calificacion3
		mov bx, 3 
		div bx
		mov cx,ax
		Mensaje Salto
		Puntero 10
		Mensaje NombreA
		cmp cx,70
		jb ImprimirReprobado
		Mensaje txtA
		mov ax,cx
		CALL   print_num
		jmp Final
		
ImprimirReprobado:
		Mensaje txtR
		mov ax,cx
		CALL   print_num
		
Final: Fin


Cadena proc near
       mov NombreA[si],al
       inc si
	   ret
Cadena endp		

DEFINE_SCAN_NUM			;define's con funciones matematicas
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

CODE ENDS
ENDS INICIO