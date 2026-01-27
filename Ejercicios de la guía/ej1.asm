
; 1.Realice un programa Assembler que permita sumar el contenido de las siguientes
; direcciones 2Ah, 2Bh, 2Ch y 2Dh guardando el resultado en 2Eh. Cargar dichas direcciones
; previamente con los valores de operandos.

name "ejercicio_1"
org 100h

include 'emu8086.inc' ; Librería para que mostrar por pantalla el resultado sea más fácil.

start:
    ; Mensaje de bienvenida
    PRINTN "Este programa suma diversos números que residen en la memoria RAM."
    PRINT "" ; Salto de línea estético.

    ; 1. CARGAR DATOS (Especificando tamaño Byte)
    mov byte ptr [2Ah], 10
    mov byte ptr [2Bh], 8
    mov byte ptr [2Ch], 2
    mov byte ptr [2Dh], 12

    ; 2. SUMAR (Usando registro de 8 bits para no comerse al vecino)
    mov ax, 0       ; Limpiamos AX completo

    mov al, [2Ah]   ; AL = 10
    add al, [2Bh]   ; AL = 18
    add al, [2Ch]   ; AL = 20
    add al, [2Dh]   ; AL = 32

    ; 3. GUARDAR
    mov [2Eh], al   ; Guardamos el 32 en memoria

    ; 4. VERIFICACIÓN VISUAL
    ; Usaremos la librería para ver el "32" real.
    
    PRINT "Resultado: "
    mov ah, 0       ; Aseguramos que AH sea 0, porque lo que nos interesa imprimir es «al». La función PRINT_NUM imprime todo el contenido de AX.
    call PRINT_NUM  ; Imprime lo que hay en AX (32)

    ; Salida
    mov ah, 4ch
    int 21h

    DEFINE_PRINT_NUM
    DEFINE_PRINT_NUM_UNS
                  
end
