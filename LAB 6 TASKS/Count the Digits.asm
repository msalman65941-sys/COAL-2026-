.MODEL SMALL
.STACK 100H

.DATA
    msgInput  DB 'Enter a non-negative integer: $'
    msgResult DB 13,10,'Number of digits = $'

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Ask for input
    LEA DX, msgInput
    MOV AH, 09H
    INT 21H

    ; Read number
    CALL READ_NUM
    MOV BX, AX

    ; Special case: 0 has 1 digit
    CMP BX, 0
    JNE COUNT_START

    MOV CX, 1
    JMP SHOW_RESULT

COUNT_START:
    XOR CX, CX

COUNT_LOOP:
    XOR DX, DX
    MOV AX, BX
    MOV SI, 10
    DIV SI

    MOV BX, AX
    INC CX

    CMP BX, 0
    JNE COUNT_LOOP

SHOW_RESULT:

    ; Print result message
    LEA DX, msgResult
    MOV AH, 09H
    INT 21H

    ; Print digit count
    MOV AX, CX
    CALL PRINT_NUM

    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP


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