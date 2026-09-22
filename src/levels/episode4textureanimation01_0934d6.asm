; $0934D6..$093557 | texture-animation
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$934D6
        fail "ROM start moved"
        endif

Episode4TextureAnimation01 equ $0934D6

        incbin "generated/data/0934d6.bin"
        ifne *-$93558
        fail "ROM end moved"
        endif
