
; Imagina que quieres escribir el número 152.
; Arrancas con un Total de 0.
;
; Escribes '1':
;
;  Multiplicas el total por 10: 0 * 10 = 0
;
;  Le sumas el 1: 0 + 1 = 1. (Total = 1)
;
; Escribes '5':
;
;  Multiplicas el total por 10: 1 * 10 = 10
;
;  Le sumas el 5: 10 + 5 = 15. (Total = 15)
;
; Escribes '2':
;
;  Multiplicas el total por 10: 15 * 10 = 150
;
;  Le sumas el 2: 150 + 2 = 152. (Total = 152)
;
; Presionas ENTER: ¡Terminaste! Tienes tu 152 real.


name "ingreso_numeros"
org 100h

; 1. Preparamos nuestra "Caja Fuerte" (El total arranca en 0)
mov cx, 0

leer_tecla:
  ; 2. Leer UNA tecla
  mov ah, 01h
  int 21h

  ; 3. ¿El usuario presionó ENTER? (ASCII 13)
  cmp al, 13
  je fin_ingreso

  ; 4. Convertir la letra (ej: '5') a número matemático (5)
  sub al, 30h

  ; 5. Limpiamos AH para que no haya basura, y guardamos el numerito en BX
  mov ah, 0
  mov bx, ax      ; BX ahora tiene el numero nuevo (ej: 5)

  ; 6. Multiplicar el Total (CX) por 10
  mov ax, cx      ; Pasamos el total a AX (porque MUL obliga a usar AX)
  mov dx, 10      ; Nuestro multiplicador es 10
  mul dx          ; Multiplicamos: AX = AX * 10

  ; 7. Sumarle el número nuevo que teníamos en BX
  add ax, bx

  ; 8. Guardar el nuevo total en nuestra "Caja Fuerte" (CX)
  mov cx, ax

  ; 9. Volver arriba a pedir otra tecla
  jmp leer_tecla

fin_ingreso:
  ; ¡LISTO!
  ; En este punto, si el usuario tipeó 1, luego 0 y luego Enter...
  ; ¡El registro CX tiene guardado el número 10 real (A en Hexadecimal)!

  ; --- Fin del programa ---
  mov ah, 4ch
  int 21h

end
