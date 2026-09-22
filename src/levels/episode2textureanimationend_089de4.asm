; $089DE4..$089DE5 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$89DE4
        fail "ROM start moved"
        endif

Episode2TextureAnimationEnd equ $089DE4

        incbin "generated/data/089de4.bin"
        ifne *-$89DE6
        fail "ROM end moved"
        endif
