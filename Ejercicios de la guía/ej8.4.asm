
; 8) Recorrer un vector cargado con 10 elementos y copiar el contenido en un segundo vector.
; VERSIÓN ULTIMATE: Usando REP MOVSW

name "ejercicio_8.4"
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
  push cx          ; Guardar contador
 
  call SCAN_NUM    ; Leer número

  putc 13
  putc 10

  mov [di], cx     ; Guardar word
  add di, 2        ; Avanzar puntero (Word = 2 bytes)

  pop cx           ; Recuperar contador
  loop cargar_vector

call CLEAR_SCREEN

; --- COPIAR VECTOR ---
mov si, offset vector_entrada
mov di, offset vector_copia
mov cx, 10
cld                ; CLD es asegura que SI y DI avancen (no retrocedan)

; rep: Repite la instrucción siguiente mientras CX > 0
; movsw: Mueve word [SI] a [DI], SI+=2, DI+=2
rep movsw

call CLEAR_SCREEN

; --- MOSTRAR ORIGINAL ---
mov ah, 09h
mov dx, offset vec_ent_msg
int 21h

mov si, offset vector_entrada
mov cx, 10
call rutina_imprimir

; --- MOSTRAR COPIA ---
mov ah, 09h
mov dx, offset vec_sal_msg
int 21h

mov si, offset vector_copia
mov cx, 10
call rutina_imprimir

; FIN
mov ah, 4ch
int 21h

; --- RUTINA AUXILIAR ---
rutina_imprimir PROC
  bucle_print:
    lodsw            ; Carga [SI] en AX y avanza SI
    call PRINT_NUM

    mov ah, 02h
    mov dl, " "
    int 21h
    loop bucle_print
  ret
rutina_imprimir ENDP

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
