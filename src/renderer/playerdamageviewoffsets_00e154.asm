; $00E154..$00E193 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$E154
        fail "ROM start moved"
        endif

PlayerDamageViewOffsets equ $00E154

        incbin "generated/data/00e154.bin"
        ifne *-$E194
        fail "ROM end moved"
        endif
