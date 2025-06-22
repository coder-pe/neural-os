# Neural OS (MVP)

A minimal educational operating system written in **C** that demonstrates fundamental OS concepts and embeds a tiny AI demo.

## Prerequisitos (dependencias necesarias)

```bash
sudo apt install build-essential nasm xorriso grub-pc-bin qemu-system-i386 mtools
sudo apt install build-essential bison flex libgmp3-dev libmpc-dev libmpfr-dev texinfo
sudo apt install mtools xorriso grub-pc-bin
```
**Nota:** También necesitas un compilador cruzado `i686-elf-gcc` y `i686-elf-ld`.  
Puedes compilarlo tú mismo o instalarlo desde un paquete confiable.  
Una guía para compilarlo está disponible en https://wiki.osdev.org/GCC_Cross-Compiler

## Building

```bash
make
```

This creates `NeuralOS.iso`.

## Running

```bash
make run
```

or explicitly

```bash
qemu-system-i386 -cdrom NeuralOS.iso
```

You should see the perceptron evaluating the OR truth table on the screen.

## Directory layout

```
.
├── Makefile
├── linker.ld
├── boot
│   └── boot.S
├── kernel
│   └── kernel.c
└── ai
    └── ai.c
```

Feel free to extend this MVP with memory management, a scheduler, drivers, and richer AI modules as you keep learning.