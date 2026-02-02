
; Dado dos números ingresados por teclado, determinar cuál es el mayor de ellos, y si este es múltiplo del menor.
;
; Aclaración: Voy a utilizar la división de 8 bits.

name "comp1"
org 100h
include "emu8086.inc"

; --- INPUTS ---
mov ah, 09h
mov dx, offset msj_input1
int 21h
call SCAN_NUM
mov num1, cl

mov ah, 09h
mov dx, offset msj_input2
int 21h
call SCAN_NUM
mov num2, cl

; --- SELECCIÓN MAYOR/MENOR ---
mov al, num1
cmp al, num2
ja num1_mayor
jb num2_mayor

; Caso A: Son iguales los números.
mov ah, 09h
mov dx, offset msj_iguales
int 21h
jmp es_multiplo

; Caso B: Num1 Mayor
num1_mayor:
  mov bl, num2        ; En AL ya está num1. BL = Menor (Divisor)
  jmp imprimir_y_calcular

num2_mayor:
  ; Caso C: Num2 Mayor
  mov al, num2        ; AL = Mayor (Dividendo)
  mov bl, num1        ; BL = Menor (Divisor)

imprimir_y_calcular:
  ; --- IMPRIMIR MAYOR ---
  push ax             ; Guardamos AX (Mayor)

  mov ah, 09h
  mov dx, offset msj_output
  int 21h

  pop ax              ; Recuperamos AX
  xor ah, ah          ; Limpiamos AH para imprimir
  call PRINT_NUM

  ; --- CÁLCULO ---
  ; Tenemos: AL = Mayor, BL = Menor

  cmp bl, 0           ; Seguridad: División por cero
  je no_es_multiplo

  ; IMPORTANTE: Como SCAN_NUM devuelve en CL (8 bits), 
  ; asumimos que los números son pequeños.
  ; Para DIV BL, el dividendo es AX.
  ; Aseguramos que AH sea 0 para dividir solo AL.
  xor ah, ah

  div bl              ; AX / BL -> Resto en AH

  cmp ah, 0           ; ¿El resto es 0?
  je es_multiplo      ; Si es 0, es múltiplo

  ; Si no saltó, cae aquí:
  jmp no_es_multiplo

es_multiplo:
  mov ah, 09h
  mov dx, offset msj_esmul
  int 21h
  jmp fin

no_es_multiplo:
  mov ah, 09h
  mov dx, offset msj_noesmul
  int 21h

fin:
  mov ah, 4ch
  int 21h

; --- DATOS ---
msj_input1     db "Número 1: $"
msj_input2     db 13, 10, "Número 2: $"
msj_output     db 13, 10, "El número mayor es: $"
msj_esmul      db 13, 10, "El número mayor es múltiplo del menor.$"
msj_noesmul    db 13, 10, "El número mayor no es múltilpo del menor.$"
msj_iguales    db 13, 10, "Los números son iguales.$"

num1 db ?
num2 db ?

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_SCAN_NUM

END
