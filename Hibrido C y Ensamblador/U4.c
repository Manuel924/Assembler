#include <stdio.h>
#include <string.h>
#include <conio.h>
#include <stdlib.h>
//using namespace std;

//Declaramos las calses a utilizar
void visualizar();
void triangulo();
void calculadora();
void archivos();
void ingresar();
void mostrar();
void eliminar();
//clases de ensamblador//
void enEspera();
void posicionarCursor();
void limpiezaPantalla();
void imprimir();
void waitforuser();
void esperar();
void cuadroespera();
void cerrarArch();
void BanderaMexico ();
//void ApagarPC();

//Declaramos variables globales
char txt1[] = "\n\nBienvenido al programa\nPrograma multiproceso, seleccione alguna opcion!";
char txt2[] = "\n1.-Calculadora basica\n2.-Area de un triangulo\n3.-Ver codigo fuente\n4.-Manejar archivos\n5.-Finalizar el programa\n\n";
char txt3[70] = "\n\n Presione cualquier tecla para continuar:)!$";
char txt4[70] = "Cargando sistema de archivos, espere un momento...$";
char caracteres,datos[70], n_archivo[20];
int n,num1,num2,suma,resta,mult,divis,resultado,datosx;	
int num11,num22,res,op;
FILE * pf;

//----------		Inicio del programa			------------//
int main (){		
int bandera = 0;

while (bandera == 0){	
limpiezaPantalla();		//scrip - 1
posicionarCursor(2,2);	//scrip - 2
printf("%s",txt1);
printf("\n%s",txt2,"\n\n");
enEspera();	//scrip - 3

switch (op){
	case 1:
		calculadora();
		imprimir(txt3);	//scrip - 9
		waitforuser();	//scrip - 10
		break;
		
	case 2:
		triangulo();
		imprimir(txt3);	//scrip - 9
		waitforuser();	//scrip - 10
		break;
		
	case 3:
		visualizar();
		imprimir(txt3);	//scrip - 9
		waitforuser();	//scrip - 10
		break;

	case 4:
		limpiezaPantalla();		//scrip - 1
		cuadroespera(12,14);
		archivos();
		break;

	case 5:
		bandera++;
		break;

	default: printf("\n!Introduzca una opcion valida!\n");
}
}

limpiezaPantalla();
BanderaMexico();	//scrip complejo
posicionarCursor(14,0);
printf("\n\n\tHasta luego!"); //para imrpimir de nuevo lo de una variable
esperar();
exit(1);
	getch();
	return 0;
}

void visualizar(){
		FILE * flujo = fopen("LI_ExamenU4.c","rb");
		
		if (flujo == NULL){
		perror("Error en abrir el archivo!");
		}

		while (feof(flujo) == 0){
			caracteres = fgetc(flujo);
			imprimir (caracteres);
		}

	fclose(flujo);
	printf("\n\nARCHIVO LEIDO CON EXITO!");
}

void triangulo(){
		printf("\n\nIntroduzca la base de su triangulo: ");
		scanf("%d",&num11);
		printf("\nIntroduzca la altura de su triangulo: ");
		scanf("%d",&num22);
		
		asm{	//scrip - 4
		mov ax,num11;
		mov bx,num22;
		mul bx;	//num1*num2
		mov bx,2;	// res / 2
		div bx;		//res guardado en ax
		mov res,ax;	//movemos el resultado en res, no maneja ensamblador flotantes
		}
		
		printf("El area de su triangulo es: %d",res);
}

void calculadora(){
		printf("\nIntroduzca el primer dijito: ");
		scanf("%d",&num1);
		printf("\nIntroduzca el segundo dijito: ");
		scanf("%d",&num2);
		//inicio scrips //
		asm{	//scrip - 5
			mov ax, num1;
			add ax, num2;
			mov resultado, ax;
		}
		printf("\nEl resultado de la suma es: %d",resultado);
		
		asm{	//scrip - 6
			mov ax,num1;
			sub ax,num2;
			mov resultado,ax;
		}
		printf("\nEl resultado de la resta es: %d",resultado);
		
		asm{	//scrip - 7
			mov ax,num1;
			mov bx,num2;
			div bx;
			mov resultado,ax;
		}
		printf("\nEl resultado de la division es: %d",resultado);
		
		asm{	//scrip - 8
			mov ax,num1;
			mov bx,num2;
			mul bx;
			mov resultado,ax;
		}
		printf("\nEl resultado de la multiplicacion es: %d",resultado,"\n");
}

void archivos(){
	int bandera = 0;

	while(bandera == 0){
	limpiezaPantalla();		//scrip - 1
	posicionarCursor(2,2);	//scrip - 2
	printf("\n ELIJA UNA OPCION");
	printf("\n1.- Abrir(Crear) e ingresar datos a un archivo");
	printf("\n2.- Mostrar datos ingresados");
	printf("\n3.- Eliminar archivo");
	printf("\n4.- Salir al menu principal\n\n");
	enEspera();
	
	switch (op) {
		case 1:
		ingresar();
		imprimir(txt3);	//scrip - 9
		waitforuser();	//scrip - 10	
			break;

		case 2:
		mostrar();
		imprimir(txt3);	//scrip - 9
		waitforuser();	//scrip - 10
			break;

		case 3:	
		eliminar();
		imprimir(txt3);	//scrip - 9
		waitforuser();	//scrip - 10				
			break;
		
		case 4:
		bandera++;
			break;

		default: 
		printf("OPCION INVALIDAD!\n\n");
	}
	} //fin while
}

