;;kernel.asm
bits 32							;gen code for 32.bit mode
section .text

global start
extern kmain

start:
	cli							;clear-interrupts
	mov esp, stack_space		;set stack pointer
	call kmain
	hlt							;halt the CPU

section .bss
resb 8192						;8KB for stack
stack_space:
