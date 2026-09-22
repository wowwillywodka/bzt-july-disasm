; $022FC6..$022FE3 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$22FC6
        fail "ROM start moved"
        endif

TitleScrollWordSequences equ $022FC6

        incbin "generated/data/022fc6.bin"
        ifne *-$22FE4
        fail "ROM end moved"
        endif
