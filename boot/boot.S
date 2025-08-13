;
; Neural OS - Boot Loader
; Copyright (c) 2025 Miguel Mamani <miguel.coder.per@gmail.com>
; 
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
; 
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
; GNU General Public License for more details.
; 
; You should have received a copy of the GNU General Public License
; along with this program. If not, see <https://www.gnu.org/licenses/>.
;

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
