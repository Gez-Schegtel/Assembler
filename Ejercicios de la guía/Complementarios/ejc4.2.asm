
; Recorrer un vector y copiarlo a un segundo vector, solo si el contenido del primer vector es par.
;
; El código es igual a la versión 4.1, pero ahora el usuario ingresa los valores del vector de entrada.

name "comp4"
org 100h
include "emu8086.inc"

mov ah, 09h
mov dx, offset msj_ingreso_datos
int 21h

; Preparamos al vector de entrada para su escritura con lo que ingrese el usuario.
mov di, offset vector_entrada
mov cx, 10

lectura_vector:
  push cx ; Resguardamos el valor del loop para que la función SCAN_NUM no la sobreescriba, perdiéndolo.

  call SCAN_NUM ; Escribe el elemento en el registro cx.
  mov ax, cx
  stosw ; mov [di], ax ^ add 2, di

  pop cx ; Lo recuperamos así puede seguir con la iteración.

  ; Estético. Retorno de carro (13) y salto de línea (10).
  putc 13
  putc 10

  loop lectura_vector

; Limpiamos la terminal para que no quede tan horrible.
call CLEAR_SCREEN

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

msj_ingreso_datos db "Ingrese 10 elementos que conformarán al vector: ", 13, 10, "$"
msj_vector_entrada db 13, 13, "El vector de entrada es: $"
msj_vector_copia db 13, 10, "El vector copia es: $"

vector_entrada dw 10 dup(?)
vector_copia dw 10 dup(?)

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_SCAN_NUM
DEFINE_CLEAR_SCREEN

END
