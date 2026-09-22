; $002864..$0028A3 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2864
        fail "ROM start moved"
        endif

RetainedEffectSpriteMappings equ $002864

        incbin "generated/data/002864.bin"
        ifne *-$28A4
        fail "ROM end moved"
        endif
