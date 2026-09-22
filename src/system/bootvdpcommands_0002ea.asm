; $0002EA..$0002F9 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2EA
        fail "ROM start moved"
        endif

BootVdpCommands equ $0002EA

        incbin "generated/data/0002ea.bin"
        ifne *-$2FA
        fail "ROM end moved"
        endif
