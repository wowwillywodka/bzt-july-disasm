; $089DA2..$089DE3 | texture-animation
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$89DA2
        fail "ROM start moved"
        endif

Episode2TextureAnimation00 equ $089DA2

        incbin "generated/data/089da2.bin"
        ifne *-$89DE4
        fail "ROM end moved"
        endif
