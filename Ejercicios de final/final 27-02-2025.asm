
; Realice un programa en assembler para 8086 que permite analizar una cadena de longitud n almacenada en un 
; vector y finalizada con $ y escriba el reverso en otro vector. Para finalizar, imprima por pantalla la cadena resultante.

name "final 27-02-2025"

org 100h

mov si, offset vector_entrada
xor bx, bx

recorrer_entrada:
  cmp [si], "$"
  je fin_recorrido

  inc bx
  inc si
  jmp recorrer_entrada

cmp bx, 0
je fin_programa

fin_recorrido:

mov di, offset vector_salida
mov cx, bx

copia:
  mov ax, [si-1]   
  mov [di], ax
  dec si
  inc di
  loop copia

mov si, offset vector_salida
mov cx, bx

al_reves:
  mov ah, 02h
  mov dl, [si]
  int 21h
  inc si
  loop al_reves

fin_programa:
  mov ah, 4ch
  int 21h

vector_entrada db "River Plate$"
vector_salida db 100 dup(?)
msj1 db "Vector al revés: $"

END

