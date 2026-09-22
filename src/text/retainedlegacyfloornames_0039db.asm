; $0039DB..$003C9B | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$39DB
        fail "ROM start moved"
        endif

RetainedLegacyFloorNames equ $0039DB

        incbin "generated/data/0039db.bin"
        ifne *-$3C9C
        fail "ROM end moved"
        endif
