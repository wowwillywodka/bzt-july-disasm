; $093912..$0939C7 | texture-animation
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$93912
        fail "ROM start moved"
        endif

Episode4TextureAnimation09 equ $093912

        incbin "generated/data/093912.bin"
        ifne *-$939C8
        fail "ROM end moved"
        endif
