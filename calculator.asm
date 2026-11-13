;============================================================
;=====================START==================================
;============================================================
.MODEL SMALL
.STACK 100H

.DATA
msg1 DB 'Enter First Number:$'  
msg2 DB 13, 10, 'Enter Second Number:$' 
menu DB 13,10,'Choose Operation:',13,10,'1. Addition',13,10,'2. Subtraction',13,10,'3. Multiplication',13,10,'4. Division',13,10,'Enter choice: $'
resultMsg DB 13,10,'Result: $'
errorMsg DB 13,10,'Invalid choice!$'

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ;-------------------------------
    ;----FIRST NUMBER--------------- 
    ;-------------------------------
    
    LEA DX, msg1
    MOV AH, 09H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    
    SUB AL, 30H
    MOV BL, AL
       
    ;-------------------------------
    ;----SECOND NUMBER-------------- 
    ;-------------------------------
    
    LEA DX, msg2
    MOV AH, 09H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    
    SUB AL, 30H
    MOV BH, AL
    
    ;-------------------------------
    ;----MENU DISPLAY--------------- 
    ;-------------------------------
    
    LEA DX, menu
    MOV AH, 09H
    INT 21H
    
    ;Get Operation Choice
    
    MOV AH, 01H
    INT 21H
    
    MOV CL, AL 
    
    ;-------------------------------
    ;----CHECK CHOICE--------------- 
    ;-------------------------------
    
    CMP CL, '1'
    JE ADDITION
    
    CMP CL, '2'
    JE SUBTRACTION
    
    CMP CL, '3'
    JE MULTIPLICATION
    
    CMP CL, '4'
    JE DIVISION
    
    
    JMP INVALID
    
    ;-------------------------------
    ;----ADDITION------------------- 
    ;-------------------------------
    ADDITION:
        MOV AL, BL
        ADD AL, BH
        
        JMP DISPLAY_RESULT 
        
        
    ;------------------------------- 
    ;----SUBTRACTION---------------- 
    ;-------------------------------
    SUBTRACTION:
        MOV AL, BL
        SUB Al, BH
        
        JMP DISPLAY_RESULT 
        
        
    ;-------------------------------
    ;----MULTIPLICATION------------- 
    ;-------------------------------
    MULTIPLICATION: 
        MOV AL, BL
        MUL BH
        
        JMP DISPLAY_RESULT
        
    ;-------------------------------    
    ;----DIVISION-------------------  
    ;-------------------------------
    DIVISION:
        MOV AL, BL
        MOV AH, 00H
        DIV BH
        
        JMP DISPLAY_RESULT
    
    
    ;-------------------------------
    ;----DISPLAY RESULT-------------
    ;-------------------------------
    DISPLAY_RESULT:

        MOV CL, AL

        MOV DX, OFFSET resultMsg
        MOV AH, 09H
        INT 21H
        
        MOV AL, CL
        MOV AH, 00H
        MOV BL, 10
        DIV BL

        MOV BH, AH

        CMP AL, 0
        JE ONE_DIGIT

        ADD AL, 30H
        MOV DL, AL
        MOV AH, 02H
        INT 21H

    ONE_DIGIT:

        MOV DL, BH
        ADD DL, 30H
        MOV AH, 02H
        INT 21H

        JMP EXIT 
        
        
    ;-------------------------------    
    ;----INVALID CHOICE-------------
    ;------------------------------- 
    INVALID: 
        LEA DX, errorMsg
        MOV AH, 09H
        INT 21H
        
    ;-------------------------------    
    ;----EXIT----------------------- 
    ;-------------------------------
    EXIT:
        MOV AH, 4CH
        INT 21H
        
    MAIN ENDP
    END MAIN 
    
;============================================================
;=====================END====================================
;============================================================    
        
    
    
        
    