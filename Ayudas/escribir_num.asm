
; Imagina que el procesador tiene el número 152 guardado.
; ¿Cómo le arrancamos los números de a uno para imprimirlos? Dividiendo por 10:
;
;     152 / 10 = Da 15, y sobra 2. ¡Conseguimos el 2!
;
;     15 / 10 = Da 1, y sobra 5. ¡Conseguimos el 5!
;
;     1 / 10 = Da 0, y sobra 1. ¡Conseguimos el 1!
;
; El problema: Los sacamos al revés (primero el 2, luego el 5, luego el 1). Si los imprimimos así nomás, en la pantalla saldría "251".
; La solución: Usar la Pila (Stack). Guardamos los números en la pila a medida que salen (2, luego 5, luego 1).
; Al sacarlos de la pila (POP), salen en el orden correcto (1, luego 5, luego 2).

name "imprimir_numeros"
org 100h

; 1. Ponemos un número de prueba en AX (Por ejemplo, 152)
mov ax, 152

; 2. Preparamos nuestras herramientas
mov cx, 0       ; CX va a contar cuántos dígitos guardamos en la pila
mov bx, 10      ; Nuestro divisor siempre será 10

sacar_digitos:
  ; 3. Limpiamos DX obligatoriamente (regla de la división de 16 bits)
  mov dx, 0

  ; 4. Dividimos AX por 10
  div bx ; El cociente (lo que queda) va a AX. El resto (el dígito) va a DX.

  ; 5. Guardamos el dígito (resto) en la Pila
  push dx

  ; 6. Sumamos 1 a nuestro contador de dígitos
  inc cx

  ; 7. ¿Ya terminamos de dividir? (¿AX llegó a 0?)
  cmp ax, 0
  jne sacar_digitos  ; Si AX no es 0, volvemos a dividir

  ; =======================================================
  ; ¡AQUÍ YA TENEMOS TODOS LOS DÍGITOS GUARDADOS EN LA PILA!
  ; Ahora solo queda sacarlos e imprimirlos.
  ; =======================================================

imprimir_digitos:
  ; 9. Sacamos el último dígito que guardamos (Sale en orden correcto)
  pop dx

  ; 9. Lo convertimos de número matemático a letra (ASCII)
  add dl, 30h     ; Sumamos 48 (ej: 1 se convierte en '1')

  ; 10. Imprimimos el carácter en la pantalla
  mov ah, 02h
  int 21h

  ; 11. Repetimos hasta que se acaben los dígitos
  loop imprimir_digitos ; LOOP resta 1 a CX. Si no es 0, repite.

fin_programa:
  ; --- Fin del programa ---
  mov ah, 4ch
  int 21h

end
