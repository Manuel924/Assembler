;@Autor: Manuel Uc Nicoli
;Desarrollar un programa en ensamblador que permita teclear una vocal (validar que sea solo vocal en mayúscula o minúscula) 
;y mostrarla en forma de texto grande, se terminará cuando se presione la tecla escape.
STACK SEGMENT STACK
DW 64 DUP(?)
STACK ENDS
include "Macro-procedimiento.asm"
;--- PILA ----

DATA SEGMENT
txt1 db 10,13,'Introduzca un caracter',10,13,'$'
txt2 db 10,13,'Caracter incorrecto',10,13,'$'
txt3 db 10,13,'Programa finalizado$'
vocalA db 10,13,'########',10,13,'###  ###',10,13,'###  ###',10,13,'###  ###',10,13,'########',10,13,'###  ###',10,13,'###  ###',10,13,'###  ###',10,13,'###  ###',10,13,'$'
vocalE db 10,13,'########',10,13,'########',10,13,'###',10,13,'###',10,13,'###',10,13,'########',10,13,'########',10,13,'###',10,13,'###',10,13,'###',10,13,'########',10,13,'########',10,13,'$'
vocalI db 10,13,'#######',10,13,'#######',10,13,'  ###  ',10,13,'  ###  ',10,13,'  ###  ',10,13,'  ###  ',10,13,'  ###  ',10,13,'#######',10,13,'#######',10,13,'$'
vocalO db 10,13,' ##### ',10,13,'#     #',10,13,'#      #',10,13,'#      #',10,13,'#      #',10,13,'#      #',10,13,'#     #',10,13,' ##### ',10,13,'$'
vocalU db 10,13,'###   ###',10,13,'###   ###',10,13,'###   ###',10,13,'###   ###',10,13,'###   ###',10,13,' ####### ',10,13,' ####### ',10,13,'$'
DATA ENDS
;--- DATOS ---

CODE SEGMENT
        ASSUME DS:DATA, CS:CODE, SS:STACK
INICIO: PortadaEjer
		mov AX , DATA
        mov DS, AX		
VOCALES:
		Mensaje txt1	;macro creada para este ejercicio
		Introducir ;macro para pedir tecla
		cmp al, 'A' 
		je Va	
		cmp al, 'a' 
		je Va
		cmp al, 'E'
		je Ve
		cmp al, 'e'
		je Ve
		cmp al, 'I'
		je Vi
		cmp al, 'i'
		je Vi
		cmp al, 'O'
		je Vo
		cmp al, 'o'
		je Vo
		cmp al, 'U'
		je Vu
		cmp al, 'u'
		je Vu
		cmp al, 32	;32 espacio en decimal
		je fin			;finaliza si es espacio
		Mensaje txt2	;no se encontro caracter
		jmp VOCALES		;se inicia el programa

Va:	Mensaje vocalA	
jmp VOCALES
Ve:	Mensaje vocalE	
jmp VOCALES
Vi:	Mensaje vocalI	
jmp VOCALES
Vo:	Mensaje vocalO	
jmp VOCALES
Vu:	Mensaje vocalU	
jmp VOCALES

FIN:	Mensaje txt3
		Fin
		
CODE ENDS
ENDS INICIO