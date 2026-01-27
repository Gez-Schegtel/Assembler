; 5) Realice la división entera de dos números ingresados por teclado. Imprima el
; resultado por pantalla y guarde en variables el cociente y resto.
;
; Aclaración: Como uso la función SCAN_NUM para tomar un número, y dicha función lo guarda en CX que es un registro de 16 bits, la división será de 16 bits también.

name "ejercicio_5_lib"

org 100h

include "emu8086.inc"

; --- 1. PRIMER NÚMERO (DIVIDENDO) ---
PRINT "Ingrese el dividendo (numero a dividir): "
call SCAN_NUM       
mov ax, cx          ; Guardamos el 1ro en AX (Dividendo)

PUTC 13
PUTC 10

; --- 2. SEGUNDO NÚMERO (DIVISOR) ---
PRINT "Ingrese el divisor (numero por el cual dividir): "
call SCAN_NUM
mov bx, cx          ; Guardamos el 2do en BX (Divisor)

PUTC 13
PUTC 10

; --- 3. OPERACIÓN DIVISIÓN ---
mov dx, 0           ; OBLIGATORIO: Limpiar parte alta para evitar overflow
div bx              ; Operación: (DX:AX) / BX
                    ; AX = Cociente, DX = Resto

; --- 4. MOSTRAR COCIENTE ---
PRINT "El cociente es: "
call PRINT_NUM      ; Imprime AX
PUTC 13
PUTC 10

; --- 5. MOSTRAR RESTO ---
PRINT "El resto es: "
mov variable_temporal, ax ; Guardo AX un momento porque lo necesito para imprimir DX
mov ax, dx          ; Muevo el Resto (DX) a AX para imprimirlo
call PRINT_NUM      
mov ax, variable_temporal ; Restauro AX (el cociente)

; --- 6. GUARDAR EN MEMORIA ---
mov [cociente], ax
mov [resto], dx

; Fin del programa.
mov ah, 4ch
int 21h

; --- VARIABLES ---
cociente dw 0
resto    dw 0
variable_temporal dw 0 ; Auxiliar para no perder el dato al imprimir

DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
