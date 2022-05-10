;@Manuel Uc Nicoli
;Macros y procedimeintos para el uso de las banderas.
TEXTOS SEGMENT 
Intro db 'Instituto Tecnologico Superior Progreso',10,13,'$'
Ejercicio db 10,13,'Ejercicios Ensamblador 3.3',10,13,'$'
Portada db 10,13,'Ana Pech Perez',10,13,'Mariana Perez Ucan',10,13,'Henry Torres Esquivel',10,13,'Manuel Uc Nicoli',10,13,'Angel Uicab Canche',10,13,'$'
Fecha db 10,13,'05-Mayo-2022$'
TEXTOS ENDS 

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

CuadroCentrado macro ;macro centrado blanco con texto negro
		mov ax,0600h
		mov bh,0f0h;atributos de color fondo y texto
        mov CX,0a0ah;fila inicial en ch, columna inicial en cl
        mov dh,0fh
		mov dl,40h
        int 10h;ejecuta las interrupciones de video
endm

CuadroCentrado2 macro ;macro bandera superior.
		mov ax,0600h
		mov bh,09fh;atributos de color fondo y texto
        mov CX,0a0ah;fila inicial en ch, columna inicial en cl
        mov dh,0fh
		mov dl,40h
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

BanderaMexico macro 	;macro bandera inferior.
		mov ax,0600h
		mov bh,020h;atributos de color fondo y texto
        mov CX,00h;fila inicial en ch, columna inicial en cl
        mov dx,0f14h
        int 10h;ejecuta las interrupciones de video	
		
		mov ax,0600h
		mov bh,0f0h;atributos de color fondo y texto
        mov CX,0015h;fila inicial en ch, columna inicial en cl
        mov dx,0f28h
        int 10h;ejecuta las interrupciones de video	
		
		mov ax,0600h
		mov bh,0c0h;atributos de color fondo y texto
        mov CX,0029h;fila inicial en ch, columna inicial en cl
        mov dx,0f3ch
        int 10h;ejecuta las interrupciones de video	
		
		mov ax,0600h
		mov bh,60h;atributos de color fondo y texto
        mov CX,41ah;fila inicial en ch, columna inicial en cl
        mov dx,0a23h
        int 10h;ejecuta las interrupciones de video	
endm

Puntero macro num1			;macro para poner el puntero en una posicion hacia abajo.
		mov ah,02h
		mov dh,num1
		mov dl,0h
		mov bh,0h
		int 10h
endm

Puntero2 macro num1,num2		;macro para poner el puntero en una posicion hacia abajo,derecha.
		mov ah,02h
		mov dh,num1
		mov dl,num2				;sin utilizar un texto con inicio 10,13 en codigo fuente.
		mov bh,0h
		int 10h
endm

Fin macro		;Procedimiento finalizar el programa
	mov ah,04ch
  	int 21h
endm

Introducir macro	;macro para pedir "x" tecla y guardar en una variable al.
	mov ah,01h
	int 21h		;Coloca la tecla introducida en AL.
endm

LecturaSI macro num1
	mov cx,num1
	mov si,0
endm

CharsNum macro
	mov ah,01h     ;Function(character read) Guarda en AL
	int 21h        ;Interruption DOS functions
	sub al,30h     ;ajustamos valores
endm

LimpiezaReg macro
        xor ax,ax
		xor bx,bx
		xor cx,cx
		xor dx,dx
endm

LimpiezaPantalla macro
		mov ax,0600h
		mov bh,07h;atributos de color fondo y texto
        mov CX,0000h;fila inicial en ch, columna inicial en cl
        mov DX,184fh;fila final en dh, columna final en cl
        int 10h;ejecuta las interrupciones de video
endm

LimpiezaPantalla2 macro
		mov ax,0600h
		mov bh,0feh;atributos de color fondo y texto
        mov CX,0000h;fila inicial en ch, columna inicial en cl
        mov DX,184fh;fila final en dh, columna final en cl
        int 10h;ejecuta las interrupciones de video
endm

EnEspera macro 
		mov ah,07h
		int 21h
endm

PortadaEjer macro 
		mov ax,textos
		mov ds, ax
		Puntero 6
		Mensaje Intro
		Mensaje Ejercicio
		Mensaje Portada
		Mensaje Fecha
		EnEspera
		LimpiezaPantalla
		puntero 0,0
endm


DesempaquetadoResta macro
		AAS ;desempaquetado de la suma            
        mov cx,ax            
        SUB bl,ch
        mov ax,bx            
        AAS
        mov bx,ax            
        mov ah,02h
        mov dl,bh
        add dl,30h
        int 21h      
        mov ah,02h
        mov dl,bl
        add dl,30h
        int 21h 
        mov ah,02h
        mov dl,cl
        add dl,30h
        int 21h
		EnEspera
endm

DesempaquetadoSuma macro
        AAM ;desempaquetado de la suma            
        mov cx,ax            
        add bl,ch
        mov ax,bx            
        AAM
        mov bx,ax            
        mov ah,02h
        mov dl,bh
        add dl,30h
        int 21h      
        mov ah,02h
        mov dl,bl
        add dl,30h
        int 21h 
        mov ah,02h
        mov dl,cl
        add dl,30h
        int 21h
		EnEspera
endm
