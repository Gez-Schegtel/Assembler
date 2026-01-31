
; 6) Cargar un vector por teclado, con 10 elementos e imprimir por pantalla los valores
; ingresados, separados por comas.
;
; Aclaración 1: Ahora, voy a suponer que es un vector con caracteres, una cadena.

name "ejercicio_6_char.2"

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

mostrar_cadena:
  ; 1. Chequeo básico: ¿Terminó la cadena?
  cmp byte ptr [si], 0
  je fin_cadena

  ; 2. Imprimir el carácter actual. Para usar PUTC con memoria, lo más seguro y correcto es siempre cargar el dato en un registro primero.
  mov al, [si]
  putc al

  ; --- 3. LÓGICA DE LA COMA (MIRAR ADELANTE) ---
  ; Verificamos qué hay en la SIGUIENTE posición [si+1]
  cmp byte ptr [si+1], 0
  je saltar_coma  ; Si el siguiente es 0, este es el último. ¡No imprimas coma!

  putc ","
  putc " "

saltar_coma:
  inc si
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
