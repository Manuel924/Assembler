;@Autor: Manuel Uc Nicoli
;Desarrollar un programa que permita leer el login y password y si es el correcto 
;mostrar la bandera de México sino mostrar el mensaje de error, el login debe ser asm y password 123

STACK SEGMENT STACK
DW 64 DUP(?)
STACK ENDS
;---------- PILA ---------
include 'macro-procedimiento.asm'	;macro y procedimiento creados por mi 

DATA SEGMENT
user db 3 dup (' '),'$'
user2 db 3 dup ('asm'),'$'
pass db 3 dup (' '),'$'
pass2 db 3 dup ('123'),'$'
txtE db 'Las credenciales ingresadas son invalidas!$'
txt1 db 'Introduzca el usuario: $'
txt2 db 'Introduzca la contrasena: $'
txt3 db 'Bandera de Mexico$'
DATA ENDS
;--------- DATOS ---------
CODE SEGMENT
        ASSUME DS:DATA, CS:CODE, SS:STACK
INICIO:	MOV AX, DATA
		MOV DS , AX
		CuadroCentrado2
		Puntero2 12,14
		LecturaSI 3
		Mensaje txt1
		
USUARIO:Introducir	;Pedimos primer cifrado usuario 
		cmp al, 13
		je RESET
		Call CADENA1
		Loop USUARIO 
		jmp RESET	

RESET:	Puntero2 13,14	;Restablece cx
		Mensaje txt2
		LecturaSI 3
		JMP PASSWORD
		
PASSWORD: Introducir;Pedimos segundo cifrado, contrasena
		cmp al, 13
		je RESET2
		Call CADENA2
		Loop PASSWORD 
		jmp RESET2		

RESET2:	LecturaSI 3	;Restablece cx
		JMP COMPARAR

COMPARAR:mov al, user[si]
		mov dl, user2[si]
		cmp al,dl
		jne FALSE
		
		mov al, pass[si]
		mov dl, pass2[si]
		cmp al,dl
		jne FALSE
		Loop COMPARAR
		JMP TRUE
		
FALSE:	LimpiezaPantalla
        Puntero2 14,21
		Mensaje txtE
		Fin
		
TRUE:	LimpiezaPantalla
		BanderaMexico
		Puntero2 17,21
		Mensaje txt3
		Fin
		
;--- procedimientos ---		
CADENA1 proc near
       mov user[si],al
       inc si
	   ret
CADENA1 endp

CADENA2 proc near
       mov pass[si],al
       inc si
	   ret
CADENA2 endp			

CODE ENDS
ENDS INICIO