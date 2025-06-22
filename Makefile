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
	mkdir -p $(BUILD_DIR)

$(KERNEL_ELF): boot/boot.o kernel/kernel.o ai/ai.o | $(BUILD_DIR)
	$(LD) $(LDFLAGS) -o $@ boot/boot.o kernel/kernel.o ai/ai.o

boot/boot.o: boot/boot.S
	$(AS) -f elf32 $< -o $@

kernel/kernel.o: kernel/kernel.c
	$(CC) $(CFLAGS) -c $< -o $@

ai/ai.o: ai/ai.c
	$(CC) $(CFLAGS) -c $< -o $@

$(ISO): $(KERNEL_ELF)
	mkdir -p $(ISO_DIR)/boot/grub
	cp $< $(ISO_DIR)/boot/kernel.elf
	echo 'set timeout=0' > $(ISO_DIR)/boot/grub/grub.cfg
	echo 'set default=0' >> $(ISO_DIR)/boot/grub/grub.cfg
	echo 'menuentry "Neural OS" { multiboot /boot/kernel.elf }' >> $(ISO_DIR)/boot/grub/grub.cfg
	grub-mkrescue -o $@ $(ISO_DIR)

run: $(ISO)
	qemu-system-i386 -cdrom $(ISO)

clean:
	rm -rf $(BUILD_DIR) $(ISO_DIR) $(ISO)
	rm -rf boot/boot.o ai/ai.o kernel/kernel.o

