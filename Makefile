TARGET = i686-elf
CC = $(TARGET)-gcc
LD = $(TARGET)-ld
AS = nasm
CFLAGS = -std=gnu99 -ffreestanding -O2 -Wall -Wextra
LDFLAGS = -T linker.ld -nostdlib

ISO_DIR = iso
BUILD_DIR = build
KERNEL_ELF = $(BUILD_DIR)/kernel.elf
ISO = NeuralOS.iso

all: $(ISO)

$(BUILD_DIR):
\tmkdir -p $(BUILD_DIR)

$(KERNEL_ELF): $(BUILD_DIR) boot/boot.o kernel/kernel.o ai/ai.o
\t$(LD) $(LDFLAGS) -o $@ $^

boot/boot.o: boot/boot.S
\t$(AS) -f elf32 $< -o $@

kernel/kernel.o: kernel/kernel.c
\t$(CC) $(CFLAGS) -c $< -o $@

ai/ai.o: ai/ai.c
\t$(CC) $(CFLAGS) -c $< -o $@

$(ISO): $(KERNEL_ELF)
\tmkdir -p $(ISO_DIR)/boot/grub
\tcp $< $(ISO_DIR)/boot/kernel.elf
\techo 'set timeout=0' > $(ISO_DIR)/boot/grub/grub.cfg
\techo 'set default=0' >> $(ISO_DIR)/boot/grub/grub.cfg
\techo 'menuentry "Neural OS" { multiboot /boot/kernel.elf }' >> $(ISO_DIR)/boot/grub/grub.cfg
\tgrub-mkrescue -o $@ $(ISO_DIR)

run: $(ISO)
\tqemu-system-i386 -cdrom $(ISO)

clean:
\trm -rf $(BUILD_DIR) $(ISO_DIR) $(ISO)
