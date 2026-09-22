; $01C222..$01C2ED | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1C222
        fail "ROM start moved"
        endif

ActorLinkStateHandlers equ $01C222

        incbin "generated/data/01c222.bin"
        ifne *-$1C2EE
        fail "ROM end moved"
        endif
