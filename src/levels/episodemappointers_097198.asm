; $097198..$0971A7 | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$97198
        fail "ROM start moved"
        endif

EpisodeMapPointers equ $097198

        incbin "generated/data/097198.bin"
        ifne *-$971A8
        fail "ROM end moved"
        endif
