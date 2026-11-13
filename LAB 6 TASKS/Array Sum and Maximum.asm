.MODEL SMALL
.STACK 100H

.DATA
    arr DW 4, 12, -3, 8, 19, 2, 7, -5, 11, 6

    sum DW ?
    maximum DW ?

    msgSum DB 'Sum = $'
    msgMax DB 13,10,'Maximum = $'

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Initialize
    MOV SI, OFFSET arr
    MOV CX, 10

    ; First element becomes initial maximum
    MOV AX, [SI]
    MOV maximum, AX

    ; Initial sum
    MOV sum, AX

    ; Move to next element
    ADD SI, 2
    DEC CX

TRAVERSE:

    ; Add current element to sum
    MOV AX, [SI]
    ADD sum, AX

    ; Check if current element > maximum
    CMP AX, maximum
    JLE NOT_MAX

    MOV maximum, AX

NOT_MAX:

    ; Next array element
    ADD SI, 2
    LOOP TRAVERSE


    ; =========================
    ; Display Sum
    ; =========================

    LEA DX, msgSum
    MOV AH, 09H
    INT 21H

    MOV AX, sum
    CALL PRINT_SIGNED


    ; =========================
    ; Display Maximum
    ; =========================

    LEA DX, msgMax
    MOV AH, 09H
    INT 21H

    MOV AX, maximum
    CALL PRINT_SIGNED


    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP


; =========================
; PRINT SIGNED NUMBER
; =========================

PRINT_SIGNED PROC

    CMP AX, 0
    JGE POSITIVE

    ; Print minus sign
    PUSH AX

    MOV DL, '-'
    MOV AH, 02H
    INT 21H

    POP AX
    NEG AX

POSITIVE:

    CALL PRINT_NUM
    RET

PRINT_SIGNED ENDP


; =========================
; PRINT UNSIGNED NUMBER
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