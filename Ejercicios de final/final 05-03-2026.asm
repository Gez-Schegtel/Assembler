
; Alumno: Velazco Gez Schegtel, Juan Ignacio.
; DNI: 41974930
; Legajo: 24867

name "final 05-03-2026"
org 100h

mov ah, 09h
mov dx, offset mensaje1
int 21h

call SALTO_LINEA

mov cx, 6
mov di, offset vector
cargar_vector:
  push cx
  call LEER_NUMERO
  mov [di], cl
  inc di

  call SALTO_LINEA

  pop cx
  loop cargar_vector

mov al, vector[5]
mov numero_objetivo, al

call SALTO_LINEA

mov ah, 09h
mov dx, offset mensaje2
int 21h

mov cx, 6
mov si, offset vector
mostrar_vector:
  xor ax, ax
  mov al, [si]
  call IMPRIMIR_NUMERO

  mov ah, 02h
  mov dl, " "
  int 21h

  inc si
  loop mostrar_vector

mov cx, 6
mov si, offset vector
sumar_numeros:
  xor bx, bx
  mov bl, [si]
  cmp bl, numero_objetivo
  je no_sumo

  add suma, bx

no_sumo:
  inc si
  loop sumar_numeros

call SALTO_LINEA

mostrar_suma:
  mov ah, 09h
  mov dx, offset mensaje3
  int 21h

  mov ax, suma
  call IMPRIMIR_NUMERO

mov ah, 4ch
int 21h

mensaje1 db "Ingrese 6 números de dos dígitos (por cada número, debe presionar ENTER): $"
mensaje2 db "El vector es: $"
mensaje3 db "La sumatoria de los números sin contar el número objetivo es: $"
vector db 6 dup(?)
numero_objetivo db ?
suma dw 0

LEER_NUMERO PROC
  push ax
  push bx
  push dx

  mov cx, 0

leer_tecla:
  mov ah, 01h
  int 21h

  cmp al, 13
  je fin_leer_num

  sub al, 30h
  mov ah, 0
  mov bx, ax

  mov ax, cx
  mov dx, 10
  mul dx

  add ax, bx
  mov cx, ax

  jmp leer_tecla

fin_leer_num:
  pop dx
  pop bx
  pop ax
  ret
LEER_NUMERO ENDP

IMPRIMIR_NUMERO PROC
  push ax
  push bx
  push cx
  push dx

  mov cx, 0
  mov bx, 10

  dividir_numero:
  mov dx, 0
  div bx

  push dx
  inc cx

  cmp ax, 0
  jne dividir_numero

  mostrar_digitos:
  pop dx
  add dl, 30h

  mov ah, 02h
  int 21h

  loop mostrar_digitos

  pop dx
  pop cx
  pop bx
  pop ax
  ret
IMPRIMIR_NUMERO ENDP

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

END
