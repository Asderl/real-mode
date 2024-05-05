print_string:                     ;print string function (string in bx)
	pusha                     ;push all registers to stack
	
	mov ah, 0x0e              ;0x0e - display char
	
	cycle:                    ;print cycle
		mov al, [bx]      ;move byte to al
		cmp al, 0         ;check if al == 0
		je exit           ;if true exit
		jmp print_char    ;else print char
		
	print_char:               ;print char
		int 0x10          ;call BIOS interrupt 0x10, ah = 0x0e - print char
		inc bx            ;bx++
		jmp cycle         ;loop
	
	exit:
		popa              ;restore all registers from stack
		ret               ;exit
		
		
strlen:                           ;get string length function (string in bx, length in cx)
	push bx                   ;push bx to stack
	xor cx, cx                ;reset cx
	len:                      ;length calculation cycle
		cmp byte [bx], 0  ;check if symbol == 0
		je return         ;if true exit
		inc cx            ;cx++
		inc bx            ;bx++
		jmp len           ;loop
	
	return:
		pop bx            ;restore bx from stack
		ret               ;exit
		
		
strcmp:                           ;compare strings (di - str1, si - str2, cx - result)
	push bx                   ;push registers to stack
	push dx
	push si
	push di
	mov bx, si                ;put second string in bx
	call strlen               ;calculate string length
	
	repe cmpsb                ;compare strings
	jnz notequal              ;check if not equal
	
	mov dx, cx                ;put second string length to es
	mov bx, di                ;put first string in bx
	call strlen               ;calculate first string length
	
	cmp dx, cx                ;compare lengths
	jne notequal              ;check if not equal
	mov cx, 0                 ;if equal return 0
	pop di                    ;restore registers from stack
	pop si
	pop dx
	pop bx
	ret
	
	notequal:
		mov cx, -1        ;if not equal return -1
		pop di            ;restore registers from stack
		pop si
		pop es
		pop bx
		ret
	
	
	
