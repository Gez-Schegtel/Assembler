; 2) Realice un programa que intercambie los contenidos de dos valores decimales
; definidos en dato1 y dato2.

name "ejercicio_2"
org 100h
include "emu8086.inc"

start:
    ; --- MOSTRAR VALORES ORIGINALES ---
    PRINT "Valor original dato1: "
    
    xor ax, ax      ; Limpio AX
    mov al, dato1   ; LEER VALOR (Sin offset)
    call PRINT_NUM
    PRINTN ""

    PRINT "Valor original dato2: "
    
    xor ax, ax
    mov al, dato2   ; LEER VALOR
    call PRINT_NUM
    PRINTN ""

    ; --- PROCESO DE INTERCAMBIO (SWAP) ---
    ; No se puede hacer 'xchg dato1, dato2' directo.
    ; Usamos AL como intermediario.
    
    mov al, dato1    ; 1. Copio dato1 (12) a AL
    xchg al, dato2   ; 2. Intercambio: AL recibe 15, dato2 recibe 12
    mov dato1, al    ; 3. Copio AL (15) a dato1
    
    PRINTN ""
    PRINTN "--------------------------------"
    PRINTN "Ahora, hicimos un intercambio..."
    PRINTN "--------------------------------"

    ; --- MOSTRAR VALORES NUEVOS ---
    PRINT "Nuevo valor dato1: "
    xor ax, ax
    mov al, dato1    ; Ahora debería ser 15
    call PRINT_NUM
    PRINTN ""

    PRINT "Nuevo valor dato2: "
    xor ax, ax
    mov al, dato2    ; Ahora debería ser 12
    call PRINT_NUM
    PRINTN ""

    ; Salida segura
    mov ah, 4ch
    int 21h

; --- VARIABLES ---
dato1 db 12
dato2 db 15

; --- DEFINICIONES ---
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS  ; <--- OBLIGATORIO para que funcione PRINT_NUM

end
