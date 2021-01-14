use16
org 100h

mov bl, 0x33
attempt:
	mov dx, attempts
	mov ah, 0x9
	int 0x21
	
	xor dx, dx
	mov dl, bl
	mov ah, 0x2
	int 0x21
	
	xor dx, dx
	xor ax, ax
	
	call print_enter
	
	mov dx, len_of_input_with_1
	mov ah, 0x0A
	int 0x21

	mov di, input
	mov si, password

	mov cx, 6
	repe cmpsb 
	jnz _incorrect
	jmp _correct

_incorrect:
	dec bl
	cmp bl, 0x30
	jne attempt
	mov dx, response_error
	mov ah, 0x9
	int 0x21

	call print_enter

	mov ah, 0x4C
	xor dx, dx
	int 0x21

_correct:
	mov dx, response_correct
	mov ah, 0x9
	int 0x21
	mov ah, 0x4C
	xor dx, dx
	int 0x21

print_enter:
	push dx
	mov ah,0x9
	mov dx, enter_str
	int 0x21
	pop dx
	
	ret

len_of_input_with_1 db 7, 0
input db 0x07, 0x00, '0000000', '$'
password db '19U061', '$'
response_error db 0xa, 0xd, 'Error: Exceeded the limit of attempts', '$'
response_correct db 0xa, 0xd, 'Password is correct', '$'
enter_str db 0xa, 0xd, '$'
attempts db 0xa, 0xd, 'Enter the password your attempts is limited. Attempts: ', '$'
