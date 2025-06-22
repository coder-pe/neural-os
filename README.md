# Neural OS (MVP)

A minimal educational operating system written in **C** that demonstrates fundamental OS concepts and embeds a tiny AI demo.

## Features

* Multiboot‑compatible kernel loaded by GRUB
* VGA text console output
* Tiny AI perceptron (logical OR) running inside the kernel
* Modular code layout (`boot`, `kernel`, `ai`)
* Ready to build and run with **QEMU**

## Prerequisites

```bash
sudo apt install build-essential grub-pc-bin xorriso qemu-system-i386 nasm
```
You will also need an **i686‑elf cross‑compiler** (`i686-elf-gcc`, `i686-elf-ld`).  
Follow any standard OSDev guide to build or install these tools and make sure they are in your `$PATH`.

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
│   └── boot.S
├── kernel
│   └── kernel.c
└── ai
    └── ai.c
```

Feel free to extend this MVP with memory management, a scheduler, drivers, and richer AI modules as you keep learning.
