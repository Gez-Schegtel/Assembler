
; 9) Recorrer un vector y copiarlo a un segundo vector, solo los contenidos impares del primer vector.

name "ejercicio_9"
org 100h
include "emu8086.inc"

mov ah, 09h
mov dx, offset msj1
int 21h

mov si, offset vector_original
mov cx, 10
call RUTINA_IMPRIMIR

mov si, offset vector_original
mov di, offset vector_impares
mov cx, 10
xor bx, bx ; Contador de impares.

copiar_impares:
  lodsw
  test ax, 1
  jz salto_par

  stosw
  inc bx

salto_par:
  loop copiar_impares

cmp bx, 0 ; Si no hay números impares, saltamos la llamada al vector de impares que va a estar vacío. Además, genera un error si CX es 0.
je fin_programa

mov ah, 09h
mov dx, offset msj2
int 21h

mov si, offset vector_impares
mov cx, bx
call RUTINA_IMPRIMIR

fin_programa:
  mov ah, 4ch
  int 21h

RUTINA_IMPRIMIR PROC
bucle_print:
  lodsw
  call PRINT_NUM

  mov ah, 02h
  mov dl, " "
  int 21h

  loop bucle_print

  putc 13
  putc 10
ret
RUTINA_IMPRIMIR ENDP

msj1 db "Vector original: $"
msj2 db 13, 10, "Vector con los números impares: $"

vector_original dw 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
vector_impares dw 10 dup(?)

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
