; $0024EA..$002547 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$24EA
        fail "ROM start moved"
        endif

RetainedPanoramaTileSequence equ $0024EA

        incbin "generated/data/0024ea.bin"
        ifne *-$2548
        fail "ROM end moved"
        endif
