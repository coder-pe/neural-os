#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

extern void ai_demo();

static uint16_t* const VGA_BUFFER = (uint16_t*)0xB8000;
static const size_t VGA_WIDTH = 80;
static const size_t VGA_HEIGHT = 25;
static size_t terminal_row = 0;
static size_t terminal_column = 0;
static uint8_t terminal_color = 0x0F; // white on black

static void terminal_putentryat(char c, uint8_t color, size_t x, size_t y) {
    const size_t index = y * VGA_WIDTH + x;
    VGA_BUFFER[index] = ((uint16_t)color << 8) | (uint16_t)c;
}

static void terminal_putchar(char c);

void terminal_write(const char* str) {
    for (size_t i = 0; str[i] != '\0'; i++) {
        terminal_putchar(str[i]);
    }
}

static void terminal_putchar(char c) {
    if (c == '\n') {
        terminal_column = 0;
        if (++terminal_row == VGA_HEIGHT) {
            terminal_row = 0;
        }
        return;
    }
    terminal_putentryat(c, terminal_color, terminal_column, terminal_row);
    if (++terminal_column == VGA_WIDTH) {
        terminal_column = 0;
        if (++terminal_row == VGA_HEIGHT) {
            terminal_row = 0;
        }
    }
}

void kernel_main(void) {
    terminal_write("Neural OS kernel booting...\\n");
    ai_demo();
    terminal_write("\\nSystem halted.");
    for (;;) { __asm__ __volatile__("hlt"); }
}
