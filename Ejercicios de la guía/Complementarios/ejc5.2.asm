
; Separar en dos arreglos los números pares e impares leídos de un arreglo
; previamente definido en memoria.
;
; Separar pares e impares (Lógica Inteligente)
; Si todos son de un tipo, no repite la lista.

name "comp5"
org 100h
include "emu8086.inc"

; --- 1. MOSTRAR ORIGINAL ---
PRINT "Vector original: "
mov si, offset vector_original
mov cx, 10
call RUTINA_IMPRIMIR

; --- 2. SINGLE PASS (Clasificación) ---
mov si, offset vector_original
mov di, offset vector_pares
mov bx, offset vector_impares
mov cx, 10

bucle_clasificacion:
  lodsw             ; Carga AX

  test ax, 1
  jnz es_impar

es_par:
  stosw             ; Guarda en pares [DI]
  inc cont_pares
  jmp siguiente

es_impar:
  mov [bx], ax      ; Guarda en impares [BX]
  add bx, 2
  inc cont_impares

siguiente:
  loop bucle_clasificacion

; --- 3. LÓGICA DE DECISIÓN (EL ARREGLO) ---

; CASO A: ¿Son todos IMPARES? (Pares == 0)
cmp cont_pares, 0
je todos_impares

; CASO B: ¿Son todos PARES? (Impares == 0)
cmp cont_impares, 0
je todos_pares

; CASO C: MIXTO (Si llega acá, hay de los dos)
jmp mostrar_listas_separadas

; --- BLOQUES DE MENSAJES ---

todos_impares:
  PRINTN " "
  PRINTN "Resultado: Todos los numeros del vector son IMPARES."
  jmp fin_programa

todos_pares:
  PRINTN " "
  PRINTN "Resultado: Todos los numeros del vector son PARES."
  jmp fin_programa

; --- BLOQUE DE IMPRESIÓN (Solo si es mixto) ---
mostrar_listas_separadas:
  PRINTN " "
  PRINTN "Resultado mixto:"
  
  ; Mostrar Pares
  PRINT "  -> Pares encontrados: "
  mov si, offset vector_pares
  mov cx, cont_pares
  call RUTINA_IMPRIMIR
  
  ; Mostrar Impares
  PRINT "  -> Impares encontrados: "
  mov si, offset vector_impares
  mov cx, cont_impares
  call RUTINA_IMPRIMIR

fin_programa:
  mov ah, 4ch
  int 21h

; --- DATOS ---
; Prueba cambiando estos números para ver los distintos mensajes:
vector_original dw 1, 3, 5, 7, 9, 11, 13, 15, 17, 19 ; Caso todos impares
; vector_original dw 2, 4, 6, 8, 10, 12, 14, 16, 18, 20 ; Caso todos pares
; vector_original dw 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ; Caso mixto

vector_pares    dw 10 dup(?)
vector_impares  dw 10 dup(?)
cont_pares      dw 0
cont_impares    dw 0

; --- RUTINA ---
RUTINA_IMPRIMIR PROC
  imprimir:
    lodsw
    call PRINT_NUM
    PRINT " "
    loop imprimir
    PRINTN " "
  ret
RUTINA_IMPRIMIR ENDP

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

END
