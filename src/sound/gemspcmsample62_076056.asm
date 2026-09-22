; $076056..$0773A4 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$76056
        fail "ROM start moved"
        endif

GemsPcmSample62 equ $076056

        incbin "generated/data/076056.bin"
        ifne *-$773A5
        fail "ROM end moved"
        endif
