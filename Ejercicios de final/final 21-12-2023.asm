
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

mov cx, 1
multiplicacion:
  mov ax, num_entrada
  call ESCRIBIR_NUM

  mov ah, 02h
  mov dl, "x"
  int 21h

  mov ax, cx
  call ESCRIBIR_NUM

  mov ah, 02h
  mov dl, "="
  int 21h

  mov ax, num_entrada
  mul cx
  call ESCRIBIR_NUM

  call SALTO_LINEA

  cmp cx, 10
  je fin_programa

  inc cx
  jmp multiplicacion

fin_programa:
  mov ah, 4ch
  int 21h

SALTO_LINEA PROC
  push ax
  push dx
  mov ah, 02h
  mov dl, 13
  int 21h
  mov dl, 10
  int 21h
  pop dx
  pop ax
  ret
SALTO_LINEA ENDP

LEER_NUM PROC
  ; Esta rutina guarda un número en CX.

  ; Guardamos estos registros para que la rutina no los destruya.
  push ax
  push bx
  push dx

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

    pop dx
    pop bx
    pop ax

    ret
LEER_NUM ENDP

ESCRIBIR_NUM PROC
  ; Antes de llamar a esta rutina, tenés que tener el dividendo en AX.

  ; Guardamos estos registros para que la rutina no los destruya.
  push ax
  push bx
  push cx 
  push dx

  mov cx, 0 ; Contador de dígitos.
  mov bx, 10 ; Divisor.

  extraer_digitos:
    mov dx, 0 ; Esto es una regla de la división de 16 bits.
    div bx ; AX / DX = cociente en AX y resto en DX

    push dx ; Guardamos el primer dígito en la pila.
    inc cx ; Contamos la cantidad de dígitos que mandamos a la pila.

    cmp ax, 0 ; Si AX es igual a cero, se terminó la división
    jne extraer_digitos

  escribir_pantalla:
    pop dx
    add dl, 30h

    mov ah, 02h
    int 21h

    loop escribir_pantalla

  pop dx
  pop cx
  pop bx
  pop ax

  ret
ESCRIBIR_NUM ENDP

msj_1 db "Ingrese un valor del 1 al 10: $"

num_entrada dw ?

END
 
