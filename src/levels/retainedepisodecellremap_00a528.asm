; $00A528..$00A627 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$A528
        fail "ROM start moved"
        endif

RetainedEpisodeCellRemap equ $00A528

        incbin "generated/data/00a528.bin"
        ifne *-$A628
        fail "ROM end moved"
        endif
