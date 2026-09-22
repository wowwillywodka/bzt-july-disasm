; $1244F8..$1254F7 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1244F8
        fail "ROM start moved"
        endif

Episode4PanoramaTilemap equ $1244F8

        incbin "generated/data/1244f8.bin"
        ifne *-$1254F8
        fail "ROM end moved"
        endif
