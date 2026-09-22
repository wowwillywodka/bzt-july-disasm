; $009B8E..$009BC5 | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9B8E
        fail "ROM start moved"
        endif

ActorSpawnDefinitionPointers equ $009B8E

        incbin "generated/data/009b8e.bin"
        ifne *-$9BC6
        fail "ROM end moved"
        endif
