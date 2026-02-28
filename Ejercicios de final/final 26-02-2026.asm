
; Realice un programa en assembler para 8086 utilizando únicamente interrupciones 
; (NO la librería emu8086) que funcione como un pequeño sistema de registro 
; académico para un grupo de 8 alumnos.

; El programa debe solicitar el ingreso de 8 calificaciones (números del 0 al 9). 
; Luego mostrar en pantalla los resultados con el siguiente formato:

;   * "Promedio del curso: [X]"
;   * "Total de alumnos aprobados: [X]" (nota mayor o igual que 6)
;   * "La calificación más baja fue: [X]".

name "final 26-02-2026"
org 100h

mov ah, 09h
mov dx, offset msj1
int 21h

mov cx, 8
ingresar_notas:
  cmp cx, 0
  je fin_ingreso

  mov ah, 01h
  int 21h

  sub al, 30h

  add promedio_curso, al

  cmp al, 6
  jb no_cuento_aprobados

  inc total_aprobados

no_cuento_aprobados:
  cmp al, calif_mas_baja
  jae no_actualizo_calif_mas_baja

  mov calif_mas_baja, al

no_actualizo_calif_mas_baja:
  loop ingresar_notas

fin_ingreso:

call SALTO_LINEA
call SALTO_LINEA

mostrar_resultados:
mov ah, 09h
mov dx, offset msj2
int 21h

xor ax, ax
mov al, promedio_curso
mov bl, 8
div bl
add al, 30h
mov promedio_curso, al

mov ah, 02h
mov dl, promedio_curso
int 21h

call SALTO_LINEA

mov ah, 09h
mov dx, offset msj3
int 21h

add total_aprobados, 30h
mov ah, 02h
mov dl, total_aprobados
int 21h

call SALTO_LINEA

mov ah, 09h
mov dx, offset msj4
int 21h

add calif_mas_baja, 30h
mov ah, 02h
mov dl, calif_mas_baja
int 21h

mov ah, 4ch
int 21h

msj1 db "Ingrese 8 notas del 0 al 9 (sin espacios): $"
msj2 db "Promedio del curso: $"
msj3 db "Total de alumnos aprobados: $"
msj4 db "La calificación más baja fue: $"

promedio_curso db 0
total_aprobados db 0
calif_mas_baja db 9

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

