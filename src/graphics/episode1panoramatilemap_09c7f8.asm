; $09C7F8..$09D7F7 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9C7F8
        fail "ROM start moved"
        endif

Episode1PanoramaTilemap equ $09C7F8

        incbin "generated/data/09c7f8.bin"
        ifne *-$9D7F8
        fail "ROM end moved"
        endif
