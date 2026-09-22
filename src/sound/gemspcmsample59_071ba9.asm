; $071BA9..$073828 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$71BA9
        fail "ROM start moved"
        endif

GemsPcmSample59 equ $071BA9

        incbin "generated/data/071ba9.bin"
        ifne *-$73829
        fail "ROM end moved"
        endif
