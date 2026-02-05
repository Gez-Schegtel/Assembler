
; Separar en dos arreglos los números pares e impares leídos de un arreglo
; previamente definido en memoria.

name "comp5"
org 100h
include "emu8086.inc"

PRINT "Vector original: "
mov si, offset vector_original
mov cx, 10
call RUTINA_IMPRIMIR

mov si, offset vector_original
mov cx, 10
mov di, offset vector_pares
xor bx, bx

copiar_pares:
  lodsw

  test ax, 1
  jnz no_copio_pares

  stosw
  inc bx

  no_copio_pares:
    loop copiar_pares

cmp bx, 0
jne hubo_pares
PRINTN "No se encontraron elementos pares."
jmp buscamos_impares

hubo_pares:
  mov si, offset vector_pares
  mov cx, bx
  PRINT "Vector de números pares: "
  call RUTINA_IMPRIMIR

buscamos_impares:
  mov si, offset vector_original
  mov cx, 10
  mov di, offset vector_impares
  xor bx, bx

copiar_impares:
  lodsw

  test ax, 1
  jz no_copio_impares

  stosw
  inc bx

  no_copio_impares:
    loop copiar_impares

cmp bx, 0
jne hubo_impares
PRINTN "No se encontraron elementos impares."
jmp fin_programa

hubo_impares:
  mov si, offset vector_impares
  mov cx, bx
  PRINT "Vector de números impares: "
  call RUTINA_IMPRIMIR

; Fin de la ejecución.
fin_programa:
  mov ah, 4ch
  int 21h

; Datos.
vector_original dw 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
vector_pares dw 10 dup(?)
vector_impares dw 10 dup(?)

; Rutinas.
RUTINA_IMPRIMIR PROC
; Para llamar a esta rutina tenés que preparar a los registros SI y CX.
imprimir:
  lodsw
  call PRINT_NUM
  PRINT " "
  loop imprimir

  PRINTN " "
ret
RUTINA_IMPRIMIR ENDP

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
