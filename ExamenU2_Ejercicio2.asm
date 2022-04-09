;@Autor Manuel Uc Nicoli
;Desarrollar un programa en ensamblador que valide del 1 al 3, para que se repita el programa. 
;Se pedirá una letra y una palabra, se reemplazará el carácter dentro de la palabra por @, 
;mostrar el resultado en otro color y las veces que se reemplazó. 15 pts

STACK SEGMENT STACK
DW 64 DUP(?)
STACK ENDS
;--- PILA ----

DATA SEGMENT
repit db 0 				;variable para determinar cuantas veces se repetira el programa
cambios db 0			;almacena el numero de cambios
var db 0                ;varible que almacena cambio de pantalla de colores
caractercambiar db 0	;variable para almacenar el caracter a cambiar
espacio db 10,13,'$'	;salto de linea
txt db 10,13,'Introduzca una palabra',10,13,'$'
txt1 db 10,13,'Introduzca un dijito para repetir el programa',10,13,'$'
remplazo db 10,13,'Caracter a remplazar',10,13,'$'
CC db ' cambios realizados a la palabra$'
cadena1 db 10 dup (' '),'$'		;cadena original
cadena2 db 10 dup (' '),'$'		;cadena copia

DATA ENDS
;--- DATOS ---

CODE SEGMENT
        ASSUME DS:DATA, CS:CODE, SS:STACK
INICIO: mov AX , DATA
        mov DS, AX
        
		mov ah,09h
		lea dx, txt1		;espera el dijito
		int 21h
		
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
		
texto1:	
		mov cx,10
		mov si,0
		
		mov ah,09h
		lea dx, txt	;pedira el programa que ingrese su palabra
		int 21h
		
		mov dl,var
		inc dl
		mov var, dl

leer:	mov ah,07h	;introduce caracter x caracter
		int 21h
		cmp al,13		
		je Integrar
		mov dl,al	;almacenaremos el dato guardado en AL
		mov ah,02h
		int 21h
		mov cadena1 [si], al	;almacenamos en la cada lo del puntero
		inc si					;incremetamos el puntero para seguir leyendo caracteres
		loop leer

Integrar: mov si,0
		mov dl,0
		mov cx,10
		
Copiar:	mov al,cadena1[si]
		mov cadena2[si],al
		inc si
		loop Copiar
		
Programa:
		mov ah, 09h
		lea dx, remplazo	;caracter a remplezar
		int 21h
		
		mov ah, 01h	;espera el caracter y lo muestra en pantalla. Almacena en al
		int 21h
		mov caractercambiar,al	;guardamos el caracter a remplezar
		
		mov ah,09h
		lea dx, espacio ;salto de linea
		int 21h
		
cadenas:
		mov si,0	;puntero a utilizar
		mov cx,10	;iniciamos el contador

Comparacion:
		mov al,cadena2[si]		;comparamos lo ingresado con la cadena copiada
		cmp al,caractercambiar	;Compara lo del puntero con el caracter a cambiar
		je Cambiar	;si ocurre va al metodo y cambia por el @ de lo contrario solo continua el programa
		inc si
		loop Comparacion 
		jmp Mchanged
    
Cambiar:mov cadena2[si],'@'	;se realiza el cambio si coincide con el caracter establecido por el usuario
		mov dl, cambios
		inc dl
		mov cambios,dl
		inc si 
		jmp Comparacion 	
		
;------------ Impresion de los resultados en pantalla ------------;		
Mchanged:
		mov dl,var	;dato guardado desde el inicio
		cmp dl, 1
		je pantalla1
		cmp dl, 2
		je pantalla2
		cmp dl, 3
		je pantalla3
		
pantalla1:
        mov ah,00h
        int 10h
        
		mov ah,06h
		mov bh,02h
        mov al,00h
        mov cx,00h
        mov dx,3030h
        int 10h			;opcion de video
		
		mov ah,09h
		lea dx, cadena2 ;leemos la cadena y hacemos un salto de linea.
		int 21h
		mov ah, 09h
		lea dx, espacio
		int 21h
		
		mov dl,cambios
		add dl,30h	
		mov ah, 02h ;exibe el caracter que tenga dl, en este caso los cambios.
		int 21h
		mov dl,0
		mov cambios,dl
		
		mov ah,09h
		lea dx, cc
		int 21h
		
		cmp repit,'1'
		je fin
		jne texto1

pantalla2:
        mov ah,00h
        int 10h
        
		mov ah,06h
		mov bh,06h
        mov al,00h
        mov cx,00h
        mov dx,3030h
        int 10h			;opcion de video
		
		mov ah,09h
		lea dx, cadena2 ;leemos la cadena y hacemos un salto de linea.
		int 21h
		mov ah, 09h
		lea dx, espacio
		int 21h
		
		mov dl,cambios
		add dl,30h
		mov ah, 02h ;exibe el caracter que tenga dl, en este caso los cambios.
		int 21h
		mov dl,0
		mov cambios,dl
		
		mov ah,09h
		lea dx, cc
		int 21h

		cmp repit,'2'
		je fin
		jne texto1
		
pantalla3:
        mov ah,00h
        int 10h
        
		mov ah,06h
		mov bh,01h
        mov al,00h
        mov cx,00h
        mov dx,3030h
        int 10h			;opcion de video
		
		mov ah,09h
		lea dx, cadena2 ;leemos la cadena y hacemos un salto de linea.
		int 21h
		mov ah, 09h
		lea dx, espacio
		int 21h
		
		mov dl,cambios
		add dl, 30h
		mov ah, 02h ;exibe el caracter que tenga dl, en este caso los cambios.
		int 21h
		mov dl,0
		mov cambios,dl
		
		mov ah,09h
		lea dx, cc
		int 21h
	
FIN:	mov ah, 4ch
        int 21h		
CODE ENDS
END INICIO