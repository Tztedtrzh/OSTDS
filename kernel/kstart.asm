; kstart.asm - An updated bootloader stub for an x86_64 kernel.

; --- Multiboot Header (No changes needed here) ---
section .multiboot
header_start:
    dd 0x1BADB002
    dd 0x00000003
    dd 0xE4524FFB
header_end:

; --- BSS Section ---
section .bss
stack_bottom:
    resb 16384 ; 16KB stack
stack_top:

; --- Text Section ---
section .text
global _start
extern kmain

_start:
    ; Set up the stack pointer.
    mov rsp, stack_top

    ; GRUB passes the Multiboot info pointer in RBX.
    ; The x86_64 System V ABI specifies that the first argument
    ; to a function is passed in the RDI register.
    ; So, we move the pointer from RBX to RDI before calling kmain.
    mov rdi, rbx

    ; Call our C kernel's main function.
    call kmain

    ; Halt the CPU if kmain returns.
hang:
    cli
    hlt
    jmp hang

