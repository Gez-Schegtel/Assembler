
name "rutina_string_0Ah"
org 100h

start:
  ; ==========================================================
  ; PROGRAMA PRINCIPAL
  ; ==========================================================

  ; 1. Mensaje pidiendo el texto
  mov ah, 09h
  mov dx, offset msg_pedir
  int 21h

  ; 2. LLAMADA A NUESTRA RUTINA
  mov di, offset buffer_texto  ; ¡Mucho más lógico! DI apunta al destino
  call LEER_CADENA_0AH         ; La rutina hace el trabajo sucio

  call SALTO_DE_LINEA

  ; 3. Mensaje de salida
  mov ah, 09h
  mov dx, offset msg_mostrar
  int 21h

  ; 4. IMPRIMIR EL TEXTO INGRESADO
  mov ah, 09h
  mov dx, offset buffer_texto + 2
  int 21h

  ; Fin del programa
  mov ah, 4ch
  int 21h

; ==========================================================
; 🛠️ RUTINA: LEER_CADENA_0AH
; Función: Lee texto usando Buffered Input.
; Entrada: DI debe apuntar a la estructura del buffer.
; Acción:  Lee el texto y cambia el CR (13) por un '$'.
; ==========================================================
LEER_CADENA_0AH PROC
  ; 1. Proteger registros que vamos a ensuciar internamente
  push ax
  push bx
  push dx             ; <--- ¡NUEVO! Protegemos DX porque lo usaremos como puente

  ; 2. El "Pase de Manos" (Adaptación a las reglas del DOS)
  mov dx, di          ; Pasamos la dirección de DI a DX para que el DOS no se queje

  ; 3. Llamar a la interrupción nativa del sistema
  mov ah, 0Ah
  int 21h             ; Lee el teclado

  ; 4. LA MAGIA: Limpiar el final (Sustituir el Enter por '$')
  mov bx, di          ; Usamos DI como base para calcular distancias

  xor ax, ax          ; Limpiamos AX por seguridad
  mov al, [bx+1]      ; Leemos el [Byte 1] (Cantidad de letras)

  add bx, 2           ; Saltamos los 2 bytes de cabecera
  add bx, ax          ; Avanzamos hasta justo después de la última letra

  mov byte ptr [bx], '$'  ; ¡PISOTEAMOS el Enter con un '$'!

  ; 5. Restaurar registros en orden inverso
  pop dx              ; <--- Recuperamos el valor original de DX
  pop bx
  pop ax
  ret
LEER_CADENA_0AH ENDP

; ==========================================================
; 🛠️ RUTINA: SALTO_DE_LINEA
; ==========================================================
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

; ==========================================================
; ZONA DE DATOS
; ==========================================================
msg_pedir   db "Escribe un texto (puedes usar borrar): $"
msg_mostrar db "El texto limpio es: $"

buffer_texto db 50        ; Byte 0: Límite
             db ?         ; Byte 1: Contador DOS
             db 50 dup(?) ; Byte 2...: Texto

END
