; $0286EC..$02872F | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$286EC
        fail "ROM start moved"
        endif

RetainedScreenEffectColorCycle equ $0286EC

        incbin "generated/data/0286ec.bin"
        ifne *-$28730
        fail "ROM end moved"
        endif
