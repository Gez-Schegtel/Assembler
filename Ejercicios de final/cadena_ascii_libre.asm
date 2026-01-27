name "cadena_en_ascii"

include "emu8086.inc"
org 100h

start:
    ; 1. INGRESAR CADENA
    printn "Ingrese una cadena: "

    MOV DI, offset buffer
    MOV DX, 20          ; Le damos un poco más de espacio (20)
    CALL GET_STRING

    printn ""           ; Salto de línea estético

    ; 2. GENERAR NUEVO VECTOR (COPIAR)
    ; El ejercicio pide crear un vector nuevo con los datos.
    ; Vamos a copiar del 'buffer' al 'vector_ascii'.

    MOV SI, offset buffer       ; Origen (Lo que escribió el usuario)
    MOV DI, offset vector_ascii ; Destino (El nuevo vector)

copiar:
    MOV AL, [SI]        ; Leemos letra del buffer
    CMP AL, 0           ; ¿Terminó la cadena? (La librería usa 0)
    JE fin_copia        ; Si es 0, terminamos de copiar

    MOV [DI], AL        ; Guardamos en el nuevo vector
    
    INC SI              ; Avanzamos los dos punteros
    INC DI
    JMP copiar

fin_copia:
    MOV [DI], 0         ; Cerramos el nuevo vector con 0 también.


    ; 3. IMPRIMIR VALORES ASCII
    ; El ejercicio pide imprimir los VALORES (números), no el texto.
    ; Usaremos PRINT_NUM para mostrar "65" en vez de "A".

    printn "Valores ASCII del nuevo vector:"
    
    MOV SI, offset vector_ascii ; Apuntamos al vector NUEVO

imprimir_numeros:
    MOV AL, [SI]        ; Traemos el dato
    CMP AL, 0           ; ¿Es el fin?
    JE salir            ; Si es 0, terminamos

    ; Preparar para imprimir número
    MOV AH, 0           ; Limpiamos AH para que AX tenga solo el número (00 + AL)
    CALL PRINT_NUM      ; Imprime el valor decimal (ej: 65)
    
    PRINT " "           ; Un espacio para separar
    
    INC SI              ; Siguiente
    JMP imprimir_numeros

salir:
    printn ""
    printn "Fin del programa."
    
    ; Pausa para ver resultado
    MOV AH, 0
    INT 16h

    MOV AH, 4ch
    INT 21h

; --- VARIABLES ---
buffer       db 20 dup(0)
vector_ascii db 20 dup(0)  ; Aquí guardaremos la copia

; --- FUNCIONES DE LIBRERÍA ---
DEFINE_GET_STRING
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM        ; Necesaria para imprimir los números ASCII
DEFINE_PRINT_NUM_UNS    ; Requisito de PRINT_NUM
   
end
