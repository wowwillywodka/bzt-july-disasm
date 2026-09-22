; $049532..$04A39F | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$49532
        fail "ROM start moved"
        endif

GemsPcmSample18 equ $049532

        incbin "generated/data/049532.bin"
        ifne *-$4A3A0
        fail "ROM end moved"
        endif
