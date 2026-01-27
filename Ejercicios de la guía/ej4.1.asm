; 4) Realice la multiplicación de dos números ingresados por teclado, que almacene el
; resultado en la variable ‘Result’ e imprima el resultado por pantalla.

name "ejercicio_4.1"

org 100h

include "emu8086.inc"

; Pedimos el primer número. Lo almacenamos en BX.
mov ah, 9h
mov dx, offset msg_num1
int 21h
call SCAN_NUM ; Por definición, esta función almacena el valor leído en CX.
mov bx, cx

; Salto de línea con retorno del carro.
PUTC 13
PUTC 10

; Pedimos el segundo número. Lo llevamos a AX para poder hacer el producto.
mov ah, 9h
mov dx, offset msg_num2
int 21h
call SCAN_NUM
mov ax, cx

; Salto de línea con retorno del carro.
PUTC 13
PUTC 10

mul bx ; Multiplicamos. La función "mul" multiplica el registro que se le indique por lo que haya en AX y lo almacena allí si el resultado es de 8 bits. En 16 bits ocupa DX:AX.
mov bx, ax ; Resguardamos el valor de AX en BX para poder escribir por pantalla un mensaje.

mov ah, 9h
mov dx, offset msg_resultado
int 21h

mov ax, bx
call PRINT_NUM ; Esta función escribe por pantalla el contenido de AX.

mov [result], ax

; Fin del programa.
mov ah, 4ch
int 21h

msg_num1 db "Ingrese un número: $"
msg_num2 db "Ingrese otro número: $"
msg_resultado db "El resultado del producto de los números es: $"
result dw 0

DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
