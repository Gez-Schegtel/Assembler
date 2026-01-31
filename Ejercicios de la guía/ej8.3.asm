
; 8) Recorra un vector cargado con 10 elementos y copiar el contenido en un segundo vector.
;
; Aclaración: Descubrí la función movsw: Mueve lo que hay en [SI] directamente a [DI] y avanza ambos punteros (2 bytes).

name "ejercicio_8.3"
org 100h
include "emu8086.inc"

; --- MENSAJE INICIAL ---
mov ah, 09h
mov dx, offset input_msg
int 21h
putc 13
putc 10

; --- CARGAR VECTOR ---
mov di, offset vector_entrada
mov cx, 10

cargar_vector:
  push cx          ; Guardamos contador del loop
  
  call SCAN_NUM    ; Lee número en CX
  
  putc 13
  putc 10

  mov [di], cx     ; Guardamos el número (16 bits)
  add di, 2        ; Avanzamos 2 bytes porque es DW
  
  pop cx           ; Recuperamos contador
  loop cargar_vector

call CLEAR_SCREEN

; --- COPIAR VECTOR ---
mov si, offset vector_entrada
mov di, offset vector_copia
mov cx, 10
cld                ; Dirección hacia adelante

copiar_vector:
  movsw
  loop copiar_vector

call CLEAR_SCREEN

; --- MOSTRAR ORIGINAL ---
mov ah, 09h
mov dx, offset vec_ent_msg
int 21h

mov si, offset vector_entrada
mov cx, 10

mostrar_vector_entrada:
  lodsw            ; Carga en AX
  call PRINT_NUM
  
  mov ah, 02h
  mov dl, " "
  int 21h
  loop mostrar_vector_entrada

; --- MOSTRAR COPIA ---
mov ah, 09h
mov dx, offset vec_sal_msg
int 21h

mov si, offset vector_copia ; Apuntamos al segundo vector
mov cx, 10

mostrar_vector_copia:
  lodsw            ; Carga en AX
  call PRINT_NUM
  
  mov ah, 02h
  mov dl, " "
  int 21h
  loop mostrar_vector_copia

; FIN
mov ah, 4ch
int 21h

; --- DATOS ---
input_msg   db "Cargar 10 numeros: $"
vec_ent_msg db 13, 10, "Original: $"
vec_sal_msg db 13, 10, "Copia:    $"

vector_entrada dw 10 dup(?)
vector_copia   dw 10 dup(?)

DEFINE_SCAN_NUM
DEFINE_CLEAR_SCREEN
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
