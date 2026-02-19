
; Realizar programa Assembler 8086 que permita el ingreso de un carácter y una cadena de caracteres tipeadas por pantalla. Al presionar ENTER deberá indicar la cantidad de coincidencias de dicho carácter en la misma. 

name "contar_letras"
org 100h
include "emu8086.inc"

PRINTN "Ingrese una cadena de texto: "

mov di, offset cadena
mov dx, 50
call GET_STRING

putc 13
putc 10

PRINTN "Ingrese un caracter: "

mov ah, 01h
int 21h

putc 13
putc 10

mov si, offset cadena
xor bx, bx
mov dl, al ; El caracter que ingresó el usuario está en el registro AL.

recorrer_vector:
  mov al, [si]

  cmp al, 0
  je fin_programa

  cmp [si], dl
  jne no_cuento

  inc bx

no_cuento:
  inc si
  jmp recorrer_vector

fin_programa:
  PRINT "Número de coincidencias: "
  mov ax, bx ; Usamos el registro AX porque es el registro que utiliza la función PRINT_NUM
  call PRINT_NUM
  mov ah, 4ch
  int 21h

cadena db 50 dup(?)

DEFINE_GET_STRING
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
