;Autor @ManuelUc
;Desarrolla un programa en ensamblador que muestre cuatro ventanas de diferentes colores y 
;en medio de cada ventana colocar tu nombre y apellidos, cada uno en una ventana, en caso 
;de tener solo 1 nombre colocar "ITPS".

STACK SEGMENT STACK
DW 64 DUP(?)
STACK ENDS
;--- PILA ----

DATA SEGMENT
espacio db 10,13,'$'    
nombre1 db 10,13,'                  Manuel$'
nombre2 db 10,13,'                  Ricardo$'
nombre3 db 10,13,'                  Uc$'
nombre4 db 10,13,'                  Nicoli$'
DATA ENDS
;--- DATOS ---

CODE SEGMENT
        ASSUME DS:DATA, CS:CODE, SS:STACK
INICIO: mov AX , DATA
        mov DS, AX
        
		mov cx, 0109h ;Coordenadas ;0109   horizontal
        mov dx, 0925h ;Coordenadas 0925    vertical
        xor al, 10   
        
        ;ventana1
        mov ah,06h ;opción del vídeo       
        mov al,06h
        mov bh,4fh
        mov cx,0000h
        mov dx,174fh
        int 10h 
        		
        ;ventana2
        mov ah,06h ;opción del vídeo       
        mov al,06h
        mov bh,5Eh
        mov cx,0000h
        mov dx,174fh
        int 10h     
        
        ;ventana3
        mov ah,06h ;opción del vídeo       
        mov al,06h
        mov bh,6Ah
        mov dx,174fh
        mov cx,0000h
        int 10h   
        
        ;ventana4
        mov ah,06h ;opción del vídeo       
        mov al,06h
        mov bh,74h
        mov dx,174fh
        mov cx,0000h
        int 10h  
        
        mov dx,0 ;acumulador
        mov cx,4 ;valor cx a 4
        
mostrar: 
		mov ah,09h
        lea dx,espacio
        int 21h 

		mov ah,09h
        lea dx,espacio
        int 21h  
 		
		cmp cx,4
		je pantalla1
		cmp cx,3
		je pantalla2
		cmp cx,2
		je pantalla3
		cmp cx,1
		je pantalla4
		cmp cx,0
		je fin
		
		pantalla1:	mov ah,09h         
					lea dx,nombre1
					int 21h 
					jmp sigue
					
		pantalla2:	mov ah,09h         
					lea dx,nombre2
					int 21h 
					jmp sigue

		pantalla3:	mov ah,09h         
					lea dx,nombre3
					int 21h 
					jmp sigue

		pantalla4:	mov ah,09h         
					lea dx,nombre4
					int 21h 
					jmp sigue

sigue:  mov ah,09h         
        lea dx,espacio 
        int 21h 
		
        mov ah,09h 
        lea dx,espacio 
        int 21h 

        mov ah,09h         
        lea dx,espacio 
        int 21h 
          
		dec cx
        jmp mostrar ;bucle que repite mostrar
        
fin:    mov ah, 4ch
        int 21h
CODE ENDS 
END INICIO