; $001B94..$001BAF | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1B94
        fail "ROM start moved"
        endif

WaitingForPartnerSceneText equ $001B94

        incbin "generated/data/001b94.bin"
        ifne *-$1BB0
        fail "ROM end moved"
        endif
