

; Realice un programa que anide 3 bucles. Se deberá poder definir la cantidad de
; iteraciones de cada bucle, e imprimir en pantalla un indicador numérico de cada
; iteración.

name "comp2.1"
org 100h
include "emu8086.inc"

; --- 1. INGRESOS (Guardamos en los TOTALES fijos) ---
PRINT "Iteraciones Bucle 1 (Buckley): "
call SCAN_NUM
mov total_buckley, cx
putc 13
putc 10

PRINT "Iteraciones Bucle 2 (Lynne): "
call SCAN_NUM
mov total_lynne, cx
putc 13
putc 10

PRINT "Iteraciones Bucle 3 (Beck): "
call SCAN_NUM
mov total_beck, cx
putc 13
putc 10
putc 13
putc 10

; --- INICIALIZAR CONTADORES ---
; Antes de empezar, copiamos los totales a los contadores móviles
mov ax, total_buckley
mov num_buckley, ax

; =========================
; BUCLE 1 (EXTERNO)
; =========================
jeff_buckley:
    cmp num_buckley, 0
    je fin_programa

    ; Imprimir info del bucle 1
    PRINTN "-----------------"
    PRINT "Bucle 1 (Buckley): "
    mov ax, num_buckley
    call PRINT_NUM
    putc 13
    putc 10

    ; --- REINICIO DEL BUCLE 2 ---
    ; Cada vez que Buckley da una vuelta, Lynne vuelve a empezar full.
    mov ax, total_lynne
    mov num_lynne, ax

    ; =========================
    ; BUCLE 2 (MEDIO)
    ; =========================
    jeff_lynne:
        cmp num_lynne, 0
        je fin_lynne      ; Si Lynne termina, volvemos a Buckley

        PRINT "  Bucle 2 (Lynne): "
        mov ax, num_lynne
        call PRINT_NUM
        putc 13
        putc 10

        ; --- REINICIO DEL BUCLE 3 ---
        ; Cada vez que Lynne da una vuelta, Beck vuelve a empezar full.
        mov ax, total_beck
        mov num_beck, ax

        ; =========================
        ; BUCLE 3 (INTERNO)
        ; =========================
        jeff_beck:
            cmp num_beck, 0
            je fin_beck   ; Si Beck termina, volvemos a Lynne

            PRINT "    Bucle 3 (Beck): "
            mov ax, num_beck
            call PRINT_NUM
            putc 13
            putc 10

            dec num_beck
            jmp jeff_beck ; Repetimos Beck

        fin_beck:
            ; Terminó Beck, restamos 1 a Lynne y repetimos
            dec num_lynne
            jmp jeff_lynne

    fin_lynne:
        ; Terminó Lynne, restamos 1 a Buckley y repetimos
        dec num_buckley
        jmp jeff_buckley

fin_programa:
    PRINTN "Fin del show."
    mov ah, 4ch
    int 21h

; --- VARIABLES ---
; Totales (Fijos, nunca cambian)
total_buckley dw ?
total_lynne   dw ?
total_beck    dw ?

; Contadores (Móviles, se restan y se recargan)
num_buckley   dw ?
num_lynne     dw ?
num_beck      dw ?

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_SCAN_NUM

END
