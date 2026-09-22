; $036FC9..$037CD8 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$36FC9
        fail "ROM start moved"
        endif

GemsPcmSample08 equ $036FC9

        incbin "generated/data/036fc9.bin"
        ifne *-$37CD9
        fail "ROM end moved"
        endif
