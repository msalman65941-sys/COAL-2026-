.MODEL SMALL
.STACK 100H

.DATA
    msgInput DB 'Enter number: $'
    msgX     DB ' x $'
    msgEqual DB ' = $'
    newLine  DB 13,10,'$'

    num DW ?

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Ask for number
    LEA DX, msgInput
    MOV AH, 09H
    INT 21H

    ; Read number
    CALL READ_NUM
    MOV num, AX

    ; Counter = 1
    MOV CX, 1

TABLE_LOOP:

    ; New line
    LEA DX, newLine
    MOV AH, 09H
    INT 21H

    ; Print N
    MOV AX, num
    CALL PRINT_NUM

    ; Print " x "
    LEA DX, msgX
    MOV AH, 09H
    INT 21H

    ; Print counter
    MOV AX, CX
    CALL PRINT_NUM

    ; Print " = "
    LEA DX, msgEqual
    MOV AH, 09H
    INT 21H

    ; Calculate N * counter
    MOV AX, num
    MUL CX

    ; Print answer
    CALL PRINT_NUM

    ; Next counter
    INC CX

    ; Repeat until 10
    CMP CX, 10
    JBE TABLE_LOOP

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