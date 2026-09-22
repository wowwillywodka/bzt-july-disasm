; $1E26AA..$1FECA9 | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1E26AA
        fail "ROM start moved"
        endif

GreenDummySpriteBank_Tiles equ $1E26AA

        incbin "generated/data/1e26aa.bin"
        ifne *-$1FECAA
        fail "ROM end moved"
        endif
