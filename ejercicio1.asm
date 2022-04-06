;Autor @ManuelUc
;Desarrolla un programa en ensamblador que permita 
;leer una palabra y que muestre la primera vocal en formato grande en color rojo.

STACK SEGMENT STACK
DW 64 DUP(?)
STACK ENDS
;--- PILA ----

DATA SEGMENT
txt db 10,13,'Introduzca una palabra',10,13,'$'
cadena1 db 20 dup (' '),'$'
vocalA db 10,13,'########',10,13,'###  ###',10,13,'###  ###',10,13,'###  ###',10,13,'########',10,13,'###  ###',10,13,'###  ###',10,13,'###  ###',10,13,'###  ###',10,13,'$'
vocalE db 10,13,'########',10,13,'########',10,13,'###',10,13,'###',10,13,'###',10,13,'########',10,13,'########',10,13,'###',10,13,'###',10,13,'###',10,13,'########',10,13,'########',10,13,'$'
vocalI db 10,13,'#######',10,13,'#######',10,13,'  ###  ',10,13,'  ###  ',10,13,'  ###  ',10,13,'  ###  ',10,13,'  ###  ',10,13,'#######',10,13,'#######',10,13,'$'
vocalO db 10,13,' ##### ',10,13,'#     #',10,13,'#      #',10,13,'#      #',10,13,'#      #',10,13,'#      #',10,13,'#     #',10,13,' ##### ',10,13,'$'
vocalU db 10,13,'###   ###',10,13,'###   ###',10,13,'###   ###',10,13,'###   ###',10,13,'###   ###',10,13,' ####### ',10,13,' ####### ',10,13,'$'

DATA ENDS
;--- DATOS ---

CODE SEGMENT
        ASSUME DS:DATA, CS:CODE, SS:STACK
INICIO: mov AX , DATA
        mov DS, AX
        mov ah,06h
        mov bh,04h
        mov al,00h
        mov cx,00h
        mov dx,30a0h
        int 10h
		
		mov ah,09h
		lea dx,txt	;mostrar txt
		int 21h
		
		mov cx,20
		mov si,0 	;puntero en 0
		
LEER:	mov ah,07h	;introduce caracter x caracter
		int 21h
		cmp al,13
		je search
		mov dl,al	;almacenaremos el dato guardado en AL
		mov ah,02h
		int 21h
		
		mov cadena1 [si], al	;almacenamos en la cada lo del puntero
		inc si	;incremetamos el puntero para seguir leyendo caracteres
		loop LEER	;loop decrementa lo establecido en CX

SEARCH: mov si,0
		mov cx, 20

COMPARAR:	cmp cadena1[si], 'a'
		je VA
		cmp cadena1[si], 'A'
		je VA
		cmp cadena1[si], 'e'
		je ve
		cmp cadena1[si], 'E'
		je ve
		cmp cadena1[si], 'I'
		je vi
		cmp cadena1[si], 'i'
		je vi
		cmp cadena1[si], 'o'
		je vo
		cmp cadena1[si], 'O'
		je vo
		cmp cadena1[si], 'u'
		je vu
		cmp cadena1[si], 'U'
		je vu
		inc si
		loop COMPARAR
		;el programa no define si es o no mayusculas o minuscula
		
FIN:	
		mov ah,09h
		lea dx, cadena1
		int 21h
		
		mov ah,4ch
		int 21h
		;si no existe ninguna vocal, mostrara la palabra y finalizara el programa
VA:		mov ah,09h
		lea dx, vocalA
		int 21h
		jmp FIN
		
VE:		mov ah,09h
		lea dx,vocalE
		int 21h
		jmp FIN
		
VI:		mov ah,09h
		lea dx, vocalI
		int 21h
		jmp FIN
		
VO:		mov ah,02h
		mov dh, 15
		mov dl, 35
		int 10h

		mov ah,09h
		lea dx, vocalO
		int 21h
		jmp FIN
		
VU:		mov ah,09h
		lea dx, vocalU
		int 21h
		jmp FIN
		;todos llevan al fin, de lo contrario se mostraria todas las vocales
CODE ENDS
END INICIO