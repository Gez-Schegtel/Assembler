; 3) Realice un programa que sume dos números enteros, ingresados por teclado.

name "ejercicio_3"

org 100h

include "emu8086.inc"

; --- Entrada del primer número ---
mov ah, 09h
mov dx, offset msg_first_num
int 21h
call SCAN_NUM       ; El valor se guarda en CX
mov bx, cx          ; Guardamos el dato en BX para que no se pierda cuando querramos imprimir por pantalla. AX es volátil, acordate.

; Salto de línea (13 = retorno de carro, 10 = salto de linea)
PUTC 13
PUTC 10

; --- Entrada del segundo número ---
mov ah, 09h
mov dx, offset msg_second_num
int 21h
call SCAN_NUM       ; El segundo valor ahora esta en CX
add bx, cx          ; Sumamos BX (num1) + CX (num2)

PUTC 13
PUTC 10

; --- Mostrar resultado ---
mov ah, 09h
mov dx, offset msg_result
int 21h

mov ax, bx
call PRINT_NUM      ; Muestra el valor que esta en AX

; --- Finalizamos el programa ---
mov ah, 4ch
int 21h

msg_first_num db "Ingrese el primer número: $"
msg_second_num db "Ingrese el segundo número: $"
msg_result db "El resultado es: $"

; --- Definiciones de la libreria ---
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
