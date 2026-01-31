
; 12) Realizar un programa que recorre un vector de posiciones de memoria, y encuentra el mayor valor y lo muestre por pantalla.
;
; Aclaraciones sobre las comparaciones:
;
; Regla de oro:
; Unsigned (Solo positivos): Usa JA (Above), JB (Below).
; Signed (Positivos y Negativos): Usa JG (Greater), JL (Less).

name "ejercicio_12"
org 100h
include "emu8086.inc"

mov ah, 09h
mov dx, offset msg_inicio
int 21h

mov si, offset vector
mov cx, 10

call RUTINA_IMPRIMIR

mov si, offset vector
mov cx, 10

lodsw           ; Cargamos el vector[0] en AX. SI avanza al vector[1].
mov bx, ax      ; El primer número es el "Campeón" temporal.
dec cx          ; Restamos 1 vuelta (ahora quedan 9 por revisar).

recorrer_vector:
  lodsw ; MOV AX, [SI]; ADD SI, 2

  cmp ax, bx
  jle no_actualizo

  mov bx, ax

no_actualizo:
  loop recorrer_vector

mov ah, 09h
mov dx, offset msg_resultado
int 21h

mov ax, bx
call PRINT_NUM

mov ah, 4ch
int 21h

RUTINA_IMPRIMIR PROC
  ; Para que esta rutina funcione, SI y CX tienen que estar cargados.
  jeff_buckley:
    lodsw
    call PRINT_NUM

    mov ah, 02h
    mov dl, " "
    int 21h

    loop jeff_buckley
  ret
RUTINA_IMPRIMIR ENDP

msg_inicio    db "Buscando el número mayor del siguiente vector: $"
msg_resultado db 13, 10, "El valor mayor es: $"

vector dw 10, 5, 20, -150, 8, 99, 4, 12, 0, 45

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
