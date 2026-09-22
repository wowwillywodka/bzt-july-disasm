; $09711E..$097197 | actor-markers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9711E
        fail "ROM start moved"
        endif

Episode4ActorMarkers equ $09711E

        incbin "generated/data/09711e.bin"
        ifne *-$97198
        fail "ROM end moved"
        endif
