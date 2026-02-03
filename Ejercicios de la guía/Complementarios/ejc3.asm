
; Realizar un programa que funcione como calculadora de 2 numeros enteros, y
; permita realizar las 4 operaciones basicas. Se debe ingresar por teclado los
; numeros y la operacion a realizar. Luego imprimir por pantalla el resultado
; obtenido.                                           

name "comp3"
org 100h
include "emu8086.inc"

mov ah, 09h
mov dx, offset msj_input 
int 21h
putc 13
putc 10

call SCAN_NUM
mov num1, cx
putc 13
putc 10

call SCAN_NUM
mov num2, cx
putc 13
putc 10

mov ah, 09h
mov dx, offset msj_input2
int 21h    
putc 13
putc 10

call SCAN_NUM
mov op, cx
putc 13
putc 10

cmp op, 1
je suma

cmp op, 2
je resta        

cmp op, 3
je multiplicacion

cmp op, 4
je division 

suma:
    mov ah, 09h 
    mov dx, offset msj_sum
    int 21h
    mov ax, num1 
    add ax, num2 ;el resultado ya queda en ax 
    call PRINT_NUM
    jmp fin_programa

resta: 
    mov ah, 09h
    mov dx, offset msj_res
    int 21h 
    mov ax, num1
    sub ax,num2
    call PRINT_NUM
    jmp fin_programa     

multiplicacion: 
    mov ah, 09h
    mov dx, offset msj_mul
    int 21h
    mov ax, num1
    mul num2
    call PRINT_NUM
    jmp fin_programa

division: 
    xor dx, dx
    mov ax, num1
    div num2
    mov res, dx
    mov coc, ax
    
    mov ah, 09h
    mov dx, offset msj_div_res
    int 21h
    mov ax, res
    call PRINT_NUM ;la funcion PRINT_NUM lee en ax   
    
    putc 13
    putc 10
    
    mov ah, 09h
    mov dx, offset msj_div_coc
    int 21h
    mov ax, coc 
    call PRINT_NUM
    putc 13
    putc 10
     

fin_programa: 
    mov ah, 4ch
    int 21h

msj_input db "Ingrese dos numeros: $"
msj_input2 db "Ingrese la operacion a realizar (SUM >> 1, RES >> 2, MUL >> 3, DIV >> 4): $"
msj_sum db "El resultado de la suma es: $"
msj_res db "El resultado de la resta es: $"
msj_mul db "El resultado de la multiplicacion es: $"
msj_div_res db "El resto de la division es: $"
msj_div_coc db "El cociente de la division es: $"
  
num1 dw ?
num2 dw ?
op dw ?
res dw ?
coc dw ? 

DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS 



END
