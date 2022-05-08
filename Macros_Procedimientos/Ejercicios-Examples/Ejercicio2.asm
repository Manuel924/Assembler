;@Autor: Manuel Uc Nicoli
;Crea un programa que emplee macros y procedimientos para realizar una calculadora básica (4 operaciones básicas).
STACK SEGMENT STACK
DW 64 DUP(?)
STACK ENDS
include 'Macro-procedimiento.asm'
include 'Emu8086.inc'
;--- PILA ----

DATA SEGMENT
chr1  db ? ;primer digito
chr2  db ? ;segundo digito
chr3  db ? ;multiplo
chr4  db ?
r1    db ? ;resultado 1
r2    db ? ;resultado 2
r3    db ?
r4    db ?
ac    db 0 ;acarreo
ac1   db 0
num1 dw ?
num2 dw ?
txt1 db '!Seleccione una opcion a realizar!$'
txt3 db '1-Suma 2-Resta 3-Multiplicacion 4-Division 5-Salir$'
ResultadoM db 10,13,'El resultado de la multiplicacion: $'
ResultadoS db 10,13,'El resultado de la suma: $'
ResultadoD db 10,13,'El resultado de la division: $'
ResultadoR db 10,13,'El resultado de la resta: $'
txt2 db 10,13,'Ingresa un numero (2 dijitos max): $'
DATA ENDS
;--- DATOS ---

CODE SEGMENT
        ASSUME DS:DATA, CS:CODE, SS:STACK
INICIO: PortadaEjer
		mov AX , DATA
        mov DS, AX
;--------- PROCESO MENU CALCULADORA -------- 		
INICIO2:LimpiezaPantalla
		Puntero2 0,20
		Mensaje txt1
		Puntero2 1,12
		Mensaje txt3
		puntero2 2,12
		Introducir
		puntero2 4,0
		cmp al,49
		je SUM
		cmp al,50
		je RES
		cmp al,51
		je MULTI
		cmp al,52
		je DIVIS
		cmp al,53
		je Finalizar
		jmp INICIO2
		
;--------- PROCESO SUMA ---------		
SUM:	Mensaje txt2	;pedir el primer numero de 2 dij
		call Num
		mov chr1,al   	;[chr1].chr2 * chr3 = ac.r1.r2
		call Num
		mov chr2,al    	;[chr1].chr2 * chr3 = ac.r1.r2
		
		Mensaje txt2	;pedir el segundo numero de 2 dij
		call Num
		mov chr3,al    	;[chr1].chr2 * chr3 = ac.r1.r2
		call Num
		mov chr4,al    	;[chr1].chr2 * chr3 = ac.r1.r2
		LimpiezaReg		;Limpieza de registros para empezar la suma	
		call ProcesoSuma
		jmp INICIO2
;--------- PROCESO RESTA ---------				
RES:	Mensaje txt2	;pedir el primer numero de 2 dij
		CALL   scan_num       ; get number in CX.
		mov num1,cx
		
		Mensaje txt2	;pedir el segundo numero de 2 dij
		CALL   scan_num       ; get number in CX.
		mov num2,cx
		
		call ProcesoResta
		LimpiezaReg
		jmp INICIO2
;--------- PROCESO MULTIPLICACION ---------				
MULTI:	Mensaje txt2	;pedir el primer numero de 2 dij
		call Num
		mov chr1,al   	;[chr1].chr2 * chr3 = ac.r1.r2
		call Num
		mov chr2,al    	;[chr1].chr2 * chr3 = ac.r1.r2
		
		Mensaje txt2	;pedir el segundo numero de 2 dij
		call Num
		mov chr3,al    	;[chr1].chr2 * chr3 = ac.r1.r2
		call Num
		mov chr4,al  	
		LimpiezaReg
		call ProcesoMulti
		jmp INICIO2
;--------- PROCESO DIVISION ---------		
DIVIS:	Mensaje txt2	;pedir el primer numero de 2 dij
		CALL   scan_num       ; get number in CX.
		mov num1,cx
		
		Mensaje txt2	;pedir el segundo numero de 2 dij
		CALL   scan_num       ; get number in CX.
		mov num2,cx
		
		call ProcesoDivi
		LimpiezaReg
		jmp INICIO2	
Finalizar:	LimpiezaPantalla
			Fin

Num proc near
	mov ah,01h     ;Function(character read) Guarda en AL
	int 21h        ;Interruption DOS functions
	sub al,30h     ;ajustamos valores
	ret
Num endp	

ProcesoSuma proc near
		;primero los caracteres se pasan moviendo
		mov bl,chr1
        mov cl,chr2	
		mov al,chr3
		;se pasan los segundos caracteres
        add bl,al
		mov al,chr4
        add cl,al
		Mensaje ResultadoS
		mov ax,cx
		DesempaquetadoSuma
		ret
