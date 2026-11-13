.MODEL SMALL
.STACK 100H

.DATA
    num1 DB 5
    num2 DB 9

    msgLarger DB 'Larger number = $'
    msgEqual  DB 'Both numbers are equal.$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AL, num1
    MOV BL, num2

    ; Compare the two numbers
    CMP AL, BL

    JE EQUAL
    JA FIRST_LARGER

    ; If second number is larger
    LEA DX, msgLarger
    MOV AH, 09H
    INT 21H

    MOV DL, BL
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    JMP EXIT

FIRST_LARGER:
    LEA DX, msgLarger
    MOV AH, 09H
    INT 21H

    MOV DL, AL
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    JMP EXIT

EQUAL:
    LEA DX, msgEqual
    MOV AH, 09H
    INT 21H

EXIT:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN