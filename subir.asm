STACK SEGMENT STACK
  DW 64 DUP(?)
STACK ENDS
;-----------------------------------------------------
DATA SEGMENT
  msg1 db 'Hola Mundo Cruel',10,13,'$'
  fila db 10
  var db 0
  col db 0
DATA ENDS
CODE SEGMENT
      ASSUME DS:DATA, CS:CODE, SS:STACK
Inicio:MOV     AX,DATA
       MOV     DS,AX
repite: 
         mov ah,06h
         mov bh,04h
         mov al,00h
         mov cx,00h
         mov dx,30a0h
        int 10h
;<<<<<<<<Posicion de pantallas       
        mov ah,02h
        mov bx,0000h
        mov dl,0ah
        mov dh,fila
        int 10h           
        
        mov dx,offset msg1
        mov ah,09
        int 21h

        mov ah,01h
        int 21h
        mov var,al   
     
cheka2: cmp var,'1'
        je arriba
        jne cheka
arriba: dec fila
        jmp final1

cheka:  cmp var,'2'
        je abajo
abajo:  jne final1
        inc fila       
        jmp final1                                
                 
   
final1: cmp al,13
		je fin
        jne repite
  
fin:    MOV AX,4C00H
		INT 21H
CODE ENDS
END Inicio