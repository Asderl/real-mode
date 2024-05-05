[org 0x7c00]                      ;offset

mov bx, message                   ;put message in bx
call print_string                 ;print message
mov di, str1
mov si, str2
call strcmp

jmp $                             ;infinite loop

%include "./utils/strings.asm"    ;include file with string utils

message db "Hello world", 0       ;define message
str1 db "Hello", 0
str2 db "Hi", 0

times 510 - ($ - $$) db 0         ;fill space from there to 510 bytes with zeroes
dw 0xaa55                         ;"magic number", end of booting sector
