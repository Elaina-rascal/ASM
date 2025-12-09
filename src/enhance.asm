DATA SEGMENT
    GRADE     DW  88H,75H,95H,63H,98H,78H,87H,73H,90H,60H
    COUNT     EQU ($-GRADE)/2
              ORG 20H
    RANK      DW  10 DUP(?)
    MSG_SCORE DB  'Score: $'
    MSG_RANK  DB  '  Rank: $'
    NEWLINE   DB  0DH,0AH,'$'
DATA ENDS
STACK SEGMENT STACK
    STA   DB  20 DUP(20H)
    TOP   EQU $-STA
STACK ENDS
CODE SEGMENT
             ASSUME CS:CODE,DS:DATA,SS:STACK
    START:   MOV    AX,DATA
             MOV    DS,AX
             MOV    AX,STACK
             MOV    SS,AX
             MOV    SP,TOP
             MOV    DI,COUNT
             MOV    BX,0
    LOOP1:   MOV    WORD PTR RANK[BX],0
             MOV    AX,GRADE[BX]
             MOV    CX,COUNT
             LEA    SI,GRADE
    NEXT:    CMP    AX,[SI]
             JA     NO_COUNT
             INC    WORD PTR RANK[BX]
    NO_COUNT:ADD    SI,2
             LOOP   NEXT
             ADD    BX,2
             DEC    DI
             JNZ    LOOP1

             MOV    CX,COUNT
             MOV    BX,0
    SHOW:    LEA    DX,MSG_SCORE
             MOV    AH,09H
             INT    21H
             MOV    AX,GRADE[BX]
             CALL   PRINTHEX
             LEA    DX,MSG_RANK
             MOV    AH,09H
             INT    21H
             MOV    AX,RANK[BX]
             CALL   PRINTHEX
             LEA    DX,NEWLINE
             MOV    AH,09H
             INT    21H
             ADD    BX,2
             LOOP   SHOW

             MOV    AX,4C00H
             INT    21H

PRINTHEX PROC
             PUSH   CX
             PUSH   DX
             MOV    DH,AL
             MOV    CL,4
             SHR    AL,CL
             CMP    AL,0AH
             JL     NUM1
             ADD    AL,07H
    NUM1:    ADD    AL,30H
             MOV    DL,AL
             MOV    AH,02H
             INT    21H
             MOV    AL,DH
             AND    AL,0FH
             CMP    AL,0AH
             JL     NUM2
             ADD    AL,07H
    NUM2:    ADD    AL,30H
             MOV    DL,AL
             MOV    AH,02H
             INT    21H
             POP    DX
             POP    CX
             RET
PRINTHEX ENDP
CODE ENDS
END START