; $055FFF..$056E13 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$55FFF
        fail "ROM start moved"
        endif

GemsPcmSample33 equ $055FFF

        incbin "generated/data/055fff.bin"
        ifne *-$56E14
        fail "ROM end moved"
        endif
