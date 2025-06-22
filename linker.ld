ENTRY(multiboot_header)

SECTIONS
{
    . = 1M;
    .multiboot_header ALIGN(4K) : { *(.multiboot_header) }
    .text ALIGN(4K)             : { *(.text) }
    .rodata ALIGN(4K)           : { *(.rodata) }
    .data ALIGN(4K)             : { *(.data) }
    .bss ALIGN(4K)              : { *(.bss COMMON) }
}
