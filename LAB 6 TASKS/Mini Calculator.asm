.MODEL SMALL
.STACK 100H

.DATA
    menu DB 13,10,'===== MINI CALCULATOR =====',13,10
         DB '1. Add',13,10
         DB '2. Subtract',13,10
         DB '3. Multiply',13,10
         DB '4. Divide',13,10
         DB '5. Exit',13,10
         DB 'Select option: $'

    msgA DB 13,10,'Enter first number: $'
    msgB DB 13,10,'Enter second number: $'

    msgAdd DB 13,10,'Addition = $'
    msgSub DB 13,10,'Subtraction = $'
    msgMul DB 13,10,'Multiplication = $'
    msgDiv DB 13,10,'Division = $'

    msgInvalid DB 13,10,'Invalid choice!$'
    msgZero DB 13,10,'Error: Division by zero!$'
    msgRem DB ' Remainder = $'

    num1 DW ?
    num2 DW ?

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

MENU_LOOP:

    LEA DX, menu
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    CMP AL, '1'
    JE ADD_CASE

    CMP AL, '2'
    JE SUB_CASE

    CMP AL, '3'
    JE MUL_CASE

    CMP AL, '4'
    JE DIV_CASE

    CMP AL, '5'
    JE EXIT_PROGRAM

    LEA DX, msgInvalid
    MOV AH, 09H
    INT 21H
    JMP MENU_LOOP


; =========================
; ADD
; =========================

ADD_CASE:

    CALL GET_NUMBERS

    MOV AX, num1
    MOV BX, num2
    CALL ADDITION

    PUSH AX

    LEA DX, msgAdd
    MOV AH, 09H
    INT 21H

    POP AX
    CALL PRINT_NUM

    JMP MENU_LOOP


; =========================
; SUBTRACT
; =========================

SUB_CASE:

    CALL GET_NUMBERS

    MOV AX, num1
    MOV BX, num2
    CALL SUBTRACTION

    PUSH AX

    LEA DX, msgSub
    MOV AH, 09H
    INT 21H

    POP AX
    CALL PRINT_SIGNED

    JMP MENU_LOOP


; =========================
; MULTIPLY
; =========================

MUL_CASE:

    CALL GET_NUMBERS

    MOV AX, num1
    MOV BX, num2
    CALL MULTIPLICATION

    PUSH AX

    LEA DX, msgMul
    MOV AH, 09H
    INT 21H

    POP AX
    CALL PRINT_NUM

    JMP MENU_LOOP


; =========================
; DIVIDE
; =========================

DIV_CASE:

    CALL GET_NUMBERS

    CMP num2, 0
    JE DIV_ZERO

    MOV AX, num1
    MOV BX, num2
    CALL DIVISION

    ; Save remainder
    PUSH DX

    ; Print quotient
    LEA DX, msgDiv
    MOV AH, 09H
    INT 21H

    CALL PRINT_NUM

    ; Print remainder
    LEA DX, msgRem
    MOV AH, 09H
    INT 21H

    POP AX
    CALL PRINT_NUM

    JMP MENU_LOOP


DIV_ZERO:

    LEA DX, msgZero
    MOV AH, 09H
    INT 21H

    JMP MENU_LOOP


; =========================
; EXIT
; =========================

EXIT_PROGRAM:

    MOV AH, 4CH
    INT 21H

MAIN ENDP


; =================================================
; GET TWO NUMBERS
; =================================================

GET_NUMBERS PROC

    LEA DX, msgA
    MOV AH, 09H
    INT 21H

    CALL READ_NUM
    MOV num1, AX

    LEA DX, msgB
    MOV AH, 09H
    INT 21H

    CALL READ_NUM
    MOV num2, AX

    RET

GET_NUMBERS ENDP


; =================================================
; ADDITION
; =================================================

ADDITION PROC

    ADD AX, BX
    RET

ADDITION ENDP


; =================================================
; SUBTRACTION
; =================================================

SUBTRACTION PROC

    SUB AX, BX
    RET

SUBTRACTION ENDP


; =================================================
; MULTIPLICATION
; =================================================

MULTIPLICATION PROC

    MUL BX
    RET

MULTIPLICATION ENDP


; =================================================
; DIVISION
; =================================================

DIVISION PROC

    XOR DX, DX
    DIV BX

    RET

DIVISION ENDP


; =================================================
; READ NUMBER
; =================================================

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


; =================================================
; PRINT NUMBER
; =================================================

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


; =================================================
; PRINT SIGNED NUMBER
; =================================================

PRINT_SIGNED PROC

    CMP AX, 0
    JGE POSITIVE

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


END MAIN