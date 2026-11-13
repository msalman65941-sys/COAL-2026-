

mov ax, bl   ;Problem: AX 16-bit aur BL 8-bit hai
;----Correct: mov ax, bx  

mov 5, ax    ;Problemn: Immediate value destination nahi ho sakti 
;----Correct: mov result, ax 


mov cx, [ax] ;;Problem: 8086 mein AX valid memory base register nahi 
;----Correct:mov cx, [si]