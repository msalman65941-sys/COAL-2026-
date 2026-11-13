
include 'emu8086.inc'
org 100h

jmp start

; Declare four DWORD variables
num1 dd 120
num2 dd 250
num3 dd 80
num4 dd 50
result dd 0

start:

; Load first DWORD into DX:AX
mov ax, word ptr [num1]
mov dx, word ptr [num1+2]

; Add second DWORD
add ax, word ptr [num2]
adc dx, word ptr [num2+2]

; Add third DWORD
add ax, word ptr [num3]
adc dx, word ptr [num3+2]

; Subtract fourth DWORD
sub ax, word ptr [num4]
sbb dx, word ptr [num4+2]

; Store final DWORD result
mov word ptr [result], ax
mov word ptr [result+2], dx

; Display result
print 'Final Result = '
call print_num

ret

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
