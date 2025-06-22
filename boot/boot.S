; boot/boot.S
[bits 32]
[section .multiboot_header]
MULTIBOOT_MAGIC equ 0x1BADB002
MULTIBOOT_FLAGS equ 0
CHECKSUM equ -(MULTIBOOT_MAGIC + MULTIBOOT_FLAGS)

dd MULTIBOOT_MAGIC
dd MULTIBOOT_FLAGS
dd CHECKSUM

[global multiboot_header]
multiboot_header:

[section .text]
[global _start]
_start:
    extern kernel_main
    call kernel_main
.hang:
    jmp .hang
