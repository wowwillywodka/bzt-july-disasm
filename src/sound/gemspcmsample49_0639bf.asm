; $0639BF..$064817 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$639BF
        fail "ROM start moved"
        endif

GemsPcmSample49 equ $0639BF

        incbin "generated/data/0639bf.bin"
        ifne *-$64818
        fail "ROM end moved"
        endif
