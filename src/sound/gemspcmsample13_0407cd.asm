; $0407CD..$0453FE | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$407CD
        fail "ROM start moved"
        endif

GemsPcmSample13 equ $0407CD

        incbin "generated/data/0407cd.bin"
        ifne *-$453FF
        fail "ROM end moved"
        endif