ProcesoSuma endp

ProcesoResta proc 
		mov ax,num1
		sub ax,num2
		mov bx,ax
		Mensaje ResultadoR
		mov ax,bx
		CALL   print_num		
		EnEspera
		ret
ProcesoResta endp

ProcesoMulti proc
		;Realizamos operaci?n   
		mov al,chr4  ;unidad del segundo numero
		mov bl,chr2  ;unidad del primer numero
		mul bl       ;multiplicar
		mov ah,0     ;limpiamos ah0
		aam          ;separamos de hex a dec
		mov ac1,ah   ;decenas del primera multiplicacion
		mov r4,al    ;unidades del primera multiplicacion         
		mov al,chr4  ;unidades del segundo numero
		mov bl,chr1  ;decentas del primer numero
		mul bl       ;multiplicar
		mov r3,al    ;movemos el resultado de la operacion a r3
		mov bl,ac1   ;movemos el acarreo a bl
		add r3,bl    ;sumamos resultado mas acarreo
		mov ah,00h   ;limpiamos ah por residuos
		mov al,r3    ;movemos el resultado de la suma a al
		aam          ;separamos  de hex a dec
		mov r3,al    ;guardamos unidades en r3
		mov ac1,ah   ;guardamos decenas en ac1	
		mov al,chr3    ;al = chr3
		mov bl,chr2    ;bl = chr2
		mul bl         ;AL = chr3*chr2 (BL*AL)
		mov Ah,0h      ;
		AAM            ;ASCII Adjusment
		mov ac,AH      ;ac = AH (Acarreo)
		mov r2,AL      ;r2 = AL       (Unidad del resultado)		
		mov al,chr3    ;AL = chr3
		mov bl,chr1    ;BL = chr1
		mul bl         ;AL = chr1*chr3 (BL*AL)
		mov r1,al      ;r1 = AL       (Decena del resultado)
		mov bl,ac      ;BL = Acarreo anterior
		add r1,bl      ;r1 = r1+ac (r1 + Acarreo)
		mov ah,00h     ;
		mov al,r1      ;AL = r1 (Asignaci?n para el ajust)
		AAM            ;ASCII Adjustment
		mov r1,al      ;r1 = AL
		mov ac,ah      ;ac = AH (Acarreo para la Centena del resultado)
	
		;suma final
		;R4 resulta ser las unidades de mul y no se toma en cuenta ya que se pasa entero
		mov ax,0000h   ;limpiamos ax 
		mov al,r3      ;movemos el segundo resultado de la primera mult a al
		mov bl,r2      ;movemos primer resultado de la segunda mult a bl
		add al,bl      ;sumamos
		mov ah,00h     ;limpiamos ah
		aam            ;separamos hex a dec
		mov r3,al      ;r3 guarda las decenas del resultado final
		mov r2,ah      ;r2 se utiliza como nuevo acarreo	
		mov ax,ax   ;''''	
		mov al,ac1     ;movemos el acarreo de la primera mult a al
		mov bl,r1      ;movemos segundo resultado de la segunda mult a bl
		add al,r2      ;sumamos el nuevo  acarreo de la suma anterior  a al
		add al,bl      ;sumamos al a bl
		mov ah,00h     ;limpiamos el registro ah
		aam            ;separamos de hex a dec
		mov r1,al      ;r1 guarda las centenas
		mov r2,ah      ;ah se sigue utilizando como acarreo	
		mov al,r2      ;movemos el acarreo a al
		mov bl,ac      ;movemos ac a bl
		add al,bl      ;sumamos al a bl
		;aam            ;separamos hex a dec
		mov ac,al      ;mov al a ac como nuestro acarreo final
	
		;Mostramos resultado
		Mensaje ResultadoM
		
		mov ah,02h 
		mov dl,ac
		add dl,30h
		int 21h        ;Mostramos ac (millar)
		mov ah,02H
		mov dl,r1
		add dl,30h
		int 21h        ;Mostramos r1 (centena)
		mov ah,02H
		mov dl,r3
		add dl,30h
		int 21h        ;Mostramos r3 (decena)	
		mov ah,02H
		mov dl,r4
		add dl,30h
		int 21h        ;unidad
		EnEspera
		ret
ProcesoMulti endp

ProcesoDivi proc 
		Mensaje ResultadoD
		xor dx,dx
		mov ax, num1
		mov bx, num2
		div bx
		CALL   print_num
		EnEspera
		ret
ProcesoDivi endp

DEFINE_SCAN_NUM			;define's con funciones matematicas
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

CODE ENDS
ENDS INICIO