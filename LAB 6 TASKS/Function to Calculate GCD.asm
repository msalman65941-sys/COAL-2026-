.MODEL SMALL
.STACK 100H

.DATA
    msgA      DB 'Enter first positive integer: $'
    msgB      DB 13,10,'Enter second positive integer: $'
    msgResult DB 13,10,'GCD = $'

    num1 DW ?
    num2 DW ?

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; =========================
    ; Read first number
    ; =========================
    LEA DX, msgA
    MOV AH, 09H
    INT 21H

    CALL READ_NUM
    MOV num1, AX

    ; =========================
    ; Read second number
    ; =========================
    LEA DX, msgB
    MOV AH, 09H
    INT 21H

    CALL READ_NUM
    MOV num2, AX

    ; =========================
    ; Call GCD
    ; AX = first number
    ; BX = second number
    ; AX = GCD result
    ; =========================
    MOV AX, num1
    MOV BX, num2
    CALL GCD

    ; Save result
    PUSH AX

    ; Print message
    LEA DX, msgResult
    MOV AH, 09H
    INT 21H

    ; Print GCD
    POP AX
    CALL PRINT_NUM

    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP


; =========================
; GCD PROCEDURE
; AX = first number
; BX = second number
; AX = GCD
; =========================

GCD PROC

GCD_LOOP:

    ; DX:AX / BX
    XOR DX, DX
    DIV BX

    ; AX = quotient
    ; DX = remainder

    ; If remainder = 0
    ; BX is the GCD
    CMP DX, 0
    JE GCD_DONE

    ; Next:
    ; first = old second
    ; second = remainder

    MOV AX, BX
    MOV BX, DX

    JMP GCD_LOOP

GCD_DONE:

    MOV AX, BX
    RET

GCD ENDP


; =========================
; READ NUMBER
; =========================

READ_NUM PROC

    XOR BX, BX

READ_LOOP:

    MOV AH, 01H
    INT 21H

    CMP AL, 13
    JE READ_DONE

    SUB AL, '0'
    XOR AH, AH

    PUSH AX

    MOV AX, BX
    MOV DX, 10
    MUL DX
    MOV BX, AX

    POP AX
    ADD BX, AX

    JMP READ_LOOP

READ_DONE:

    MOV AX, BX
    RET

READ_NUM ENDP


; =========================
; PRINT NUMBER
; =========================

PRINT_NUM PROC

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV BX, 10
    XOR CX, CX

    CMP AX, 0
    JNE CONVERT

    MOV DL, '0'
    MOV AH, 02H
    INT 21H
    JMP PRINT_DONE

CONVERT:

    XOR DX, DX
    DIV BX

    PUSH DX
    INC CX

    CMP AX, 0
    JNE CONVERT

DISPLAY:

    POP DX
    ADD DL, '0'

    MOV AH, 02H
    INT 21H

    LOOP DISPLAY

PRINT_DONE:

    POP DX
    POP CX
    POP BX
    POP AX

    RET

PRINT_NUM ENDP

END MAIN