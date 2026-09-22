; $062881..$0639BE | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$62881
        fail "ROM start moved"
        endif

GemsPcmSample48 equ $062881

        incbin "generated/data/062881.bin"
        ifne *-$639BF
        fail "ROM end moved"
        endif
