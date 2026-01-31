
; 6) Cargar un vector por teclado, con 10 elementos e imprimir por pantalla los valores
; ingresados, separados por comas.
;
; Aclaración 1: Ahora, voy a suponer que es un vector con caracteres, una cadena.
; Aclaración 2: Es igual al ejercicio 6.3 pero voy a usar la instrucción "lodsb" (Load Data String Byte).

name "ejercicio_6_char.3"

org 100h

include "emu8086.inc"

mov ah, 09h
mov dx, offset msg_input
int 21h

mov di, offset buffer ; Donde se guarda el texto.
mov dx, 50 ; Número máximo de caracteres.
call GET_STRING

call CLEAR_SCREEN

mov ah, 09h
mov dx, offset msg_output
int 21h

mov si, offset buffer
cld ; Esto es por seguridad. Es para indicarle a lodsb que incremente (INC) en vez de decrementar (DEC). No hace falta, pero por seguridad lo puse.

mostrar_cadena:
  lodsb ; Esta función hace dos cosas a la vez: MOV AL, [SI] e INC SI.

  cmp al, 0
  je fin_cadena

  putc al ; La función lodsb ya cargó el caracter en este registro, así que lo puedo mostrar por pantalla tranquilo.

  cmp byte ptr [si], 0 ; La función lodsb ya incrementó SI, o sea que ahora SI ya está apuntando al caracter que sigue.
  je saltar_comas

  putc ","
  putc " "

saltar_comas:
  jmp mostrar_cadena

fin_cadena:

; Fin de la ejecución.
mov ah, 4ch
int 21h

msg_input db "Por favor, ingrese un texto de hasta 50 caracteres: $"
msg_output db "La cadena que ingresaste es: $"
buffer db 50 dup(?)

DEFINE_GET_STRING ; La función GET_STRING funciona con DI para almacenar la cadena y DX para indicar el número máximo de caracteres.
DEFINE_CLEAR_SCREEN

END
