;@Autor: Manuel Uc Nicoli
;Desarrollar un programa en ensamblador que permita calcular el área y perímetro 
;de un triángulo, los valores pueden ser máximo de 3 dígitos.

STACK SEGMENT STACK
DW 64 DUP(?)
STACK ENDS
;---------- PILA ---------
include 'macro-procedimiento.asm'	;macro y procedimiento creados por mi 
include 'emu8086.inc'

DATA SEGMENT	
txt1 db 'Elija la opcion de su triangulo!$'
txtM db '1-Escaleno   2-Isoceles   3-Equilatero$'
txtP db 'El perimetro del triangulo es: $'
txtA db 'El area del triangulo es: $'
txtE db 'Opcion invalida!$'
var1 db 'Ingrese el primer perimetro: $'
var2 db 'Ingrese el segundo perimetro: $'
var3 db 'Ingrese el tercero perimetro: $'
var4 db 'Ingrese su base: $'
var5 db 'Ingrese su altura: $'
num1 dw ?
num2 dw ?
num3 dw ?
DATA ENDS
;--------- DATOS ---------
CODE SEGMENT
        ASSUME DS:DATA, CS:CODE, SS:STACK
INICIO:	MOV AX, DATA
		MOV DS , AX
		
INICIO2: Puntero2 12,20
		Mensaje txt1
		Puntero2 13,20
		Mensaje txtM		;Menu donde se muestra las opciones de triangulos
		Puntero2 14,20
		Introducir
		cmp al, '1'
		je ESCALENO
		cmp al, '2'
		je ESCALENO
		cmp al, '3'
		je EQUILATERO 
		Puntero2 15,20
		Mensaje txtE		;Si no se selecciona ninguna ocpion, limpia la pantalla y retorna de nuevo.
		LimpiezaPantalla
		JMP INICIO2
		
ESCALENO:Puntero2 15,20		;Todos sus lados son diferentes, el isoceles no sabriamos cual es el lado que es igual
		Mensaje var1
		CALL   SCAN_NUM
		mov num1, cx
		
		Puntero2 16,20
		Mensaje var2
		CALL   SCAN_NUM
		mov ax, num1
		add ax,cx
		mov num1,ax
		
		Puntero2 17,20
		Mensaje var3
		CALL   SCAN_NUM
		mov ax, num1
		add ax, cx
		mov num1,ax
		
		Puntero2 18,20
		Mensaje var4
		CALL   SCAN_NUM
		mov num2,cx
		
		Puntero2 19,20
		Mensaje var5
		CALL   SCAN_NUM
		mov num3,cx
		;Area y perimetro
		LimpiezaReg
		Puntero2 20,20
		Mensaje txtP
		mov ax,num1
		CALL   PRINT_NUM
		
		Puntero2 21,20
		Mensaje txtA
		mov ax,num2
		mov bx,num3
		mul bx 
		mov bx, 2
		xor dx,dx
		div bx
		CALL   PRINT_NUM
		FIN					;Finaliza el programa

EQUILATERO:Puntero2 15,20	;Todos sus lados son iguales
		Mensaje var1		;Perimetro solo necesitamos 1
		CALL   SCAN_NUM
		mov num1,cx			;Solo necesitamos un perimetro
		
		Puntero2 16,20
		Mensaje var4
		CALL   SCAN_NUM
		mov num2, cx
		
		Puntero2 17,20
		Mensaje var5
		CALL   SCAN_NUM
		mov num3, cx
		LimpiezaReg
		;Area y perimetro
		Puntero2 18,20
		Mensaje txtP
		mov ax, num1
		mov bx,3
		mul bx
		CALL   PRINT_NUM
		LimpiezaReg
		
		Puntero2 19,20
		Mensaje txtA
		mov ax,num2
		mov bx,num3
		mul bx 
		mov bx, 2
		xor dx,dx
		div bx
		CALL   PRINT_NUM
		FIN					;Finaliza el programa
;define's con funciones matematicas y entrada de numeros
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS		
		
CODE ENDS 
ENDS INICIO