;;kernel.asm
bits 32							;gen code for 32.bit mode
section .text
		;multiboot spec
		align 4
		dd 0x1BADB002			;magic
		dd 0x00					;flags
		dd - (0x1BADB002 + 0x00);checksum. m+f+c should be zero

global start
global keyboard_handler
global read_port
global write_port
global load_idt


extern kmain					;those are defined in the .c file
extern keyboard_handler_main

read_port:
	mov edx, [esp + 4]			;port number
	in al, dx
	ret

write_port:
	mov edx, [esp + 4]			;port number
	mov al, [esp + 4 + 4]		;data to write
	out dx, al
	ret

load_idt:
	mov edx, [esp + 4]
	lidt [edx]					;Load to IDT
	sti							;turn interrupts on
	ret

keyboard_handler:
	call keyboard_handler_main
	iretd						;return from interrupt

start:
	cli							;clear-interrupts
	mov esp, stack_space		;set stack pointer
	call kmain
	hlt							;halt the CPU

section .bss
resb 8192						;8KB for stack
stack_space:
