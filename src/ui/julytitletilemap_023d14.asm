; $023D14..$0245D3 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$23D14
        fail "ROM start moved"
        endif

JulyTitleTilemap equ $023D14

        incbin "generated/data/023d14.bin"
        ifne *-$245D4
        fail "ROM end moved"
        endif
