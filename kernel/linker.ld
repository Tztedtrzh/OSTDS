/*
 * linker.ld - A linker script for a simple x86_64 kernel.
 */

/* Define the entry point of the kernel. This must match the symbol in your assembly file. */
ENTRY(_start)

/* Define where the sections should be loaded in memory. */
/* 0x100000 (1MB) is a common starting address for kernels to avoid low memory areas. */
SECTIONS
{
    . = 1M; /* The '.' symbol represents the current location counter. */

    /* Place the .multiboot section first. It's critical that this is at the beginning. */
    .multiboot :
    {
        /* The '*' is a wildcard that matches all input object files. */
        /* We're telling the linker to put the .multiboot section from all object files here. */
        *(.multiboot)
    }

    /* Place the executable code (.text section) after the multiboot header. */
    /* We align this section to a 4K page boundary, which is good practice. */
    .text ALIGN(4K) :
    {
        *(.text)
    }

    /* Place read-only data (.rodata section) after the code. */
    .rodata ALIGN(4K) :
    {
        *(.rodata)
    }

    /* Place initialized data (.data section) after the read-only data. */
    .data ALIGN(4K) :
    {
        *(.data)
    }

    /* Place uninitialized data (.bss section) after the initialized data. */
    /* This section holds variables that are zero-initialized. */
    .bss ALIGN(4K) :
    {
        *(COMMON)
        *(.bss)
    }
}

