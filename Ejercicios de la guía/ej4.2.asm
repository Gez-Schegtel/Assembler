; 4) Realice la multiplicación de dos números ingresados por teclado, que almacene el
; resultado en la variable ‘Result’ e imprima el resultado por pantalla.

name "ejercicio_4.2"

org 100h

include "emu8086.inc"

; Pedimos el primer número. Lo almacenamos en BX.
PRINTN "Ingrese un número: "
call SCAN_NUM ; Por definición, esta función almacena el valor leído en CX.
mov bx, cx

PUTC 13
PUTC 10

; Pedimos el segundo número. Lo llevamos a AX para poder hacer el producto.
PRINTN "Ingrese otro número: "
call SCAN_NUM
mov ax, cx

PUTC 13
PUTC 10

mul bx ; Multiplicamos. La función "mul" multiplica el registro que se le indique por lo que haya en AX y lo almacena allí si el resultado es de 8 bits. En 16 bits ocupa DX:AX.

PRINT "El resultado del producto entre estos dos números es: "
call PRINT_NUM ; Esta función escribe por pantalla el contenido de AX.

mov [result], ax

; Fin del programa.
mov ah, 4ch
int 21h

result dw 0

DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
