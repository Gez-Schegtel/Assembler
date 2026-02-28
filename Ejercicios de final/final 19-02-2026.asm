
; Realice un programa en Assembler para 8086 utilizando únicamente interrupciones (NO la librería emu8086)
; donde se ingresen por teclado 10 dígitos y luego imprima por pantalla:
; 1. El valor máximo.
; 2. La cantidad de números pares.
; 3. La suma de todos los dígitos ingresados.

name "examen_sin_libreria"
org 100h

start:
    mov ah, 09h
    mov dx, offset msg_ingreso
    int 21h

    ; Inicializamos variables en memoria
    mov byte ptr [maximo], 0
    mov byte ptr [cant_pares], 0
    mov word ptr [suma], 0

    mov cx, 10

ingreso_bucle:
    mov ah, 01h
    int 21h
    sub al, 30h

    ; Sumar al total
    mov ah, 0
    add [suma], ax          ; Sumamos directamente a la variable

    ; Buscar máximo
    cmp al, [maximo]        ; Comparamos con la variable maximo
    jbe no_es_mayor
    mov [maximo], al        ; Guardamos el nuevo máximo
no_es_mayor:

    ; Verificar si es par
    test al, 1
    jnz no_es_par
    inc byte ptr [cant_pares]   ; Incrementamos la variable
no_es_par:

    loop ingreso_bucle

    ; --- MOSTRAR MÁXIMO ---
    mov ah, 09h
    mov dx, offset msg_max
    int 21h
    mov ah, 02h
    mov dl, [maximo]
    add dl, 30h
    int 21h

    ; --- MOSTRAR PARES ---
    mov ah, 09h
    mov dx, offset msg_pares
    int 21h
    mov ax, 0
    mov al, [cant_pares]
    call IMPRIMIR_NUMERO

    ; --- MOSTRAR SUMA ---
    mov ah, 09h
    mov dx, offset msg_suma
    int 21h
    mov ax, [suma]
    call IMPRIMIR_NUMERO

    mov ah, 4ch
    int 21h

; =========================================================
IMPRIMIR_NUMERO PROC
    mov cl, 10
    div cl
    cmp al, 0
    je solo_unidades
    mov dl, al
    add dl, 30h
    push ax
    mov ah, 02h
    int 21h
    pop ax
solo_unidades:
    mov dl, ah
    add dl, 30h
    mov ah, 02h
    int 21h
    ret
IMPRIMIR_NUMERO ENDP

; =========================================================
; DATOS
; =========================================================
maximo      db 0
cant_pares  db 0
suma        dw 0

msg_ingreso db "Ingrese 10 digitos seguidos: $"
msg_max     db 13, 10, 13, 10, "1. El valor maximo es: $"
msg_pares   db 13, 10, "2. La cantidad de numeros pares es: $"
msg_suma    db 13, 10, "3. La suma total es: $"
END
