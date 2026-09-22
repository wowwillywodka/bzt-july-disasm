; $0006E0..$000717 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$6E0
        fail "ROM start moved"
        endif

LegacyBootHardwareParameters equ $0006E0

        incbin "generated/data/0006e0.bin"
        ifne *-$718
        fail "ROM end moved"
        endif
