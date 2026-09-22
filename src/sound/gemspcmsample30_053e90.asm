; $053E90..$054CD3 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$53E90
        fail "ROM start moved"
        endif

GemsPcmSample30 equ $053E90

        incbin "generated/data/053e90.bin"
        ifne *-$54CD4
        fail "ROM end moved"
        endif
