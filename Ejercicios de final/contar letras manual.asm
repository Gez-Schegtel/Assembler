name "contador_manual"
org 100h

start:
    ; --- 1. PEDIR CADENA (Lógica Manual) ---   
    ; --- 1.1 Mostrar msg_cadena por pantalla ---
    mov ah, 09h
    mov dx, offset msg_cadena
    int 21h

    ; --- 1.2 Preparamos DI (Destination Index) al inicio del buffer vacío para guardar lo que ingrese el usuario ---
    mov di, offset buffer

leer_bucle:
    mov ah, 01h      ; Leer tecla
    int 21h
    
    cmp al, 13       ; ¿Es Enter?
    je fin_lectura
    
    mov [di], al     ; Guardar en memoria
    inc di           ; Avanzar puntero
    jmp leer_bucle   ; Repetir

fin_lectura:
    mov [di], '$'    ; IMPORTANTE: Terminador '$' para DOS

    call salto_linea ; Bajamos renglón estéticamente

    ; --- 2. PEDIR LETRA ---
    mov ah, 09h
    mov dx, offset msg_letra
    int 21h
    
    ; --- 2.1 Leemos el caracter que ingrese el usuario. Queda guardado en AL ---
    mov ah, 01h      ; Leer 1 caracter
    int 21h
    mov bl, al       ; Guardamos la letra buscada en BL. Esto es una buena práctica porque AX es volátil.

    call salto_linea

    ; --- 3. CONTAR APARICIONES ---
    mov si, offset buffer ; Usaremos SI (Source Index) para recorrer la cadena ingresada por el usuario
    mov cl, 0             ; CX/CL será el contador

contar_bucle:
    cmp [si], '$'    ; Buscamos el '$' (Diferencia con librería que busca 0)
    je mostrar_resultado
    
    cmp [si], bl     ; Comparamos memoria vs registro
    jne siguiente
    
    inc cl           ; Si coincide, sumo 1

siguiente:
    inc si
    jmp contar_bucle

    ; --- 4. MOSTRAR RESULTADO ---
mostrar_resultado:
    mov ah, 09h
    mov dx, offset msg_res
    int 21h

    ; TRUCO MANUAL: Convertir número a ASCII
    ; Esto solo funciona para resultados del 0 al 9.
    ; Si la letra aparece 10 veces, saldrá un símbolo raro (:)
    add cl, 30h      
    
    mov ah, 02h      ; Imprimir un caracter
    mov dl, cl
    int 21h

    ; Esperar y salir
    mov ah, 4ch
    int 21h

; --- SUBRUTINA AUXILIAR ---
salto_linea proc
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    ret
salto_linea endp

; --- VARIABLES ---
msg_cadena db "Ingrese cadena: $"
msg_letra  db "Letra a buscar: $"
msg_res    db "Cantidad: $"

buffer db 50 dup(0) 

end
