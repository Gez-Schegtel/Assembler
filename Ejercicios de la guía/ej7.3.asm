
; 7) Recorrer un vector y contar la cantidad de valores IMPARES. Imprimir resultado por pantalla.
;
; Aclaración: Ahora nos vamos a ayudar con funciones y pediremos el vector al usuario.

name "ejercicio_7.3"
org 100h
include "emu8086.inc"

; Mensajito de bienvenida.
mov ah, 09h
mov dx, offset msg_bienvenida
int 21h

putc 13
putc 10

mov di, offset vector ; Acá vamos a guardar el vector.
mov cx, 15 ; Tamaño del vector.

ingresar_vector:
  push cx ; Tenemos que resguardar el valor del loop porque al leer con SCAN_NUM sobreescribimos ese registro.

  call SCAN_NUM

  putc 13
  putc 10

  mov [di], cx
  add di, 2

  pop cx

  loop ingresar_vector

call CLEAR_SCREEN

mov si, offset vector
mov cx, 15 ; Número de elementos que tiene el vector.
xor bx, bx ; El registro BX será nuestro contador de impares. Acá por precaución, ponemos en cero al registro.
cld ; Esto es para asegurar que lodsb esté incrementando SI.

; Mensajito para mostrar todos los elementos del vector.
mov ah, 09h
mov dx, offset msg_salida_vector
int 21h

recorrer_vector:
  lodsw ; Esta función toma lo que tenga el registro SI y hace lo siguiente en un solo ciclo: mov ax, [si] ; add si, 2

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
mov ax, bx
call PRINT_NUM

; Fin de la ejecución.
mov ah, 4ch
int 21h

; --- DATOS ---
msg_bienvenida       db "Ingrese un vector de números: $"
msg_salida_vector    db 13, 10, "Vector: $" ; Acá le doy un salto de línea antes de mostar el mensaje por pantalla.
msg_salida_resultado db 13, 10, "Total impares: $"

vector dw 15 dup(?) ; Como vamos a leer los elementos con SCAN_NUM, y esta función los guarda en el registro CX de 16 bits, cada elemento es de 16 bits.

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_SCAN_NUM
DEFINE_CLEAR_SCREEN

END
