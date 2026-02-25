
; Realizar Programa assembler que permita ingresar una cadena binaria y almacenarla en memoria. 
; Dicha cadena deberá ser barrida y generar un nuevo vector donde: Si el carácter es 0 guarde una F 
; y si es 1 guarde una V. Al final del proceso imprimir en pantalla el vector resultante.

name "final 22-02-2024"
org 100h

mov ah, 09h
mov dx, offset msj1
int 21h

mov di, offset vector ; Puntero que usaré para leer.
mov si, offset vector ; Puntero para escribir.
xor cx, cx

cargar_vector:
  cmp cx, 10
  je salida

  mov ah, 01h
  int 21h

  cmp al, "1"
  je cargar_vector_v

  cmp al, "0"
  je cargar_vector_f

  jmp cargar_vector

cargar_vector_v:
  mov [di], "V"
  jmp guardar

cargar_vector_f:
  mov [di], "F"

guardar:
  inc di
  inc cx
  jmp cargar_vector

salida:
  mov ah, 09h
  mov dx, offset msj2
  int 21h

mostrar_vector:
  mov ah, 02h
  mov dl, [si]
  int 21h

  inc si
  loop mostrar_vector

mov ah, 4ch
int 21h

vector db 10 dup(?)
msj1 db "Ingrese una cadena binaria con 10 elementos: $"
msj2 db 13, 10, "El vector resultante es: $"

END
