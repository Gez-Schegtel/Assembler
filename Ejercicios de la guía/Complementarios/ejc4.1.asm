
; Recorrer un vector y copiarlo a un segundo vector, solo si el contenido del primer vector es par.

name "comp4"
org 100h
include "emu8086.inc"

; Preparamos el vector de entrada para su recorrido.
mov si, offset vector_entrada
mov cx, 10

; Preparamos el recorrido del vector copia.
mov di, offset vector_copia

; En teoría, un escenario típico es no saber cuántos elementos se copiaron. Por eso, preparamos este contador.
xor bx, bx

proceso:
  lodsw ; mov ax, [si] ^ add si, 2

  test ax, 1
  jnz no_copio

  ; Si la ejecución cae por acá, se hace la copia.
  stosw ; mov [di], ax ^ add di, 2
  inc bx

no_copio:
  loop proceso

mov ah, 09h
mov dx, offset msj_vector_entrada
int 21h

mov si, offset vector_entrada
mov cx, 10
call RUTINA_IMPRIMIR

mov ah, 09h
mov dx, offset msj_vector_copia
int 21h

mov si, offset vector_copia
mov cx, bx
call RUTINA_IMPRIMIR

; Fin de la ejecución.
mov ah, 4ch
int 21h

RUTINA_IMPRIMIR PROC
; Tener listo cx y si para llamar a la rutina.
impresion:
  lodsw
  call PRINT_NUM

  mov ah, 02h
  mov dl, " "
  int 21h

  loop impresion
ret
RUTINA_IMPRIMIR ENDP

msj_vector_entrada db "El vector de entrada es: $"
msj_vector_copia db 13, 10, "El vector copia es: $"

vector_entrada dw 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
vector_copia dw 10 dup(?)

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
