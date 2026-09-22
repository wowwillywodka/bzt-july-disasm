; $1FFAB0..$2214AF | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1FFAB0
        fail "ROM start moved"
        endif

BeatressSpriteBank_Tiles equ $1FFAB0

        incbin "generated/data/1ffab0.bin"
        ifne *-$2214B0
        fail "ROM end moved"
        endif
