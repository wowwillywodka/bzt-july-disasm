; $091A3E..$091AB7 | actor-markers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$91A3E
        fail "ROM start moved"
        endif

Episode3ActorMarkers equ $091A3E

        incbin "generated/data/091a3e.bin"
        ifne *-$91AB8
        fail "ROM end moved"
        endif
