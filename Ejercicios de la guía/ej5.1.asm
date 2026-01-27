; 5) Realice la división entera de dos números ingresados por teclado. Imprima el
; resultado por pantalla y guarde en variables el cociente y resto.
;
; Aclaración: Como uso la función SCAN_NUM para tomar un número, y dicha función lo guarda en CX que es un registro de 16 bits, la división será de 16 bits también.

name "ejercicio_5_man"

org 100h

include "emu8086.inc"

mov ah, 09h
mov dx, offset msg_dividendo
int 21h
call SCAN_NUM
mov bx, cx ; Resguardo el dividendo para no perderlo cuando imprimo por pantalla.

putc 13
putc 10

mov ah, 09h
mov dx, offset msg_divisor
int 21h
call SCAN_NUM

putc 13
putc 10

mov dx, 0 ; Paso obligatorio para hacer la división de 16 bits.
mov ax, bx
div cx

mov [cociente], ax
mov [resto], dx

mov ah, 09h
mov dx, offset msg_resultado
int 21h

putc 13
putc 10

mov ah, 09h
mov dx, offset msg_resultado_cociente
int 21h

mov ax, [cociente]
call PRINT_NUM

putc 13
putc 10

mov ah, 09h
mov dx, offset msg_resultado_resto
int 21h

mov ax, [resto]
call PRINT_NUM

putc 13
putc 10

; Fin de la ejecución.
mov ah, 4ch
int 21h

msg_dividendo db "Ingrese el dividendo: $"
msg_divisor db "Ingrese el divisor: $"
msg_resultado db "El resultado de la división es: $"
msg_resultado_cociente db "Cociente: $"
msg_resultado_resto db "Resto: $"

cociente dw 0
resto dw 0

DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
