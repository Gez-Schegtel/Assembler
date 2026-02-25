; Realizar Programa assembler que permita ingresar una cadena alfanumérica por pantalla. 
; Al presionar Enter deberá generar un nuevo vector que contenga los valores ASCII de cada carácter ingresado e imprimirlo por pantalla.

name "final 18-12-25"
org 100h

mov ah, 09h
mov dx, offset msj1
int 21h

mov di, offset vector_entrada
xor cx, cx
cargar_vector_entrada:
  cmp cx, 200
  je fin_carga

  mov ah, 01h
  int 21h

  cmp al, 13
  je fin_carga

  mov [di], al
  inc di
  inc cx
  jmp cargar_vector_entrada

fin_carga:
cmp cx, 0
je fin_programa

mov dx, cx
cargar_vector_salida:
  ; A esta parte la agrego porque el enunciado la pide...
  mov si, offset vector_entrada
  mov di, offset vector_salida
  bucle_carga:
    xor bx, bx
    mov bl, [si]
    mov [di], bl
    inc di
    inc si
    loop bucle_carga

mov cx, dx

call SALTO_DE_LINEA
mov ah, 09h
mov dx, offset msj2
int 21h

mov si, offset vector_salida
escribir_por_pantalla:
  xor ax, ax
  mov al, [si] ; Acordate que el vector está definido con elementos de 8 bits. Tenés que limpiar la parte alta.
  call IMPRIMIR_NUMERO
  mov ah, 02h
  mov dl, " "
  int 21h
  inc si
  loop escribir_por_pantalla

fin_programa:
  mov ah, 4ch
  int 21h

msj1 db "Ingrese una cadena alfanumérica: $"
msj2 db "La cadena con sus valores en ASCII es: $"

vector_entrada db 200 dup(?)
vector_salida db 200 dup(?)

SALTO_DE_LINEA PROC
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
SALTO_DE_LINEA ENDP

IMPRIMIR_NUMERO PROC
  ; Esta rutina necesita que el número a imprimir esté en el registro AX.
  ; Guardo el contenido de los registros que utiliza la rutina para no alterar la ejecución principal.
  push ax
  push bx
  push cx
  push dx

  mov bx, 10 ; Divisor.
  xor cx, cx ; Contador de dígitos almacenados.

  guardar_digitos:
    xor dx, dx ; Esto es una regla de la división de 16 bits.
    div bx ; División de 16 bits ==> AX / BX = DX = Resto y AX = Cociente

    push dx ; Guardamos el primer dígito que obtenemos.
    inc cx ; Contamos el número de dígitos que guardamos.

    cmp ax, 0 ; Si el cociente es cero, quiere decir que ya dividimos el número hasta el último dígito.
    jne guardar_digitos

  mostrar_digitos:
    pop dx
    add dx, 30h
    mov ah, 02h
    int 21h
    loop mostrar_digitos

  pop dx
  pop cx
  pop bx
  pop ax

  ret
IMPRIMIR_NUMERO ENDP

END
