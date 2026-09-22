; $039D6E..$03B2AF | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$39D6E
        fail "ROM start moved"
        endif

GemsPcmSample11 equ $039D6E

        incbin "generated/data/039d6e.bin"
        ifne *-$3B2B0
        fail "ROM end moved"
        endif
