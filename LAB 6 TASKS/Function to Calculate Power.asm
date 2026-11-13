.MODEL SMALL
.STACK 100H

.DATA
    msgBase DB 'Enter base: $'
    msgExp  DB 13,10,'Enter exponent: $'
    msgEq   DB 13,10,'^$'
    msgRes  DB ' = $'

    base DW ?
    exponent DW ?

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; =========================
    ; Read Base
    ; =========================
    LEA DX, msgBase
    MOV AH, 09H
    INT 21H

    CALL READ_NUM
    MOV base, AX

    ; =========================
    ; Read Exponent
    ; =========================
    LEA DX, msgExp
    MOV AH, 09H
    INT 21H

    CALL READ_NUM
    MOV exponent, AX

    ; =========================
    ; Call Power procedure
    ; AX = base
    ; BX = exponent
    ; =========================
    MOV AX, base
    MOV BX, exponent
    CALL Power

    ; Save result
    PUSH AX

    ; Print base
    MOV AX, base
    CALL PRINT_NUM

    ; Print ^
    LEA DX, msgEq
    MOV AH, 09H
    INT 21H

    ; Print exponent
    MOV AX, exponent
    CALL PRINT_NUM

    ; Print =
    LEA DX, msgRes
    MOV AH, 09H
    INT 21H

    ; Print result
    POP AX
    CALL PRINT_NUM

    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP


; =========================
; POWER PROCEDURE
; AX = base
; BX = exponent
; AX = result
; =========================

Power PROC

    MOV CX, BX
    MOV BX, AX

    ; result = 1
    MOV AX, 1

    ; exponent = 0
    CMP CX, 0
    JE POWER_DONE

POWER_LOOP:

    MUL BX          ; AX = AX * base

    LOOP POWER_LOOP

POWER_DONE:
    RET

Power ENDP


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