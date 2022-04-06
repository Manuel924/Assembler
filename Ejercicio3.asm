;Autor @ManuelUc
;Desarrollar un programa en ensamblador que permita leer 
;una palabra de 10 caracteres y contar cuantas vocales tiene.

STACK SEGMENT STACK
DW 64 DUP(?)
STACK ENDS
;--- PILA ----

DATA SEGMENT
espacio db 10,13,'$'    
txt db 10,13,'Introduzca una palabra',10,13,'$'
txtt db ' vocales encontradas$'
var db 0
DATA ENDS
;--- DATOS ---

CODE SEGMENT
    ASSUME DS:DATA, CS:CODE, SS:STACK
INICIO: mov AX , DATA
        mov DS, AX
		mov cx,10	;solo nos permitira ingresar 10 caracteres

        mov ah,09h
		lea dx, txt
		int 21h
		
LEER:	cmp cx,0	;compara que CX sea 0 para finalizar el programa
		je fin

		mov ah,01h
        int 21h
        mov var,al	;movemos lo que tenga al a la variable
		dec cx		;decrementamos cx despues de ingresar el dijito

COMPARAR:			;metodo para comparar si es valido de lo contrario mostrara invalido y regresa a LEER
		cmp var, 'a'
		je VT
		cmp var, 'A'
		je VT
		cmp var, 'e'
		je VT
		cmp var, 'E'
		je VT
		cmp var, 'i'
		je VT
		cmp var, 'I'
		je VT
		cmp var, 'o'
		je VT
		cmp var, 'O'
		je VT
		cmp var, 'u'
		je VT
		cmp var, 'U'
		je VT
		cmp var,13
		je FIN
		
		jmp LEER	;regresa a LEER

FIN:	mov ah,09h
        lea dx,espacio
        int 21h
        
        mov ah,09h
        lea dx,espacio
        int 21h

        add bl,30h
		mov dl,bl
		mov ah,02h
		int 21h
		
		mov ah,09h
		lea dx, txtt
		int 21h
		
		mov ah,4Ch
		int 21h

VT:		add bl,1
		jmp LEER