; $023064..$0230D3 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$23064
        fail "ROM start moved"
        endif

TitleAnimatedSpriteMappings equ $023064

        incbin "generated/data/023064.bin"
        ifne *-$230D4
        fail "ROM end moved"
        endif
