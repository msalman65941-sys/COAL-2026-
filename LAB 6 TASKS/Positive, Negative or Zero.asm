ORG 100h            ; Standard origin offset for .COM files

.DATA               ; Define variables and display messages
    NUM     DW 26  ; Change this value to test (e.g., 15, -15, or 0)
    
    MSG_POS DB "The number is Positive.$"
    MSG_NEG DB "The number is Negative.$"
    MSG_ZER DB "The number is Zero.$"

.CODE
MAIN PROC
    ; Initialize data segment register
    MOV AX, @DATA
    MOV DS, AX
    
    ; Load the number into the AX register
    MOV AX, NUM
    
    ; Compare AX with 0 (this updates the CPU status flags)
    CMP AX, 0       
    
    ; Jump instructions based on the comparison flags
    JZ  IS_ZERO     ; Jump if Zero flag is set (AX == 0)
    JS  IS_NEG      ; Jump if Sign flag is set (AX < 0 / negative)
                    ; If neither jump triggers, the number must be positive (AX > 0)

IS_POS:
    LEA DX, MSG_POS ; Load address of the positive string
    JMP DISPLAY     ; Jump to the display routine

IS_NEG:
    LEA DX, MSG_NEG ; Load address of the negative string
    JMP DISPLAY     ; Jump to the display routine

IS_ZERO:
    LEA DX, MSG_ZER ; Load address of the zero string

DISPLAY:
    ; DOS interrupt to print the string stored in DX
    MOV AH, 09h     
    INT 21h         
    
    ; Graceful program termination
    MOV AH, 4Ch     
    INT 21h         
MAIN ENDP

END MAIN