
; Realice un programa que anide 3 bucles. Se deberá poder definir la cantidad de
; iteraciones de cada bucle, e imprimir en pantalla un indicador numérico de cada
; iteración.

name "comp2.3"
org 100h
include "emu8086.inc"

mov ah, 09h
mov dx, offset msj_bucle1_input
int 21h
call SCAN_NUM
mov max_1, cx
putc 13
putc 10

mov ah, 09h
mov dx, offset msj_bucle2_input
int 21h
call SCAN_NUM
mov max_2, cx
putc 13
putc 10

mov ah, 09h
mov dx, offset msj_bucle3_input
int 21h
call SCAN_NUM
mov max_3, cx
putc 13
putc 10

mov cx, max_1 ; Cargamos CX con el total de vueltas del 1

loop_1:
  mov ah, 09h
  mov dx, offset msj_bucle1
  int 21h

  push cx ; <--- [GUARDAR] Salvamos el contador del 1 en la Pila
  mov cx, max_2 ; Cargamos CX para el bucle 2 (Pisa el valor anterior, pero ya lo guardamos)

  loop_2:
    mov ah, 09h
    mov dx, offset msj_bucle2
    int 21h

    push cx ; <--- [GUARDAR] Salvamos el contador del 2 en la Pila
    mov cx, max_3 ; Cargamos CX para el bucle 3

    loop_3:
      mov ah, 09h
      mov dx, offset msj_bucle3
      int 21h

      loop loop_3 ; [MOTOR 3] DEC CX. Si CX!=0, salta a loop_3

    pop cx ; <--- [RECUPERAR] Rescatamos el CX del Bucle 2 de la Pila
    loop loop_2 ; [MOTOR 2] Usa el CX recuperado. Si no es 0, repite.

  pop cx ; <--- [RECUPERAR] Rescatamos el CX del Bucle 1
  loop loop_1 ; [MOTOR 1] Usa el CX recuperado.

mov ah, 4ch
int 21h

; Límites (Topes ingresados por usuario)
max_1 dw ?
max_2 dw ?
max_3 dw ?

; Mensajes
msj_bucle1_input db "Iteraciones Bucle 1 (Externo): $"
msj_bucle2_input db 13, 10, "Iteraciones Bucle 2 (Medio): $"
msj_bucle3_input db 13, 10, "Iteraciones Bucle 3 (Interno): $"

msj_bucle1 db 13, 10, "Iterando bucle 1. $"
msj_bucle2 db 13, 10, "   Iterando bucle 2. $"
msj_bucle3 db 13, 10, "       Iterando bucle 3. $"

DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
