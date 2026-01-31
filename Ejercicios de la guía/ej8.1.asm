
; 8) Recorra un vector cargado con 10 elementos y copiar el contenido en un segundo vector.

name "ejercicio_8.1"
org 100h
include "emu8086.inc"

mov ah, 09h
mov dx, offset input_msg
int 21h
putc 13
putc 10

mov di, offset vector_entrada
mov cx, 10

cargar_vector:
  push cx

  call SCAN_NUM
  putc 13
  putc 10

  mov [di], cx
  add di, 2

  pop cx

  loop cargar_vector

call CLEAR_SCREEN

mov si, offset vector_entrada
mov di, offset vector_copia
mov cx, 10
cld

copiar_vector:
  lodsw

  mov [di], ax
  add di, 2

  loop copiar_vector

call CLEAR_SCREEN

mov ah, 09h
mov dx, offset vec_ent_msg
int 21h

mov si, offset vector_entrada
mov cx, 10

mostrar_vector_entrada:
  lodsw

  call PRINT_NUM

  mov ah, 02h
  mov dl, " "
  int 21h

  loop mostrar_vector_entrada

mov ah, 09h
mov dx, offset vec_sal_msg
int 21h

mov si, offset vector_copia
mov cx, 10

mostrar_vector_copia:
  lodsw

  call PRINT_NUM

  mov ah, 02h
  mov dl, " "
  int 21h

  loop mostrar_vector_copia

mov ah, 4ch
int 21h

input_msg db "Ingrese un vector de 10 elementos: $"
vec_ent_msg db 13, 10, "Vector de entrada: $"
vec_sal_msg db 13, 10, "Vector de salida: $"
vector_entrada dw 10 dup(?)
vector_copia dw 10 dup(?)

DEFINE_SCAN_NUM
DEFINE_CLEAR_SCREEN
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
