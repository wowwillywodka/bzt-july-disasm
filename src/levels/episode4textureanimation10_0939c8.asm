; $0939C8..$093AB1 | texture-animation
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$939C8
        fail "ROM start moved"
        endif

Episode4TextureAnimation10 equ $0939C8

        incbin "generated/data/0939c8.bin"
        ifne *-$93AB2
        fail "ROM end moved"
        endif
