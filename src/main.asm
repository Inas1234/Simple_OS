org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A


start:
    jmp main


puts:
    push si
    push ax



.loop:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0e
    mov bh, 0
    int 0x10
    jmp .loop

.done:
    pop ax
    pop si
    ret 

getchar:
    xor ah, ah
    int 0x16
    ret

prompt:
    mov si, msg_hello
    call puts
    ret


newline:
    mov ah, 0x0e
    mov al, 0x0d
    int 0x10
    mov al, 0x0a
    int 0x10
    ret



main:
    mov ax, 0
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    call prompt
    call getchar
    sub al, '0'
    mov [num1], al
    call printnum
    call newline

    call getchar
    sub al, '0'
    mov [num2], al
    call printnum
    call newline

    mov al, [num1]
    add al, [num2]
    mov ah, 0
    adc ah, 0
    add al, '0'
    add ah, '0'
    mov [result], ax
    call putchar
    call newline

    hlt


printnum:
    mov ah, 0x0e  
    mov bh, 0     
    mov bl, 7
    add al, '0'
    int 0x10     
    ret


putchar:
    mov ah, 0x0e  
    mov bh, 0     
    mov bl, 7
    int 0x10     
    ret

.halt:
    jmp .halt



msg_hello: db "Enter 2 numbers", ENDL, 0
num1: resb 1
num2: resb 1
result: resb 1
num_output: resb 2

times 510-($-$$) db 0
dw 0AA55h