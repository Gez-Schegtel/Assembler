
; Realizar un programa Assembler 8086 que permita ingresar por teclado 10 caracteres y 
; separe en dos vectores. Colocar en un vector los dígitos y en otro vector, el resto de los caracteres. 
; Al finalizar deberá imprimir el vector de números.
; Se solicita: codificar el programa en lenguaje Assembler para el 8086.

name "separar números"
org 100h

mov ah, 09h
mov dx, offset msg1
int 21h

mov di, offset letras
mov si, offset numeros
xor cx, cx ; Contador total de ingresos.
xor bx, bx ; Contador de números.
ingresar_vector:
  cmp cx, 10
  je fin_ingreso

  mov ah, 01h
  int 21h

  cmp al, 13
  je fin_ingreso

  cmp al, "0"
  jb no_es_numero

  cmp al, "9"
  ja no_es_numero

  mov [si], al
  inc si
  inc cx
  inc bx
  jmp ingresar_vector

no_es_numero:
  mov [di], al
  inc di
  inc cx
  jmp ingresar_vector

fin_ingreso:
  call SALTO_DE_LINEA

  cmp bx, 0
  je no_hay_numeros

  mov ah, 09h
  mov dx, offset msg2
  int 21h

mov si, offset numeros
mostrar_numeros:
  xor bx, bx

  mov bx, [si]
  inc si

  mov ah, 02h
  mov dl, bl
  int 21h
  mov dl, " "
  int 21h

  loop mostrar_numeros

jmp fin_programa

no_hay_numeros:
  mov ah, 09h
  mov dx, offset msg3
  int 21h

fin_programa:
  mov ah, 4ch
  int 21h

msg1 db "Ingrese 10 caracteres: $"
msg2 db "El vector de números es: $"
msg3 db "No hay números en la cadena ingresada.$"

letras db 10 dup(?)
numeros db 10 dup(?)

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

end
