
name "mis_propias_rutinas"
org 100h

start:
  ; ==========================================================
  ; PROGRAMA DE PRUEBA (Para demostrar que funcionan)
  ; ==========================================================

  ; 1. Usamos nuestra rutina para LEER
  mov ah, 09h
  mov dx, offset msg1
  int 21h

  call LEER_NUMERO    ; ¡Llamada! El usuario escribe. El resultado queda en CX.

  mov bx, cx          ; Guardamos el número en BX para no perderlo

  call SALTO_DE_LINEA

  ; 2. Usamos nuestra rutina para IMPRIMIR
  mov ah, 09h
  mov dx, offset msg2
  int 21h

  mov ax, bx          ; Pasamos el número a AX (nuestra rutina exige AX)
  call IMPRIMIR_NUMERO ; ¡Llamada! Imprime lo que hay en AX.

  ; Fin del programa
  mov ah, 4ch
  int 21h

; ==========================================================
; ZONA DE DATOS
; ==========================================================
msg1 db "Ingrese un numero grande: $"
msg2 db "El numero que ingreso fue: $"


; ==========================================================
; 🛠️ RUTINA: LEER_NUMERO
; Función: Lee un número ingresado por teclado hasta pulsar Enter.
; Salida:  El número convertido queda en el registro CX.
; Seguridad: No destruye AX, BX ni DX.
; ==========================================================
LEER_NUMERO PROC
  ; 1. GUARDAR REGISTROS (Protección)
  push ax
  push bx
  push dx

  ; 2. INICIALIZAR
  mov cx, 0       ; CX será el acumulador final

leer_tecla:
  mov ah, 01h     ; Leer teclado
  int 21h

  cmp al, 13      ; ¿Es Enter?
  je fin_leer_num

  sub al, 30h     ; Convertir ASCII a decimal
  mov ah, 0
  mov bx, ax      ; Guardar el dígito temporalmente en BX

  mov ax, cx      ; Traer el acumulador a AX para multiplicar
  mov dx, 10      ; Multiplicador
  mul dx          ; AX = AX * 10 (DX se destruye, pero no importa porque lo guardamos al principio)

  add ax, bx      ; Sumar el dígito nuevo
  mov cx, ax      ; Guardar el nuevo total en CX

  jmp leer_tecla

fin_leer_num:
  ; 3. RESTAURAR REGISTROS (En orden inverso)
  pop dx
  pop bx
  pop ax
  ret             ; Volver al programa principal
LEER_NUMERO ENDP


; ==========================================================
; 🛠️ RUTINA: IMPRIMIR_NUMERO
; Función: Imprime en pantalla un número de hasta 5 dígitos (16 bits).
; Entrada: El número a imprimir DEBE estar en el registro AX.
; Seguridad: No destruye NINGÚN registro (incluso AX queda igual).
; ==========================================================
IMPRIMIR_NUMERO PROC
  ; 1. GUARDAR REGISTROS (Protección total)
  push ax
  push bx
  push cx
  push dx

  ; 2. INICIALIZAR
  mov cx, 0       ; Contador de dígitos apilados
  mov bx, 10      ; Divisor fijo

  dividir_numero:
  mov dx, 0       ; ¡Obligatorio! Limpiar parte alta antes de DIV de 16 bits
  div bx          ; AX / 10 -> Cociente en AX, Resto en DX

  push dx         ; Guardar el dígito (resto) en la Pila
  inc cx          ; Contar un dígito más

  cmp ax, 0       ; ¿Ya no queda nada por dividir?
  jne dividir_numero

  mostrar_digitos:
  pop dx          ; Recuperar dígito de la Pila (sale del último al primero)
  add dl, 30h     ; Convertir número a ASCII

  mov ah, 02h     ; Función DOS: Imprimir caracter
  int 21h

  loop mostrar_digitos ; Repetir según la cantidad de dígitos contados (CX)

  ; 3. RESTAURAR REGISTROS (En orden inverso)
  pop dx
  pop cx
  pop bx
  pop ax
  ret
IMPRIMIR_NUMERO ENDP

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

END
