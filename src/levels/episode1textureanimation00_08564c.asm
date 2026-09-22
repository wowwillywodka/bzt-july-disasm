; $08564C..$085675 | texture-animation
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8564C
        fail "ROM start moved"
        endif

Episode1TextureAnimation00 equ $08564C

        incbin "generated/data/08564c.bin"
        ifne *-$85676
        fail "ROM end moved"
        endif
