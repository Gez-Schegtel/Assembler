
name "rutina_string_0Ah"
org 100h

start:
  ; ==========================================================
  ; PROGRAMA DE PRUEBA
  ; ==========================================================

  ; 1. Pedir el texto
  mov ah, 09h
  mov dx, offset msg1
  int 21h

  ; --- PREPARAR Y LLAMAR A LA RUTINA ---
  mov di, offset mi_texto   ; Le decimos a la rutina DÓNDE guardar el texto
  call LEER_CADENA          ; ¡Llamada! El usuario escribe hasta dar Enter.

  call SALTO_DE_LINEA

  ; 2. Mostrar el texto ingresado
  mov ah, 09h
  mov dx, offset msg2
  int 21h

  ; Imprimimos la variable (Nuestra rutina le puso el '$' al final automáticamente)
  mov ah, 09h
  mov dx, offset mi_texto
  int 21h

  ; Fin del programa
  mov ah, 4ch
  int 21h

; ==========================================================
; ZONA DE DATOS
; ==========================================================
msg1 db "Ingrese su nombre o un texto: $"
msg2 db "El texto que ingreso fue: $"

mi_texto db 100 dup(?)  ; Reservamos 100 bytes vacíos para el texto


; ==========================================================
; 🛠️ RUTINA: LEER_CADENA
; Función: Lee texto carácter por carácter hasta pulsar Enter.
; Entrada: DI debe apuntar al inicio del buffer (la variable vacía).
; Salida:  La variable se llena con el texto y se le agrega un '$' al final.
; Seguridad: Protege los registros que utiliza.
; ==========================================================
LEER_CADENA PROC
  ; 1. GUARDAR REGISTROS
  push ax
  push di     ; Guardamos DI por si el programa principal lo necesita intacto

leer_caracter:
  mov ah, 01h     ; Función DOS: Leer tecla con eco
  int 21h

  cmp al, 13      ; ¿Presionó ENTER (código ASCII 13)?
  je fin_leer_cadena

  mov [di], al    ; Guardamos la letra ingresada en la memoria
  inc di          ; Avanzamos el puntero al siguiente casillero vacío

  jmp leer_caracter

fin_leer_cadena:
  ; ¡MUY IMPORTANTE! 
  ; DOS necesita un '$' para saber dónde termina el texto al imprimir.
  mov byte ptr [di], '$' 

  ; 3. RESTAURAR REGISTROS (Orden inverso)
  pop di
  pop ax
  ret
LEER_CADENA ENDP


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

END
