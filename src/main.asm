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

main:
    mov ax, 0
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    call prompt
    call getchar
    mov [name], al
    cmp al, 0x31
    je .is_one
    jmp .not_one
    hlt


.is_one:
    mov si, msg_one
    call puts
    jmp read_input


.not_one:
    cmp al, 0x0D
    je .halt
    mov si, msg_not_one
    call puts
    jmp read_input

.halt:
    jmp .halt

read_input:
    xor al, al
    call getchar
    mov [name], al
    jmp main

msg_hello: db "Enter 1 if you are gay or enter 2 if you are not gay", ENDL, 0
msg_one: db "Nigga you gayyy", ENDL, 0
msg_not_one: db "You aight", ENDL, 0
name: resb 1

times 510-($-$$) db 0
dw 0AA55h