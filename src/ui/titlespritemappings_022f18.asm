; $022F18..$022F37 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$22F18
        fail "ROM start moved"
        endif

TitleSpriteMappings equ $022F18

        incbin "generated/data/022f18.bin"
        ifne *-$22F38
        fail "ROM end moved"
        endif
