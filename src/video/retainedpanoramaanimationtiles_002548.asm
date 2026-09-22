; $002548..$00256B | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2548
        fail "ROM start moved"
        endif

RetainedPanoramaAnimationTiles equ $002548

        incbin "generated/data/002548.bin"
        ifne *-$256C
        fail "ROM end moved"
        endif
