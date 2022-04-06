;@Autor Manuel Uc Nicoli
;Desarrollar un programa que valide el numero del 1 al 3 que se repetira el programa
;se pedira un caracter y una palabra, se remplazara color y las veces que se remplazo.

STACK SEGMENT STACK
DW 64 DUP(?)
STACK ENDS
;--- PILA ----

DATA SEGMENT
repit db 0 
espacio db 10,13,'$'
txt db 10,13,'Introduzca una palabra',10,13,'$'
txt1 db 10,13,'Introduzca una dijito',10,13,'$'
remplazo db 10,13,'Caracter a remplazar',10,13,'$'
cadena1 db 20 dup (' '),'$'
cadena2 db 20 dup (' '),'$'

DATA ENDS
;--- DATOS ---

CODE SEGMENT
        ASSUME DS:DATA, CS:CODE, SS:STACK
INICIO: mov AX , DATA
        mov DS, AX
		
		mov cx,20
		mov si,0
		
		mov ah,09h
		lea dx, txt1	;espera el dijito
		mov ah,01h
        int 21h
		mov repit,al		;muevo el dijito introducido de AL a BL para saber cuantas veces ejecutar el programa
		
		cmp al,'1'
		je texto1
		cmp al,'2'
		je texto1 
		cmp al,'3'
		je texto1 
		jne fin
		
texto1:	mov ah,09h
		lea dx, txt
		int 21h

leer:	mov ah,07h	;introduce caracter x caracter
		int 21h
		cmp al,13		
		je search
		mov dl,al	;almacenaremos el dato guardado en AL
		mov ah,02h
		int 21h
		mov cadena1 [si], al	;almacenamos en la cada lo del puntero
		inc si					;incremetamos el puntero para seguir leyendo caracteres
		loop leer

SEARCH: mov si,0
		mov cx, 20
		
programa:mov ah, 09h
		lea dx, remplazo
		int 21h
		
		mov ah, 01h	;espera el caracter y lo muestra en pantalla.
		int 21h
		
		cmp cadena1 [si],al
		je cambiar
		jne nocambia
		
		cambiar:	
		
		nocambia:	
		





			
	
	
	
	
	
	
	
	
FIN:	mov ah, 4ch
        int 21h		
CODE ENDS
END INICIO