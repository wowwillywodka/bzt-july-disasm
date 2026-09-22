; $0286E4..$0286EB | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$286E4
        fail "ROM start moved"
        endif

RetainedScreenEffectBaseColors equ $0286E4

        incbin "generated/data/0286e4.bin"
        ifne *-$286EC
        fail "ROM end moved"
        endif
