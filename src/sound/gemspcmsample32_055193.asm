; $055193..$055FFE | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$55193
        fail "ROM start moved"
        endif

GemsPcmSample32 equ $055193

        incbin "generated/data/055193.bin"
        ifne *-$55FFF
        fail "ROM end moved"
        endif
