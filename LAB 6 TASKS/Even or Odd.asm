.MODEL SMALL
.STACK 100H

.DATA
    num DB 26
    evenMsg DB ' is even.$'
    oddMsg  DB ' is odd.$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display the number
    MOV AL, num
    ADD AL, 30H
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    ; Test the least significant bit
    MOV AL, num
    TEST AL, 01H
    JZ EVEN

    ; If LSB = 1, number is odd
    LEA DX, oddMsg
    MOV AH, 09H
    INT 21H
    JMP EXIT

EVEN:
    ; If LSB = 0, number is even
    LEA DX, evenMsg
    MOV AH, 09H
    INT 21H

EXIT:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN