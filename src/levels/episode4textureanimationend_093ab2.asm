; $093AB2..$093AB3 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$93AB2
        fail "ROM start moved"
        endif

Episode4TextureAnimationEnd equ $093AB2

        incbin "generated/data/093ab2.bin"
        ifne *-$93AB4
        fail "ROM end moved"
        endif
