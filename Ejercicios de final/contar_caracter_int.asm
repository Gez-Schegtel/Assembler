
; Realizar programa Assembler 8086 que permita el ingreso de un carácter y una cadena de caracteres tipeadas 
; por pantalla. Al presionar ENTER deberá indicar la cantidad de coincidencias de dicho carácter en la misma. 

name "contar caracteres con interrupciones"
org 100h

mov ah, 09h
mov dx, offset msj_ingreso_cadena
int 21h

call SALTO_LINEA
call SALTO_LINEA

mov di, offset cadena
mov cx, 255

ingresar_cadena:
  mov ah, 01h
  int 21h

  cmp al, 13
  je fin_carga

  mov [di], al
  inc di

  loop ingresar_cadena

fin_carga:
  mov [di], "$"

mov si, offset cadena
cmp [si], "$"
je no_cargo_nada

call SALTO_LINEA
call SALTO_LINEA

mov ah, 09h
mov dx, offset msj_ingreso_caracter
int 21h

mov ah, 01h
int 21h

call SALTO_LINEA

xor bx, bx

coincidencias:
  cmp [si], "$"
  je fin_coincidencias

  cmp al, [si]
  jne no_cuento_coincidencia

  inc bx

no_cuento_coincidencia:
  inc si
  jmp coincidencias

fin_coincidencias:

mov ah, 09h
mov dx, offset msj_coincidencias
int 21h

mov ax, bx
call ESCRIBIR_NUM

jmp fin_programa

no_cargo_nada:
  mov ah, 09h
  mov dx, offset msj_error
  int 21h

fin_programa:
mov ah, 4ch
int 21h

msj_ingreso_cadena db "Ingrese una cadena de alfanumérica de hasta 255 caracteres... $"
msj_ingreso_caracter db "Ingrese un caracter del que desee buscar el número de coincidencias: $"
msj_coincidencias db "Número de coincidencias del caracter en la cadena: $"
msj_error db "No cargaste nada >:-($"

cadena db 256 dup(?) ; 255 caracteres de entrada + el centinela $.

ESCRIBIR_NUM PROC
  ; Para que esta rutina funcione, antes de llamarla hay que tener el número que se quiere mostrar por pantalla cargado en el registro AX.

  push ax
  push bx
  push cx
  push dx

  xor cx, cx
  mov bx, 10

  descomponer_numero:
    xor dx, dx
    div bx

    push dx

    inc cx

    cmp ax, 0
    jne descomponer_numero

  mostrar_numero:
    pop dx
    add dx, 30h

    mov ah, 02h
    int 21h

    loop mostrar_numero

  pop dx
  pop cx
  pop bx
  pop ax

  ret
ESCRIBIR_NUM ENDP

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

end
