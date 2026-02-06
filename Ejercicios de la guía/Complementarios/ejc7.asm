
; Realice un programa Assembler que verifique si un número ingresado es múltiplo de otro.

name "comp7"
org 100h
include "emu8086.inc"

PRINT "Ingrese un número: "
call SCAN_NUM
mov ax, cx
PRINTN ""

PRINT "Ingrese otro número: "
call SCAN_NUM
PRINTN ""

cmp cx, 0
jne divisor_valido

PRINTN "No se puede dividir por cero."
jmp fin_programa

divisor_valido:

xor dx, dx
div cx

PRINT "Cociente: "
call PRINT_NUM

PRINTN ""

xchg ax, dx

PRINT "Resto: "
call PRINT_NUM

PRINTN ""

xchg ax, dx

cmp dx, 0
jne no_son_multiplos

PRINTN "El primer número es múltiplo del segundo."
jmp fin_programa

no_son_multiplos:
  PRINTN "El primer número no es múltiplo del segundo."

fin_programa:
  mov ah, 4ch
  int 21h

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_SCAN_NUM

END
