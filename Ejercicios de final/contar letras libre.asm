name "contador_libreria"

include 'emu8086.inc'
org 100h

start:
    ; --- 1. PEDIR CADENA ---
    PRINT "Ingrese una cadena: "
    
    ; Usamos DI (Destination Index) porque vamos a ESCRIBIR en memoria.
    MOV DI, offset buffer      
    MOV DX, 5          ; Tamaño máximo del buffer
    CALL GET_STRING     ; La librería lee y pone un 0 al final
    
    PRINTN ""           ; Salto de línea estético

    ; --- 2. PEDIR LETRA ---
    PRINT "Ingrese letra a buscar: "
    
    ; Leemos UN caracter con interrupción estándar (más rápido)
    MOV AH, 1
    INT 21h
    MOV BL, AL          ; Guardamos INMEDIATAMENTE la letra en BL.
                        ; AL es volátil. Si la macro PRINTN de abajo usara AL,
                        ; perderíamos el dato. BL es seguro.
    
    PRINTN ""           ; Ahora podemos hacer saltos de línea tranquilos.

    ; --- 3. CONTAR APARICIONES ---
    MOV CX, 0             ; CX será nuestro contador de coincidencias
    
    ; Usamos SI (Source Index) porque ahora vamos a LEER/ANALIZAR memoria.
    MOV SI, OFFSET buffer 

bucle:
    CMP [SI], 0         ; Buscamos el 0 (Terminador de la librería emu8086)
    JE mostrar_total    ; Si llegamos al final, salimos
    
    CMP [SI], BL        ; Comparamos memoria vs registro seguro (BL)
    JNE siguiente
    
    INC CX              ; Si coinciden, sumamos 1 al contador

siguiente:
    INC SI              ; Avanzamos a la siguiente letra (Siempre)
    JMP bucle

    ; --- 4. MOSTRAR RESULTADO ---
mostrar_total:
    PRINTN ""
    PRINT "Cantidad de veces: "
    
    MOV AX, CX          ; Requisito: PRINT_NUM imprime lo que hay en AX
    CALL PRINT_NUM      ; Imprime el número decimal (soporta más de 1 dígito)
    
    ; Salida segura al sistema operativo
    MOV AH, 4Ch
    INT 21h

; ZONA DE DATOS
; Llenamos con 0 para seguridad extra (funciona bien con la librería)
buffer DB 5 DUP(0)     

; DEFINICIONES DE LA LIBRERÍA
DEFINE_GET_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS    ; Requerido obligatoriamente por PRINT_NUM

end
