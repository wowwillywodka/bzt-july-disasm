; $052FEE..$053E8F | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$52FEE
        fail "ROM start moved"
        endif

GemsPcmSample29 equ $052FEE

        incbin "generated/data/052fee.bin"
        ifne *-$53E90
        fail "ROM end moved"
        endif
