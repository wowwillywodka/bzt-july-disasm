; $000718..$00073F | z80:boot_legacy
; Maintained assembly input; no extraction occurs during build.
        ifne *-$718
        fail "ROM start moved"
        endif

Z80BootLegacy:
        incbin "build/boot_legacy.bin"
        ifne *-$740
        fail "ROM end moved"
        endif
