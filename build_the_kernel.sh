#!/usr/bin/bash

# run the assembler to create the object file kasm.o in ELF-32 bit format
nasm -f elf32 kernel.asm -o kasm.o

# Compile the kernel.c, but dont link
gcc -fno-stack-protector -nostdlib -m32 -c kernel.c -o kc.o

# run the linker with our linker script
ld -m elf_i386 -T link.ld -o kernel kasm.o kc.o
