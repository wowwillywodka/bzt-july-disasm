; $037CD9..$038ED5 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$37CD9
        fail "ROM start moved"
        endif

GemsPcmSample09 equ $037CD9

        incbin "generated/data/037cd9.bin"
        ifne *-$38ED6
        fail "ROM end moved"
        endif
