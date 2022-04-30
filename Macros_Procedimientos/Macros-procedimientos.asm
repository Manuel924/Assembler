;@Manuel Uc Nicoli
;Macros y procedimeintos para el uso de las banderas.

;------   MACROS   --------
Mensaje macro txt	;macro para mostrar textos desde una varible del programa.
	mov ah,09h 
	lea dx, txt
	int 21h
endm 

BanderaSuperior macro ;macro bandera superior.
		mov ax,0600h
		mov bh,17h;atributos de color fondo y texto
        mov CX,0000h;fila inicial en ch, columna inicial en cl
        mov dh, 4h
		mov dl, 13h
        int 10h;ejecuta las interrupciones de video
endm

BanderaInferior macro 	;macro bandera inferior.
		mov ax,0600h
		mov bh,0E7h;atributos de color fondo y texto
        mov ch,5h;fila inicial en ch, columna inicial en cl
        mov cl,0h
        mov dh,9h;fila final en dh, columna final en cl
        mov dl,13h
        int 10h;ejecuta las interrupciones de video
endm

Puntero macro num1			;macro para poner el puntero en una posicion hacia abajo.
		mov ah,02h
		mov dh,num1
		mov dl,2h
		mov bh,0h
		int 10h
endm

Puntero2 macro num1,num2		;macro para poner el puntero en una posicion hacia abajo,derecha.
		mov ah,02h
		mov dh,num1
		mov dl,2h
		mov bh,num2
		int 10h
endm

;------  PROCEDIMIENTOS   -------
introducir proc far 	;procedimeinto para pedir "x" tecla.
	mov ah,01h
	int 21h		;Coloca la tecla introducida en AL.
	mov dl, al	;Colocamos en dl el valor de AL.	
	ret
introducir endp