; $093890..$093911 | texture-animation
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$93890
        fail "ROM start moved"
        endif

Episode4TextureAnimation08 equ $093890

        incbin "generated/data/093890.bin"
        ifne *-$93912
        fail "ROM end moved"
        endif
