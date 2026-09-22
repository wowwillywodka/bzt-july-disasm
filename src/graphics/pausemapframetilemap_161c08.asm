; $161C08..$1624C7 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$161C08
        fail "ROM start moved"
        endif

PauseMapFrameTilemap equ $161C08

        incbin "generated/data/161c08.bin"
        ifne *-$1624C8
        fail "ROM end moved"
        endif
