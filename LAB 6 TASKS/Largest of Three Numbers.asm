.MODEL SMALL
.STACK 100H

.DATA
    num1 DB 48
    num2 DB 42
    num3 DB 19

    msg DB 'Largest = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Find largest
    MOV AL, num1
    CMP AL, num2
    JAE CHECK_NUM3

    MOV AL, num2

CHECK_NUM3:
    CMP AL, num3
    JAE SHOW

    MOV AL, num3

SHOW:
    ; Save largest number in BH
    MOV BH, AL

    ; Display message
    LEA DX, msg
    MOV AH, 09H
    INT 21H

    ; Convert number to two decimal digits
    MOV AL, BH
    MOV AH, 0
    MOV BL, 10
    DIV BL

    ; AL = tens
    ; AH = ones

    CMP AL, 0
    JE ONLY_ONES

    ; Print tens
    MOV CL, AH
    MOV DL, AL
    ADD DL, 30H
    MOV AH, 02H
    INT 21H

    ; Print ones
    MOV DL, CL
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    JMP EXIT

ONLY_ONES:
    MOV DL, AH
    ADD DL, 30H
    MOV AH, 02H
    INT 21H

EXIT:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN