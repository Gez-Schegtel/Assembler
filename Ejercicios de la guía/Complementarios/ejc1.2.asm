
; Dado dos números ingresados por teclado, determinar cuál es el mayor de ellos, y si este es múltiplo del menor.
;
; Aclaración: Voy a utilizar la división de 16 bits.

name "comp1"
org 100h
include "emu8086.inc"

mov ah, 09h
mov dx, offset msj_input1
int 21h
call SCAN_NUM
mov num1, cx

mov ah, 09h
mov dx, offset msj_input2
int 21h
call SCAN_NUM
mov num2, cx

mov ax, num1
cmp ax, num2
jg num1_may
jl num2_may

mov ah, 09h
mov dx, offset msj_iguales
int 21h
jmp son_multiplos

num1_may:
  mov bx, num2
  jmp imprimir_may

num2_may:
  mov ax, num2
  mov bx, num1

imprimir_may:
  push ax ; Tenemos que guardar el valor de AX porque al imprimir algo por pantalla, se pierde.

  mov ah, 09h
  mov dx, offset msj_output
  int 21h

  pop ax

  call PRINT_NUM

calcular_multiplo:
  cmp bx, 0 ; Hay que ser prudentes y ver si el divisor es cero.
  je no_son_multiplos

  xor dx, dx ; Estoy hay que hacer siempre antes de hacer la división de 16 bits.
  div bx ; División de 16 bits entre DX:AX y BX. En DX queda el resto, en AX el cociente.

  cmp DX, 0
  je son_multiplos
  jmp no_son_multiplos

son_multiplos:
  mov ah, 09h
  mov dx, offset msj_esmul
  int 21h
  jmp fin_programa

no_son_multiplos:
  mov ah, 09h
  mov dx, offset msj_noesmul
  int 21h

fin_programa:
  mov ah, 4ch
  int 21h

; --- DATOS ---
msj_input1     db "Número 1: $"
msj_input2     db 13, 10, "Número 2: $"
msj_output     db 13, 10, "El número mayor es: $"
msj_esmul      db 13, 10, "El número es múltiplo.$"
msj_noesmul    db 13, 10, "El número no es múltiplo.$"
msj_iguales    db 13, 10, "Los números son iguales.$"

num1 dw ?
num2 dw ?

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_SCAN_NUM

END
