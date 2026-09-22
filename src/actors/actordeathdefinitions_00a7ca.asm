; $00A7CA..$00A8E7 | actor:26
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$A7CA
        fail "ROM start moved"
        endif

ActorDeathDefinitions equ $00A7CA

        incbin "generated/data/00a7ca.bin"
        ifne *-$A8E8
        fail "ROM end moved"
        endif
