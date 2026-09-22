; $07ACD4..$07ACE3 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7ACD4
        fail "ROM start moved"
        endif

SoundChannelConfiguration equ $07ACD4

        incbin "generated/data/07acd4.bin"
        ifne *-$7ACE4
        fail "ROM end moved"
        endif
