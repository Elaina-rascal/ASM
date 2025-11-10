; 文件名：hello.asm
; 功能：在屏幕上显示字符串并退出

org 0x100        ; COM程序起始地址（8086 DOS环境下）

section .text
start:
    mov ah, 0x09 ; DOS功能号：显示字符串（DS:DX指向字符串）
    mov dx, msg  ; DX寄存器指向要显示的字符串
    int 0x21     ; 调用DOS中断

    mov ah, 0x4c ; DOS功能号：程序退出
    int 0x21     ; 调用DOS中断

section .data
msg db 'Hello, 8086!', 0x0d, 0x0a ; 要显示的字符串（0x0d=回车，0x0a=换行）
    db '$'                        ; DOS字符串结束标记（0x09功能要求）