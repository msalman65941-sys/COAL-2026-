.MODEL SMALL
.STACK 100H

.DATA
    year DW 2024

    msg1 DB ' is a leap year.$'
    msg2 DB ' is not a leap year.$'

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Check divisible by 400
    MOV AX, year
    XOR DX, DX
    MOV BX, 400
    DIV BX

    CMP DX, 0
    JE LEAP

    ; Check divisible by 100
    MOV AX, year
    XOR DX, DX
    MOV BX, 100
    DIV BX

    CMP DX, 0
    JE NOT_LEAP

    ; Check divisible by 4
    MOV AX, year
    XOR DX, DX
    MOV BX, 4
    DIV BX

    CMP DX, 0
    JE LEAP

    JMP NOT_LEAP


LEAP:
    MOV AX, year
    CALL PRINT_NUM

    LEA DX, msg1
    MOV AH, 09H
    INT 21H
    JMP EXIT


NOT_LEAP:
    MOV AX, year
    CALL PRINT_NUM

    LEA DX, msg2
    MOV AH, 09H
    INT 21H


EXIT:
    MOV AH, 4CH
    INT 21H

MAIN ENDP


; -------------------------
; Decimal number printing
; AX = number
; -------------------------

PRINT_NUM PROC

    MOV BX, 10
    MOV CX, 0

CONVERT:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE CONVERT

DISPLAY:
    POP DX
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    LOOP DISPLAY

    RET

PRINT_NUM ENDP

END MAIN