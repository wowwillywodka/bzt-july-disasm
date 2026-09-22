; $01EDAE..$01EDB3 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1EDAE
        fail "ROM start moved"
        endif

ActorRemoteFacingRemap equ $01EDAE

        incbin "generated/data/01edae.bin"
        ifne *-$1EDB4
        fail "ROM end moved"
        endif
