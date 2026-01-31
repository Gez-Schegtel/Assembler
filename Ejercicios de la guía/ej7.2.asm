
; 7) Recorrer un vector y contar la cantidad de valores IMPARES. Imprimir resultado por pantalla.
;
; Aclaración: Ahora nos vamos a ayudar con funciones.

name "ejercicio_7.2"
org 100h
include "emu8086.inc"

; Mensajito de bienvenida.
mov ah, 09h
mov dx, offset msg_bienvenida
int 21h

mov si, offset vector
mov cx, 15 ; Número de elementos que tiene el vector.
xor bx, bx ; El registro BX será nuestro contador de impares. Acá por precaución, ponemos en cero al registro.
cld ; Esto es para asegurar que lodsb esté incrementando SI.

; Mensajito para mostrar todos los elementos del vector.
mov ah, 09h
mov dx, offset msg_salida_vector
int 21h

recorrer_vector:
  xor ax, ax ; Ponemos en cero al registro antes de cargarlo para asegurarnos de que no haya "basura" en la parte alta.

  lodsb ; Esta función toma lo que tenga el registro SI y hace lo siguiente en un solo ciclo: mov al, [si] , inc si

  test al, 1 ; Acá test toma el bit menos significativo del número almacenado en AL y hace un AND con 1.
             ; Si el resultado es 1, quiere decir el número es impar. Caso contrario, el número es par.
  jz salto_contador

  inc bx

salto_contador:
  call PRINT_NUM

  ; Pongo un espacio estético entre los elementos del vector.
  mov ah, 02h
  mov dl, " "
  int 21h

  loop recorrer_vector

; Mensajito de salida con el resultado.
mov ah, 09h
mov dx, offset msg_salida_resultado
int 21h

; Preparamos el registro AX para poder mostrar el resultado de la cuenta.
xor ax, ax
mov al, bl
call PRINT_NUM

; Fin de la ejecución.
mov ah, 4ch
int 21h

; --- DATOS ---
msg_bienvenida       db "Contando impares...$"
msg_salida_vector    db 13, 10, "Vector: $" ; Acá le doy un salto de línea antes de mostar el mensaje por pantalla.
msg_salida_resultado db 13, 10, "Total impares: $"

vector  db 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
