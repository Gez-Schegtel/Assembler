
; Ingresar una cadena en minúscula por pantalla e ir conviritnedo sus vocales en mayúscula. La carga e impresión del resultado se realizará al presionar ENTER.

name "vocales_mayusculas"
org 100h
include "emu8086.inc"

start:
    PRINTN "Ingrese un texto (presione Enter al final):"

    ; --- 1. INGRESAR TEXTO ---
    mov di, offset texto
    mov dx, 100
    call GET_STRING
    
    putc 10
    putc 13

    ; --- 2. RECORRER Y CONVERTIR ---
    mov si, offset texto

recorrer:
    mov al, [si]

    cmp al, 0       ; Verificamos fin de cadena (GET_STRING usa 0)
    je fin_vector

    ; Chequeo de vocales (Comparamos AL, que es 8 bits)
    cmp al, 'a'
    je mayus
    cmp al, 'e'
    je mayus
    cmp al, 'i'
    je mayus
    cmp al, 'o'
    je mayus
    cmp al, 'u'
    je mayus

    inc si
    jmp recorrer    ; Si no es vocal, seguimos a la próxima

mayus:
    sub al, 20h     ; CORRECCIÓN: Restamos 20h para pasar a Mayúscula.
                    ; (97 - 32 = 65) 'a' -> 'A'

    mov [si], al  ; CORRECCIÓN: Escribimos en [si]
                    ; Porque LODSB ya había avanzado el puntero SI al siguiente.

    inc si
    jmp recorrer

fin_vector:
    ; --- 3. IMPRIMIR RESULTADO ---
    PRINTN "Texto convertido:"
    
    mov si, offset texto  ; Reiniciamos SI al principio para imprimir
    call PRINT_STRING

    ; Fin
    mov ah, 0
    int 16h
    mov ah, 4ch
    int 21h

; --- DATOS ---
texto db 100 dup(?) ; CORRECCIÓN: DB (8 bits) para caracteres.

DEFINE_GET_STRING
DEFINE_PRINT_STRING

END