void ingresar(){
	fflush(stdin);	//limpia buffer de memoria
	printf("\n\nNombre del archivo: ");	//CREAR ARCHIVO
	gets(n_archivo);
	strcat(n_archivo,".txt");
	fflush(stdin);	//limpia buffer de memoria

	pf = fopen(n_archivo,"ab");
	if (pf == NULL){
		puts("\n\tError: EL ARCHIVO NO EXISTE!");
	} else {

	printf("\n\n Ingrese datos al archivo: ");
	gets (datos);		
	fflush(stdin);	//limpia buffer de memoria
	datosx = sizeof(datos);

	fwrite(&datos, sizeof(datosx), 1, pf);	//escribe en el archivo
	cerrarArch();	//cierra el archivo
	}
}

void mostrar(){
	fflush(stdin);
	printf("\n\nNombre del archivo que desea abrir: ");	//CREAR ARCHIVO
	gets(n_archivo);
	strcat(n_archivo,".txt");
	fflush(stdin);
	
	pf = fopen(n_archivo,"rb");
	if (pf == NULL){
		puts("\n\tError: EL ARCHIVO NO EXISTE!");
}else{
	fread(&datos, sizeof(datosx), 1, pf);
	printf("\n\n%s",datos);	//datos del archivo a mostrar 	
	cerrarArch();
	}
}

void eliminar(){
	fflush(stdin);
	printf("\n\nNombre del archivo que desea eliminar: ");	//CREAR ARCHIVO
	gets(n_archivo);
	strcat(n_archivo,".txt");
	fflush(stdin);
		
	pf = fopen(n_archivo,"rb");
	if (pf == NULL){
		puts("\n\tError: EL ARCHIVO NO EXISTE!");
	}else{
	cerrarArch();
	remove(n_archivo);	//Elimina el archivo 
	printf("\n\tEL ARCHIVO AH SIDO ELIMINADO EXITOSAMENTE!");
}
}

void enEspera(){
	asm {
		mov ah,01h
		int 21h
		sub al, 30h //ajuste ascii
		mov bl,1
		mul bl
		mov op,ax
	}
}

void posicionarCursor(char fila,char columna){
   asm{
      mov ah,02h
      mov bh,00
      mov dh,fila
      mov dl,columna
      int 10h
   }
}

void limpiezaPantalla(){
		asm{
		mov ax,0600h	//interrupcion
		mov bh,07h		//atributos de color fondo y texto
        mov CX,0000h	//fila inicial en ch, columna inicial en cl
        mov DX,184fh	//fila final en dh, columna final en cl
        int 10h			//ejecuta las interrupciones de video
		}
}

void imprimir(char texto[]){
   int j;
   char letra;
   j=0;
   while(texto[j]!='$'){
      letra=texto[j];
      asm{
         mov ah,02h
         mov dl,letra
         int 21h
      }
      j++;
   }
}

void waitforuser (){
	asm{
		mov ah,07h
		int 21h
	}
}

void esperar(){
   asm{
   mov cx, 0FH
   mov dx, 8280H
   mov ah, 86H		//Esperar intervalo de microsegundos
   int 15H
   }   
}

void cuadroespera(char a1,char a2){
	asm{
		//cuadro centrado.
		mov ax,0600h
		mov bh,0f0h	//atributos de color fondo y texto
        mov CX,0a0ah//fila inicial en ch, columna inicial en cl
        mov dh,0fh
		mov dl,40h
        int 10h	//ejecuta las interrupciones de video
		//posicion del cursor.
		mov ah,02h
		mov dh,a1
		mov dl,a2	//;sin utilizar un texto con inicio 10,13 en codigo fuente.
		mov bh,0h
		int 10h
	}
	imprimir (txt4);
	esperar();
}

void cerrarArch(){
	asm{
		mov ah,3eh
		int 21h
	}
}

void BanderaMexico (){
		asm{
		mov ax,0600h
		mov bh,020h	//atributos de color fondo y texto
        mov CX,00h	//fila inicial en ch, columna inicial en cl
        mov dx,0f14h
        int 10h		//ejecuta las interrupciones de video	
		
		mov ax,0600h
		mov bh,0f0h	//atributos de color fondo y texto
        mov CX,0015h//fila inicial en ch, columna inicial en cl
        mov dx,0f28h
        int 10h		//ejecuta las interrupciones de video	
		
		mov ax,0600h
		mov bh,0c0h	//atributos de color fondo y texto
        mov CX,0029h//fila inicial en ch, columna inicial en cl
        mov dx,0f3ch
        int 10h		//ejecuta las interrupciones de video	
		
		mov ax,0600h
		mov bh,60h	//atributos de color fondo y texto
        mov CX,41ah	//fila inicial en ch, columna inicial en cl
        mov dx,0a23h
        int 10h		//ejecuta las interrupciones de video
		}
}

/*void ApagarPC (){
	asm{
		mov ax, 5307h
		mov cx, 0003h	//1-stanby 2-reiniciar pc 3-apagar
		int 15h
	}
}*/