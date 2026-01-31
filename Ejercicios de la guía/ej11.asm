
; 11) Recorrer un vector que cuente la cantidad de contenidos que tengan ceros en los bits 0, 1, 4 y 5. 
; Al finalizar debe mostrar por pantalla: la cantidad y los valores que cumplen la condición.
;
; El ejercicio te pide que, para que un número sea "elegido", debe tener un 0 obligatoriamente en las posiciones marcadas:
;
; x x 0 0 x x 0 0
;
; (Las 'x' pueden ser 0 o 1, no nos importan).
;
;
; Para ello, se crea lo que se conoce como máscara. La regla para hacerla es...
;
; "Donde te interesa mirar, pones un 1. Donde NO te interesa mirar, pones un 0."
;
; Decisión: Como quiero que sean CEROS, necesito que el TEST de "nada" (Zero).


name "ejercicio_11"
org 100h
include "emu8086.inc"

mov ah, 09h
mov dx, offset msj_inicio
int 21h

mov si, offset vector_datos
mov cx, 10

call RUTINA_IMPRIMIR

mov si, offset vector_datos
mov cx, 10
xor bx, bx ; Contador de valores que cumplen la condición.
mov di, offset vector_condicion ; Acá vamos almacenando los valores que cumplan la condición.

recorrer_vector_inicial:
  lodsw ; MOV AX, [SI], ADD SI, 2

  test ax, mascara
  jnz no_cumple_condicion

  inc bx ;
  stosw ; MOV DI, [SI], ADD DI, 2

no_cumple_condicion:
  loop recorrer_vector_inicial

; Si no hay ningún valor que cumpla la condición, saltamos al fin del programa.
cmp bx, 0
je fin_programa

mov ah, 09h
mov dx, offset msj_cantidad
int 21h

mov ax, bx
call PRINT_NUM

mov ah, 09h
mov dx, offset msj_valores
int 21h

mov si, offset vector_condicion
mov cx, bx ; Con el dato de los números que cumplieron la condición, podemos saber cuántas posiciones tenemos que recorrer el vector de números que cumplieron la condición.

call RUTINA_IMPRIMIR

fin_programa:
  mov ah, 4ch
  int 21h

RUTINA_IMPRIMIR proc
  jeff_buckley:
    lodsw
    call PRINT_NUM
    mov ah, 02h
    mov dl, " "
    int 21h
    loop jeff_buckley
  ret
RUTINA_IMPRIMIR ENDP

msj_inicio db "Vector a analizar: $"
msj_cantidad db 13, 10, "Cantidad de valores que cumplen la condición: $"
msj_valores db 13, 10, "Valores que cumplen las condición: $"

; Vector de prueba con números variados:
; 4   = 00000100 (Bit 2 en 1. Bits 0,1,4,5 en 0) -> CUMPLE
; 255 = 11111111 (Todos en 1) -> NO CUMPLE
; 64  = 01000000 (Bit 6 en 1. Resto 0) -> CUMPLE
; 1   = 00000001 (Bit 0 en 1) -> NO CUMPLE
vector_datos dw 4, 255, 64, 1, 8, 12, 51, 100, 0, 32

vector_condicion 10 dw dup(?)

; La máscara. La declaramos en binario.
mascara dw 00110011b

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
