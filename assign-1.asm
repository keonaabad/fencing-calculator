; Keona Abad
; CS 271 Computer Architecture and Assembly Language 
; Program 1 Intro to MASM Assembly January 24 2024
; Description: This program calculates the number of rails and extra planking required for a fence.

.586
.MODEL flat, stdcall
.STACK 4096

 

.DATA
startMessage     BYTE    "HW1: Fencing a pasture by Keona Abad", 0dh, 0ah, 0
promptName       BYTE    "Enter your name: ", 0
promptLength     BYTE    "Enter the length of the pasture (in feet): ", 0
promptWidth      BYTE    "Enter the width of the pasture (in feet): ", 0
promptPlanks     BYTE    "Enter the linear feet of wooden planks available: ", 0
resultArea       BYTE    "Area of the pasture: ", 0
resultPerimeter  BYTE    "Perimeter of the pasture: ", 0
resultRails      BYTE    "Number of rails that can be constructed: ", 0
resultExtra      BYTE    "Extra planking (in feet): ", 0
goodbyeMessage   BYTE    "Thank you for using the Fence Calculator!", 0dh, 0ah, 0
userName         BYTE    50 dup(0)
bytecount        DWORD   ?
pastureLength    DWORD   ?
pastureWidth     DWORD   ?
planks           DWORD   ?
area             DWORD   ?
perimeter        DWORD   ?
rails            DWORD   ?
extra            DWORD   ?
nameLen          equ $ - userName
actualNameLen    DWORD   ?
.CODE
main PROC
    ; Welcome message
    call clrscr
    mov edx, OFFSET startMessage
    call WriteString

    ; Ask for the user's name
    mov edx, OFFSET promptName
    call WriteString
    mov edx, OFFSET userName
    mov ecx, SIZEOF userName  
    call ReadString

    mov [actualNameLen], eax

    ; Get the length of the pasture
    mov edx, OFFSET promptLength
    call WriteString
    call ReadInt
    mov pastureLength, eax

    ; Get the width of the pasture
    mov edx, OFFSET promptWidth
    call WriteString
    call ReadInt
    mov pastureWidth, eax

    ; Get the linear feet of planks
    mov edx, OFFSET promptPlanks
    call WriteString
    call ReadInt
    mov planks, eax

    ; Start the calculations
    mov eax, pastureLength
    ; Multiply length x width
    imul eax, pastureWidth
    mov area, eax

    mov eax, pastureLength
    add eax, pastureWidth
    shl eax, 1
    mov perimeter, eax

    mov eax, planks
    cdq
    idiv perimeter
    mov rails, eax
    mov extra, edx

    ; Display Results Section
    mov edx, OFFSET resultArea
    call WriteString
    mov eax, area
    call WriteDec
    call Crlf

    mov edx, OFFSET resultPerimeter
    call WriteString
    mov eax, perimeter
    call WriteDec
    call Crlf

    mov edx, OFFSET resultRails
    call WriteString
    mov eax, rails
    call WriteDec
    call Crlf

    mov edx, OFFSET resultExtra
    call WriteString
    mov eax, extra
    call WriteDec
    call Crlf 
    ; Termination Section
    mov edx, OFFSET goodbyeMessage
    call WriteString

    exit
main ENDP

END main
