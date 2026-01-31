
; 6) Cargar un vector por teclado, con 10 elementos e imprimir por pantalla los valores
; ingresados, separados por comas.
;
; Aclaración 1: Ahora, voy a suponer que es un vector con caracteres, una cadena.
; Aclaración 2: Es igual al ejercicio 6.5 pero voy a usar la llamada mov ah, 0Ah para leer la cadena.

name "ejercicio_6_char.5"

org 100h

include "emu8086.inc"

mov ah, 09h
mov dx, offset msg_input
int 21h

mov ah, 0Ah ; Esta función como marca de fin guarda ENTER, o sea, 13.
mov dx, offset buffer ; Apunta al BYTE 0.
int 21h

call CLEAR_SCREEN

mov ah, 09h
mov dx, offset msg_output
int 21h

mov si, offset buffer + 2 ; Nos vamos al BYTE 2, donde está el texto.

mostrar_cadena:
  cmp byte ptr [si], 13 ; Vemos si se llegó al fin.
  je fin_cadena

  mov ah, 02h
  mov dl, [si]
  int 21h

  cmp byte ptr [si + 1], 13
  je saltar_coma

  mov ah, 02h
  mov dl, ","
  int 21h
  mov dl, " "
  int 21h

saltar_coma:
  inc si
  jmp mostrar_cadena

fin_cadena:

; Fin de la ejecución.
mov ah, 4ch
int 21h

msg_input db "Por favor, ingrese un texto de hasta 50 caracteres: $"
msg_output db "La cadena que ingresaste es: $"

; Estructura necesaria para la función 0Ah. Esto significa que la función 0Ah no pide una variable, sino que necesita una estructura de datos que es la siguiente...
buffer db 51 ; BYTE 0: Este espacio guarda el tamaño: 50 caracteres de info más el ENTER de confirmación.
       db ?  ; BYTE 1: Acá se guarda hasta qué posición escribió. Si ingresaste una cadena de 10 caracteres, almacena dicho 10.
       db 51 dup(?) ; BYTE 2..n: Y acá es donde reside la cadena o texto ingresado.

DEFINE_CLEAR_SCREEN

END
