.MODEL SMALL
.STACK 100H

.DATA
    msgInput  DB 'Enter N: $'
    msgResult DB 13,10,'! = $'
    n         DW ?
    result    DW ?

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
    MOV n, AX

    ; Calculate factorial
    MOV AX, 1
    MOV CX, 1

FACTORIAL:
    CMP CX, n
    JA FACTORIAL_DONE

    MUL CX
    INC CX
    JMP FACTORIAL

FACTORIAL_DONE:
    MOV result, AX

    ; Print N
    MOV AX, n
    CALL PRINT_NUM

    ; Print "! = "
    LEA DX, msgResult
    MOV AH, 09H
    INT 21H

    ; Print factorial result
    MOV AX, result
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