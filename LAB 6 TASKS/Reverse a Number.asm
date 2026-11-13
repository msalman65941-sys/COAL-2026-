.MODEL SMALL
.STACK 100H

.DATA
    msgInput  DB 'Enter a non-negative integer: $'
    msgResult DB 13,10,'Reverse = $'

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
    MOV BX, AX          ; BX = original number

    ; Result message
    LEA DX, msgResult
    MOV AH, 09H
    INT 21H

    ; If number is 0
    CMP BX, 0
    JNE REVERSE

    MOV DL, '0'
    MOV AH, 02H
    INT 21H
    JMP EXIT


REVERSE:
    XOR SI, SI          ; SI = reverse
    MOV DI, 10

REVERSE_LOOP:

    ; AX = original number
    MOV AX, BX
    XOR DX, DX

    ; AX / 10
    DIV DI

    ; DX contains last digit
    ; Save quotient in BX
    MOV BX, AX

    ; reverse = reverse * 10 + digit
    PUSH DX

    MOV AX, SI
    MUL DI
    MOV SI, AX

    POP DX
    ADD SI, DX

    ; Continue until quotient = 0
    CMP BX, 0
    JNE REVERSE_LOOP

    ; Print reverse
    MOV AX, SI
    CALL PRINT_NUM


EXIT:
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