
; Realice un programa que anide 3 bucles. Se deberá poder definir la cantidad de
; iteraciones de cada bucle, e imprimir en pantalla un indicador numérico de cada
; iteración.

name "comp2.2"
org 100h
include "emu8086.inc"

start:
  ; =================================================
  ; 1. CONFIGURACIÓN (INPUTS)
  ; =================================================
  PRINT "Iteraciones Bucle 1 (Externo): "
  call SCAN_NUM
  mov max_1, cx
  PRINTN ""

  PRINT "Iteraciones Bucle 2 (Medio):   "
  call SCAN_NUM
  mov max_2, cx
  PRINTN ""

  PRINT "Iteraciones Bucle 3 (Interno): "
  call SCAN_NUM
  mov max_3, cx
  PRINTN ""
  PRINTN "--- INICIO ---"

  ; =================================================
  ; 2. LÓGICA DE BUCLES ANIDADOS (STACK)
  ; =================================================

  ; Inicializamos el contador visual del 1 (Solo una vez al principio)
  mov visual_1, 1

  ; [SETUP BUCLE 1]
  mov cx, max_1       ; Cargamos CX con el total de vueltas del 1

  ; --- INICIO BUCLE 1 ---
  loop_1:
    push cx         ; <--- [GUARDAR] Salvamos el contador del 1 en la Pila

    ; Reiniciamos el contador visual del 2 para la nueva tanda
    mov visual_2, 1

    ; [SETUP BUCLE 2]
    mov cx, max_2   ; Cargamos CX para el bucle 2 (Pisa el valor anterior, pero ya lo guardamos)

    ; --- INICIO BUCLE 2 ---
    loop_2:
      push cx     ; <--- [GUARDAR] Salvamos el contador del 2 en la Pila

      ; Reiniciamos el contador visual del 3
      mov visual_3, 1

      ; [SETUP BUCLE 3]
      mov cx, max_3 ; Cargamos CX para el bucle 3

      ; --- INICIO BUCLE 3 ---
      loop_3:
        ; Acción: Imprimir "1 - 1 - 1"
        mov ax, visual_1
        call PRINT_NUM

        PRINT " - "

        mov ax, visual_2
        call PRINT_NUM

        PRINT " - "

        mov ax, visual_3
        call PRINT_NUM

        PRINTN "" ; Enter

        inc visual_3    ; Aumentamos contador visual

        loop loop_3     ; [MOTOR 3] DEC CX. Si CX!=0, salta a loop_3

      ; --- FIN BUCLE 3 ---

      pop cx      ; <--- [RECUPERAR] Rescatamos el CX del Bucle 2 de la Pila

      inc visual_2 ; Aumentamos contador visual del medio

      loop loop_2 ; [MOTOR 2] Usa el CX recuperado. Si no es 0, repite.

    ; --- FIN BUCLE 2 ---

    pop cx          ; <--- [RECUPERAR] Rescatamos el CX del Bucle 1

    inc visual_1    ; Aumentamos contador visual externo

    loop loop_1     ; [MOTOR 1] Usa el CX recuperado.

  ; --- FIN BUCLE 1 ---

  ; =================================================
  ; FIN
  ; =================================================
  PRINTN "--- FIN ---"
  mov ah, 4ch
  int 21h

; --- DATOS ---
; Límites (Topes ingresados por usuario)
max_1 dw ?
max_2 dw ?
max_3 dw ?

; Contadores Visuales (Para imprimir 1, 2, 3...)
; Usamos variables porque los registros están ocupados o cambiando.
visual_1 dw ?
visual_2 dw ?
visual_3 dw ?

DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
