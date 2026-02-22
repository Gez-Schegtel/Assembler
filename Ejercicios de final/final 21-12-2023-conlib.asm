
; Realizar programa Assembler 8086 que permita imprimir la tabla de multiplicar
; del valor ingresado por pantalla del 1 al 10.

name "final 21-12-23"
org 100h

mov ah, 09h
mov dx, offset msj_1
int 21h

call LEER_NUM ; Esta rutina deja el número listo en el registro CX.
mov num_entrada, cx

call SALTO_LINEA



mov ah, 4ch
int 21h

SALTO_LINEA PROC
  mov ah, 02h
  mov dl, 13
  int 21h
  mov ah, 02h
  mov dl, 10
  int 21h
  ret
SALTO_LINEA ENDP

LEER_NUM PROC
  ; ESTA RUTINA ESCRIBE UN NÚMERO EN CX.

  mov cx, 0 ; CX almacena el total.

  leer_tecla:
    mov ah, 01h ; El núm queda en AL
    int 21h

    cmp al, 13 ; Vemos si terminó
    je fin

    sub al, 30h ; Convertimos a núm.

    mov ah, 0 ; Limpiamos por las dudas la parte alta de AX
    mov bx, ax ; Guardamos el número en BX

    mov ax, cx ; Le pasamos el total a AX (estamos obligados por mul a utilizar AX)
    mov dx, 10 ; Nuestro multiplicador
    mul dx ; Acá estamos haciendo AX = AX * 10

    add ax, bx ; Sumamos el número ingresado por lo que multiplicamos recién por 10
    mov cx, ax ; Actualizamos el total

    jmp leer_tecla

  fin:
    ret
LEER_NUM ENDP

msj_1 db "Ingrese un valor del 1 al 10: $"

num_entrada db ?

END
