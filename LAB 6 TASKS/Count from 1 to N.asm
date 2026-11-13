.MODEL SMALL
.STACK 100H

.DATA
    msgInput DB 'Enter N: $'
    msgError DB 13,10,'Error: N must be positive.$'
    space DB ' $'

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Ask for N
    LEA DX, msgInput
    MOV AH, 09H
    INT 21H

    ; Read N
    CALL READ_NUM

    CMP AX, 0
    JLE ERROR

    ; Save N
    MOV BX, AX

    ; Counter = 1
    MOV SI, 1

COUNT_LOOP:

    ; Print counter
    MOV AX, SI
    CALL PRINT_NUM

    ; Print space
    LEA DX, space
    MOV AH, 09H
    INT 21H

    ; Counter++
    INC SI

    ; Check counter <= N
    CMP SI, BX
    JBE COUNT_LOOP

    JMP EXIT


ERROR:
    LEA DX, msgError
    MOV AH, 09H
    INT 21H


EXIT:
    MOV AH, 4CH
    INT 21H


; =========================
; READ DECIMAL NUMBER
; Returns number in AX
; =========================

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
    ADD AL, CL
    MOV BX, AX

    JMP READ_LOOP

READ_DONE:
    MOV AX, BX
    RET

READ_NUM ENDP


; =========================
; PRINT DECIMAL NUMBER
; AX = number
; =========================

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