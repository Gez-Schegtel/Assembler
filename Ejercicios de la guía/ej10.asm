
; 10) Realice un programa que recorra el siguiente segmento de datos:
; 2,9,5,12,45,33,99,67,3,1. Y que muestre en pantalla la cantidad de números
; impares.

name "ejercicio_10"
org 100h
include "emu8086.inc"

mov ah, 09h
mov dx, offset msj_sd_original
int 21h

mov si, offset segmento_datos
mov cx, 10
call RUTINA_IMPRIMIR

mov si, offset segmento_datos
mov cx, 10
xor bx, bx
recorrer_vector:
  lodsw

  test al, 1
  jz salto_par

  inc bx

salto_par:
  loop recorrer_vector

mov ah, 09h
mov dx, offset msj_cantidad_impares
int 21h

mov ax, bx
call PRINT_NUM

mov ah, 4ch
int 21h

msj_sd_original db "El segmento de datos original es: $"
msj_cantidad_impares db "La cantidad de números impares es: $"

segmento_datos dw 2,9,5,12,45,33,99,67,3,1

RUTINA_IMPRIMIR PROC
  jeff_buckley:
    lodsw
    call PRINT_NUM
    mov ah, 02h
    mov dl, " "
    int 21h
    loop jeff_buckley
    putc 13
    putc 10
  ret
RUTINA_IMPRIMIR ENDP

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
