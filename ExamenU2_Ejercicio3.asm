;@Autor Manuel Uc Nicoli
;3. Desarrollar un programa en ensamblador que permita escribir tu nombre y luego limpiar la pantalla
;colocar un cuadro de un color en el centro de la pantalla, conforme vas presionando los números de1 
;1 al 9 se forme una figura en el centro del cuadro, validar que sea consecutivo los números. 
;y al finalizar despiiegue una frase de despedida con el nombre que se dio al principio. 30 pts

STACK SEGMENT STACK
DW 64 DUP(?)
STACK ENDS
;--- PILA ----

DATA SEGMENT

var db 49 		;validar numeros consecutivos
txt db 10,13,'Coloque su nombre',10,13,'$'
nombre db 15 dup (' '),'$'	;cadena para el nombre
espacio db 10,13,'$'
fig1 db 'Diseno de pistola$'
fig2 db '.....____________________ , ,__$'
fig3 db '....../ `---___________----_____|] = = = = = D$'
fig4 db '...../_==o;;;;;;;;_______.:/$'
fig5 db '.....), ---.(_(__) /$'
fig6 db '....// (..) ), ----"$'
fig7 db '...//___//$'
fig8 db '..//___//$'
fig9 db './/___//%$'
alternativo db 10,13,'Deben ser numeros consecutivos del 1-9 :(',10,13,'Hasta luego $'
despedida db 10,13,'Hasta luego $'
DATA ENDS
;--- DATOS ---

CODE SEGMENT
        ASSUME DS:DATA, CS:CODE, SS:STACK
INICIO: mov AX , DATA
        mov DS, AX
		mov cx,15 
		mov si,0	;contador y apuntador

		mov ah,09h
		lea dx,txt	;pedir el nombre
		int 21h
		
leer:	mov ah,01h	;introduce caracter x caracter
		int 21h
		cmp al,13	;si es enter, brinca a la siguiente instruccion 	
		je pantalla
		mov nombre [si], al	;almacenamos en la cada lo del puntero
		inc si					;incremetamos el puntero para seguir leyendo caracteres
		loop leer		

Pantalla: 
		mov ah,06h
		mov bh,81h
        mov al,00h
        mov cx,00h
        mov dx,3030h
        int 10h	
		
		mov ah,02h
		mov dh,6		;fila
		mov dl,0		;columna
		mov bh,0		;pagina
		int 10h
	
Consecutivos1:
		mov ah,09h
		lea dx, espacio
		int 21h
		
		mov ah,07h
		int 21h
		
		mov bl,var
		cmp al,bl
		je 	txt1
		jne FinA	;si no coincide de manera consecutiva, ira al final alternativo
		
Consecutivos2:
		mov ah,09h
		lea dx, espacio
		int 21h
		
		mov ah,07h
		int 21h
		
		mov bl,var
		cmp al,bl
		je 	txt2
		jne FinA	;si no coincide de manera consecutiva, ira al final alternativo
		
Consecutivos3:
		mov ah,09h
		lea dx, espacio
		int 21h
		
		mov ah,07h
		int 21h
		
		mov bl,var
		cmp al,bl
		je 	txt3
		jne FinA	;si no coincide de manera consecutiva, ira al final alternativo
		
Consecutivos4:
		mov ah,09h
		lea dx, espacio
		int 21h
		
		mov ah,07h
		int 21h
		
		mov bl,var
		cmp al,bl
		je 	txt4
		jne FinA	;si no coincide de manera consecutiva, ira al final alternativo
		
Consecutivos5:
		mov ah,09h
		lea dx, espacio
		int 21h
		
		mov ah,07h
		int 21h
		
		mov bl,var
		cmp al,bl
		je 	txt5
		jne FinA	;si no coincide de manera consecutiva, ira al final alternativo
		
Consecutivos6:
		mov ah,09h
		lea dx, espacio
		int 21h
		
		mov ah,07h
		int 21h
		
		mov bl,var
		cmp al,bl
		je 	txt6
		jne FinA	;si no coincide de manera consecutiva, ira al final alternativo	
		
Consecutivos7:
		mov ah,09h
		lea dx, espacio
		int 21h
		
		mov ah,07h
		int 21h
		
		mov bl,var
		cmp al,bl
		je 	txt7
		jne FinA	;si no coincide de manera consecutiva, ira al final alternativo
		
Consecutivos8:
		mov ah,09h
		lea dx, espacio
		int 21h
		
		mov ah,07h
		int 21h
		
		mov bl,var
		cmp al,bl
		je 	txt8
		jne FinA	;si no coincide de manera consecutiva, ira al final alternativo
		
Consecutivos9:
		mov ah,09h
		lea dx, espacio
		int 21h
		
		mov ah,07h
		int 21h
		
		mov bl,var
		cmp al,bl
		je 	txt9
		jne FinA	;si no coincide de manera consecutiva, ira al final alternativo
		
txt1:	mov ah,09h
		lea dx, fig1
		int 21h
		mov bl,var
		add bl,1
		mov var,bl
		jmp Consecutivos2
		
txt2:	mov ah,09h
		lea dx, fig2
		int 21h
		mov bl,var
		add bl,1
		mov var,bl
		jmp Consecutivos3
		
txt3:	mov ah,09h
		lea dx, fig3
		int 21h
		mov bl,var
		add bl,1
		mov var,bl
		jmp Consecutivos4
		
txt4:	mov ah,09h
		lea dx, fig4
		int 21h
		mov bl,var
		add bl,1
		mov var,bl
		jmp Consecutivos5
		
txt5:	mov ah,09h
		lea dx, fig5
		int 21h
		mov bl,var
		add bl,1
		mov var,bl
		jmp Consecutivos6
		
txt6:	mov ah,09h
		lea dx, fig6
		int 21h
		mov bl,var
		add bl,1
		mov var,bl
		jmp Consecutivos7	
		
txt7:	mov ah,09h
		lea dx, fig7
		int 21h
		mov bl,var
		add bl,1
		mov var,bl
		jmp Consecutivos8
		
txt8:	mov ah,09h
		lea dx, fig8
		int 21h
		mov bl,var
		add bl,1
		mov var,bl
		jmp Consecutivos9
		
txt9:	mov ah,09h
		lea dx, fig9
		int 21h	
				
Fin:	mov ah,09h
        lea dx, espacio
        int 21h
        mov ah,09h
		lea dx, despedida
		int 21h
		mov ah,09h
		lea dx,nombre
		int 21h	
		mov dl,'!'
		mov ah,02h
		int 21h
		
		mov ah,4ch
		int 21h 
		
FinA:	mov ah,09h
        lea dx, espacio
        int 21h
        mov ah,09h
		lea dx, alternativo
		int 21h
		mov ah,09h
		lea dx, nombre
		int 21h
		mov dl,'!'
		mov ah,02h
		int 21h
		
		mov ah, 4ch	;fin del programa
        int 21h
CODE ENDS
ENDS INICIO