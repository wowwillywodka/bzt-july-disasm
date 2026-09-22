; $0935DA..$09365B | texture-animation
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$935DA
        fail "ROM start moved"
        endif

Episode4TextureAnimation03 equ $0935DA

        incbin "generated/data/0935da.bin"
        ifne *-$9365C
        fail "ROM end moved"
        endif
