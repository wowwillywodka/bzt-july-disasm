; $01EA48..$01EADB | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1EA48
        fail "ROM start moved"
        endif

ActorRemoteUpdateHandlers equ $01EA48

        incbin "generated/data/01ea48.bin"
        ifne *-$1EADC
        fail "ROM end moved"
        endif
