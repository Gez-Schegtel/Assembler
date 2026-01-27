; 3) Realice un programa que sume dos números enteros, ingresados por teclado.

name "ejercicio_3"

org 100h

include "emu8086.inc"

; --- Entrada del primer número ---
PRINT "Ingrese el primer numero: "
call SCAN_NUM       ; El valor se guarda en CX
mov ax, cx          ; Movemos el primer numero a AX para liberarlo

; Salto de línea (13 = retorno de carro, 10 = salto de linea)
PUTC 13
PUTC 10

; --- Entrada del segundo número ---
PRINT "Ingrese el segundo numero: "
call SCAN_NUM       ; El segundo valor ahora esta en CX
add ax, cx          ; Sumamos AX (num1) + CX (num2)

PUTC 13
PUTC 10

; --- Mostrar resultado ---
PRINT "El resultado de la suma es: "
call PRINT_NUM      ; Muestra el valor que esta en AX

; --- Finalizamos el programa ---
mov ah, 4ch
int 21h

; --- Definiciones de la libreria ---
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
