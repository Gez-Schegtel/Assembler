
; 7) Recorrer un vector y contar la cantidad de valores IMPARES. Imprimir resultado por pantalla.
;
; Aclaración: Esta es como la forma "manual" de hacerlo.

name "ejercicio_7.1"
org 100h
include "emu8086.inc"

; 1. Bienvenida
mov ah, 09h
mov dx, offset msg_bienvenida
int 21h

; 2. Configuración
mov si, offset vector
mov cx, 15 ; Número de elementos que tiene el vector. Esto controla entonces el bucle para recorrerlo.
xor bx, bx ; El registro BL será nuestro contador de impares. Acá por precaución, ponemos en cero todo el registro BX.

mov ah, 09h
mov dx, offset msg_salida_vector
int 21h

recorrer_vector:
    ; A. Guardar el valor original para no perderlo
    ;    (Porque DIV va a destruir AX)
    xor ax, ax
    mov al, [si]
    push ax        ; Guardamos en la Pila (Stack)

    ; B. División
    ;    Dividimos AX por la variable de memoria 'divisor' (que vale 2)
    div divisor    ; AL = Cociente, AH = Resto

    cmp ah, 0      ; Chequeamos el RESTO
    je es_par      ; Si es 0, no contamos
    inc bl         ; Si no es 0, contamos como impar

es_par:
    ; C. Recuperar valor original para imprimir
    pop ax         ; Recuperamos de la Pila
    call PRINT_NUM ; Imprimimos el número original (ej: 15)

    mov ah, 02h
    mov dl, " "    ; Espacio estético
    int 21h

    inc si         ; Avanzamos puntero
    loop recorrer_vector ; Ahora sí: CX baja de 15 a 0.

; 3. Final y Resultado
mov ah, 09h
mov dx, offset msg_salida_resultado
int 21h

xor ax, ax
mov al, bl         ; Pasamos el contador a AX para imprimir
call PRINT_NUM

; Fin de la ejecución.
mov ah, 4ch
int 21h

; --- DATOS ---
msg_bienvenida       db "Contando impares...$"
msg_salida_vector    db 13, 10, "Vector: $" ; Acá le doy un salto de línea antes de mostar el mensaje por pantalla.
msg_salida_resultado db 13, 10, "Total impares: $"

vector  db 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
divisor db 2

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
