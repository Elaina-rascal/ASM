DATA SEGMENT
    GRADE DW   88H,75H,95H,63H,98H,78H,87H,73H,90H,60H
    COUNT EQU  ($-GRADE)/2                                ;成绩个数
          ORG  20H
          RANK 10 DUP(?)
DATA ENDS
STACK SEGMENT STACK
    STA   DB  20 DUP(20H)
    TOP   EQU $-STA          ;比较
STACK ENDS
CODE SEGMENT
             ASSUME CS:CODE,DS:DATA,SS:STACK
    START:   MOV    AX,DATA
             MOV    DS,AX
             MOV    AX,STACK
             MOV    SS,AX
             MOV    SP,TOP
             MOV    DI,COUNT                    ; 成绩个数
             MOV    BX,0
    LOOP1:   MOV    AX,GRADE[BX]
             MOV    CX,COUNT
             __     SI,GRADE
    NEXT:    CMP    AX,[SI]
             __     NO_COUNT
             INC    WORD PTR RANK[BX]
    NO_COUNT:ADD    SI,2
             __     NEXT
             ADD    BX,2
             DEC    DI
             __     LOOP1
             MOV    AX,4C00H
             INT    21H
CODE ENDS
END START