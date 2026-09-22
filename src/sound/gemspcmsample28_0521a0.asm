; $0521A0..$052FED | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$521A0
        fail "ROM start moved"
        endif

GemsPcmSample28 equ $0521A0

        incbin "generated/data/0521a0.bin"
        ifne *-$52FEE
        fail "ROM end moved"
        endif
