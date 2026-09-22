; $038ED6..$039D6D | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$38ED6
        fail "ROM start moved"
        endif

GemsPcmSample10 equ $038ED6

        incbin "generated/data/038ed6.bin"
        ifne *-$39D6E
        fail "ROM end moved"
        endif
