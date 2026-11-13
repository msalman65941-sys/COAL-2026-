.MODEL SMALL
.STACK 100H

.DATA
    msgInput DB 'Enter N: $'
    msgSum DB 13,10,'Sum = $'
    msgError DB 13,10,'Error: Enter positive number.$'

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Input message
    LEA DX, msgInput
    MOV AH, 09H
    INT 21H

    ; Read number
    CALL READ_NUM

    ; Check positive number
    CMP AX, 0
    JLE ERROR

    ; Save N
    MOV DI, AX

    ; Initialize counter and sum
    MOV SI, 1
    MOV BX, 0

SUM_LOOP:

    ; Add counter to sum
    ADD BX, SI

    ; Increase counter
    INC SI

    ; Check counter <= N
    CMP SI, DI
    JBE SUM_LOOP

    ; Display message
    LEA DX, msgSum
    MOV AH, 09H
    INT 21H

    ; Display sum
    MOV AX, BX
    CALL PRINT_NUM

    JMP EXIT


ERROR:
    LEA DX, msgError
    MOV AH, 09H
    INT 21H


EXIT:
    MOV AH, 4CH
    INT 21H

MAIN ENDP


; =====================
; READ DECIMAL INPUT
; Result in AX
; =====================

READ_NUM PROC

    XOR BX, BX

READ_LOOP:

    MOV AH, 01H
    INT 21H

    CMP AL, 13
    JE READ_DONE

    SUB AL, '0'
    MOV CL, AL
    MOV AX, BX
    MOV DX, 10
    MUL DX
    MOV CH, 0
    ADD AX, CX
    MOV BX, AX

    JMP READ_LOOP

READ_DONE:
    MOV AX, BX
    RET

READ_NUM ENDP


; =====================
; PRINT DECIMAL NUMBER
; Input in AX
; =====================

PRINT_NUM PROC

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV BX, 10
    XOR CX, CX

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

    POP DX
    POP CX
    POP BX
    POP AX

    RET

PRINT_NUM ENDP

END MAIN