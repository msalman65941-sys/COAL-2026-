.MODEL SMALL
.STACK 100H

.DATA
    arr DW 5, 8, 2, 8, 10, 3, 7, 1, 6, 4

    msgInput   DB 'Enter target value: $'
    msgFound   DB 13,10,'Found at index $'
    msgNot     DB 13,10,'Not found$'

    target DW ?

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Ask for target
    LEA DX, msgInput
    MOV AH, 09H
    INT 21H

    ; Read target
    CALL READ_NUM
    MOV target, AX

    ; Start searching
    MOV SI, OFFSET arr
    MOV CX, 10
    XOR BX, BX          ; BX = index

SEARCH_LOOP:

    ; Compare array element with target
    MOV AX, [SI]
    CMP AX, target
    JE FOUND

    ; Next element
    ADD SI, 2
    INC BX

    LOOP SEARCH_LOOP

    ; If loop finishes, target not found
    LEA DX, msgNot
    MOV AH, 09H
    INT 21H
    JMP EXIT


FOUND:

    ; Print "Found at index "
    LEA DX, msgFound
    MOV AH, 09H
    INT 21H

    ; Print index
    MOV AX, BX
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