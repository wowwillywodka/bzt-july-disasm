; $01FB28..$01FC27 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1FB28
        fail "ROM start moved"
        endif

ActorAnimationPhaseLookup equ $01FB28

        incbin "generated/data/01fb28.bin"
        ifne *-$1FC28
        fail "ROM end moved"
        endif
