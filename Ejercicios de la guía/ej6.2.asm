
; 6) Cargar un vector por teclado, con 10 elementos e imprimir por pantalla los valores
; ingresados, separados por comas.
;
; Aclaración 1: Ahora, voy a suponer que es un vector con caracteres, una cadena.
; Aclaración 2: Voy a imprimir la cadena sin las comas, para practicar un poco.

name "ejercicio_6_char.1"

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
call PRINT_STRING

; Fin de la ejecución.
mov ah, 4ch
int 21h

msg_input db "Por favor, ingrese un texto de hasta 50 caracteres: $"
msg_output db "La cadena que ingresaste es: $"
buffer db 50 dup(?)

DEFINE_GET_STRING ; La función GET_STRING funciona con DI para almacenar la cadena y DX para indicar el número máximo de caracteres.
DEFINE_PRINT_STRING ; Esta función lee el contenido de SI.
DEFINE_CLEAR_SCREEN

END
