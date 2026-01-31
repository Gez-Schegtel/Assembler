
; 6) Cargar un vector por teclado, con 10 elementos e imprimir por pantalla los valores
; ingresados, separados por comas.
;
; Aclaración: Voy a suponer que es un vector de números.

name "ejercicio_6_num"

org 100h

include "emu8086.inc"

mov cx, 10
mov di, offset vector ; Vamos a usar di (destination index) para ir moviéndonos por el vector en la escritura.

cargar_vector:
  push cx ; Resguardamos el valor del loop actual, porque la función SCAN_NUM escribe en CX.

  mov ah, 09h
  mov dx, offset msg_input
  int 21h
  call SCAN_NUM
  putc 13
  putc 10

  mov [di], cx

  add di, 2 ; Acordate que los datos son de 16 bits, por lo que se tiene que hacer un salto doble.

  pop cx

  loop cargar_vector

call CLEAR_SCREEN

mov cx, 10
mov si, offset vector ; Usamos si (source index) para ir moviéndonos por el vector en la lectura.

mostrar_vector:
  mov ax, [si]
  call PRINT_NUM ; La función PRINT_NUM lee el contenido del registro ax

  cmp cx, 1
  je avanzar_último

  putc ","

avanzar_último:
  add si, 2 ; Acordate que los datos son de 16 bits, por lo que se tiene que hacer un salto doble.

  loop mostrar_vector

; Fin de la ejecución.
mov ah, 4ch
int 21h

vector dw 10 dup(0) ; Como los valores que vamos a tomar se guardan en CX, que es un registro de 16 bits, el vector será uno con elementos de 16 bits también.
msg_input db "Ingrese un elemento: $"

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_SCAN_NUM
DEFINE_CLEAR_SCREEN

END
