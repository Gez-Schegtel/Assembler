
; Realice un programa que sume dos números hexadecimales de 32 bits previamente definidos.
;
; Suma de dos numeros de 32 bits en un procesador de 16 bits.
; Usamos la logica: High:Low

name "suma_32bits"
org 100h
include "emu8086.inc"

; --- 1. SUMA DE LA PARTE BAJA (Los bits menos significativos) ---
mov ax, num1_low    ; Cargamos parte baja del 1ro
add ax, num2_low    ; Sumamos parte baja del 2do
mov res_low, ax     ; Guardamos resultado parcial

; En este punto, si la suma superó FFFFh, la bandera de Carry (CF) se encendió.

; --- 2. SUMA DE LA PARTE ALTA (Los bits más significativos) ---
mov ax, num1_high   ; Cargamos parte alta del 1ro
adc ax, num2_high   ; <--- LA CLAVE: ADC suma (AX + num2_high + Carry)
mov res_high, ax    ; Guardamos resultado final

; --- 3. MOSTRAR RESULTADO (En Hexadecimal) ---
PRINT "El resultado es: "

; Imprimimos primero la parte ALTA
mov bx, res_high
call PRINT_HEX

; Imprimimos pegada la parte BAJA
mov bx, res_low
call PRINT_HEX

PRINTN "h" ; La 'h' de hexadecimal

mov ah, 4ch
int 21h

; --- DATOS ---
; Vamos a sumar: 1234 5678 + 0005 FFFF
; Resultado esperado: 123A 5677

; Numero 1: 12345678h
num1_high dw 1234h
num1_low  dw 5678h

; Numero 2: 0005FFFFh (Puse FFFF aproposito para generar Carry en la parte baja)
num2_high dw 0005h
num2_low  dw 0FFFFh

; Resultado (32 bits)
res_high  dw ?
res_low   dw ?

; --- RUTINA PARA IMPRIMIR HEXADECIMAL (16 BITS) ---
; Imprime el valor contenido en BX
PRINT_HEX PROC
    push ax
    push cx
    push dx

    mov cx, 4          ; 4 digitos hexadecimales en 16 bits

print_loop:
    mov dx, bx
    shr dx, 12         ; Movemos los 4 bits mas altos al principio

    cmp dl, 9
    jbe es_numero
    add dl, 7          ; Ajuste para letras A-F
es_numero:
    add dl, 48         ; Convertir a ASCII

    mov ah, 02h        ; Imprimir caracter
    int 21h

    rol bx, 4          ; Rotamos para traer el siguiente digito
    loop print_loop

    pop dx
    pop cx
    pop ax
    ret
PRINT_HEX ENDP

END
