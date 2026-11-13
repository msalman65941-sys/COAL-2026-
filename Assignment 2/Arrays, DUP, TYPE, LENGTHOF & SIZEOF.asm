
include 'emu8086.inc'
org 100h

jmp start

; Part A: 12 BYTE elements
byteArray db 12 dup(0)
byteSize equ $ - offset byteArray

; Part B: 8 WORD elements
wordArray dw 8 dup(?)
wordSize equ $ - offset wordArray

; Part C: Name with NULL terminator
firstName db 'Shan', 0
nameSize equ $ - offset firstName

start:

; BYTE Array Information
printn 'BYTE Array:'
print 'TYPE = 1, LENGTHOF = 12, SIZEOF = '
mov ax, byteSize
call print_num
printn

; WORD Array Information
printn 'WORD Array:'
print 'TYPE = 2, LENGTHOF = 8, SIZEOF = '
mov ax, wordSize
call print_num
printn

; String Information
printn 'Name String:'
print 'TYPE = 1, LENGTHOF = 5, SIZEOF = '
mov ax, nameSize
call print_num
printn

ret

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
