DISP MACRO X
         MOV DL,X
         MOV AH,02H
         INT 21H
ENDM
DATA SEGMENT
    DATA1 DB  '12732'
    DATA2 DB  '06815'
    N     EQU $-DATA2
DATA ENDS

STACK SEGMENT STACK
    STA   DB  20 DUP(?)
    TOP   EQU $-STA
STACK ENDS
CODE SEGMENT
          ASSUME CS:CODE,DS:DATA,SS:STACK,DS:DATA
    START:MOV    AX,DATA
          MOV    DS,AX
          MOV    AX,STACK
          MOV    SS,AX
          MOV    AX,TOP
          MOV    SP,AX
          LEA    SI,DATA1
          MOV    BX,0
          MOV    CX,N
          CALL   DISPL
          DISP   '+'
          LEA    SI,DATA2
          MOV    BX,0
          MOV    CX,N
          CALL   DISPL
          DISP   '='
          LEA    DI,DATA1
          MOV    BX,0
          MOV    CX,N
          CALL   ADDA
          LEA    SI,DATA1
          MOV    BX,0
          MOV    CX,N
          CALL   DISPL
          DISP   0DH
          DISP   0AH
          MOV    AX,4C00H
          INT    21H
DISPL PROC
    DS1:  MOV    AH,02H
          MOV    DL,[SI+BX]
          INT    21H
          INC    BX
          LOOP   DS1
          RET
DISPL ENDP
ADDA PROC
          PUSH   CX
          MOV    BX,0
    AD1:  SUB    BYTE PTR [SI+BX],30H
          SUB    BYTE PTR [DI+BX],30H
          INC    BX
          LOOP   AD1
          POP    CX
          PUSH   CX
          MOV    BX,N-1
          CLC
ADDA ENDP
CODE ENDS
