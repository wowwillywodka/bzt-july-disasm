; $0002C4..$0002E9 | z80:boot_reset
; Maintained assembly input; no extraction occurs during build.
        ifne *-$2C4
        fail "ROM start moved"
        endif

Z80BootReset:
        incbin "build/boot_reset.bin"
        ifne *-$2EA
        fail "ROM end moved"
        endif
