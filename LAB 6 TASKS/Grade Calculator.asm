.MODEL SMALL
.STACK 100H

.DATA
    marks DB 80

    msgGrade DB 'Grade = $'
    msgInvalid DB 'Invalid marks!$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AL, marks

    ; Check if marks > 100
    CMP AL, 100
    JA INVALID

    ; Check A: 80-100
    CMP AL, 80
    JAE GRADE_A

    ; Check B: 70-79
    CMP AL, 70
    JAE GRADE_B

    ; Check C: 60-69
    CMP AL, 60
    JAE GRADE_C

    ; Check D: 50-59
    CMP AL, 50
    JAE GRADE_D

    ; Below 50 = F
    JMP GRADE_F


GRADE_A:
    LEA DX, msgGrade
    MOV AH, 09H
    INT 21H

    MOV DL, 'A'
    MOV AH, 02H
    INT 21H
    JMP EXIT


GRADE_B:
    LEA DX, msgGrade
    MOV AH, 09H
    INT 21H

    MOV DL, 'B'
    MOV AH, 02H
    INT 21H
    JMP EXIT


GRADE_C:
    LEA DX, msgGrade
    MOV AH, 09H
    INT 21H

    MOV DL, 'C'
    MOV AH, 02H
    INT 21H
    JMP EXIT


GRADE_D:
    LEA DX, msgGrade
    MOV AH, 09H
    INT 21H

    MOV DL, 'D'
    MOV AH, 02H
    INT 21H
    JMP EXIT


GRADE_F:
    LEA DX, msgGrade
    MOV AH, 09H
    INT 21H

    MOV DL, 'F'
    MOV AH, 02H
    INT 21H
    JMP EXIT


INVALID:
    LEA DX, msgInvalid
    MOV AH, 09H
    INT 21H


EXIT:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN