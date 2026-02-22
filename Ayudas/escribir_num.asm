
; Imagina que el procesador tiene el número 152 guardado.
; ¿Cómo le arrancamos los números de a uno para imprimirlos? Dividiendo por 10:
;
;     152 / 10 = Da 15, y sobra 2. ¡Conseguimos el 2!
;
;     15 / 10 = Da 1, y sobra 5. ¡Conseguimos el 5!
;
;     1 / 10 = Da 0, y sobra 1. ¡Conseguimos el 1!
;
; El problema: Los sacamos al revés (primero el 2, luego el 5, luego el 1). Si los imprimimos así nomás, en la pantalla saldría "251".
; La solución: Usar la Pila (Stack). Guardamos los números en la pila a medida que salen (2, luego 5, luego 1).
; Al sacarlos de la pila (POP), salen en el orden correcto (1, luego 5, luego 2).
