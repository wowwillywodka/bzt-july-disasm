; $01EBB6..$01EBBB | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1EBB6
        fail "ROM start moved"
        endif

ActorRemoteDirectionRemap equ $01EBB6

        incbin "generated/data/01ebb6.bin"
        ifne *-$1EBBC
        fail "ROM end moved"
        endif
