; $08838C..$088405 | actor-markers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8838C
        fail "ROM start moved"
        endif

Episode1ActorMarkers equ $08838C

        incbin "generated/data/08838c.bin"
        ifne *-$88406
        fail "ROM end moved"
        endif
