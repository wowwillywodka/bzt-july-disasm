; $022FE4..$023063 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$22FE4
        fail "ROM start moved"
        endif

TitleStaticSpriteMappings equ $022FE4

        incbin "generated/data/022fe4.bin"
        ifne *-$23064
        fail "ROM end moved"
        endif
