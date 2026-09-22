; $08F052..$08F053 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8F052
        fail "ROM start moved"
        endif

Episode3TextureAnimationEnd equ $08F052

        incbin "generated/data/08f052.bin"
        ifne *-$8F054
        fail "ROM end moved"
        endif
