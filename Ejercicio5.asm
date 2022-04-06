;Autor @ManuelUc
;Desarrollar un programa en ensamblador que permita validar números 
;solo pueda aceptar números del 1 al 5, solo debe permitir proporcionar 3 números y salirse


STACK SEGMENT STACK
DW 64 DUP(?)
STACK ENDS
;--- PILA ----

DATA SEGMENT
txt db 10,13,'Introduzca un dijito',10,13,'$'
valido db 10,13,'Numero valido',10,13,'$'
invalido db 10,13,'Numero invalido',10,13,'$'
fintxt db 10,13,'PROGRAMA FINALIZADO$'
var db 0
DATA ENDS
;--- DATOS ---

CODE SEGMENT
        ASSUME DS:DATA, CS:CODE, SS:STACK
INICIO: mov AX , DATA
        mov DS, AX
		mov cx,3	;solo nos permitira ingresar 3 veces
		
LEER:	cmp cx,0	;compara que CX sea 0 para finalizar el programa
		je fin
		
        mov ah,09h
		lea dx, txt
		int 21h

		mov ah,01h
        int 21h
        mov var,al	;movemos lo que tenga al a la variable
		dec cx		;decrementamos cx despues de ingresar el dijito

COMPARAR:			;metodo para comparar si es valido de lo contrario mostrara invalido y regresa a LEER
		cmp al, '1'
		je VT
		cmp al, '2'
		je VT
		cmp al, '3'
		je VT
		cmp al, '4'
		je VT
		cmp al, '5'
		je VT
		
		mov ah,09h
		lea dx, invalido	;mensaje invalido
		int 21h
		jmp LEER	;regresa a LEER

FIN:	mov ah,09h
		lea dx, fintxt	;fin del programa lanzando un mensaje antes de
		int 21h
		
		mov ah,4Ch
		int 21h


VT:		mov ah,09h
		lea dx, valido
		int 21h
		jmp LEER