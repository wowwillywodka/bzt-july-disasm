; $083CB0..$083D37 | episode-header
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$83CB0
        fail "ROM start moved"
        endif

Episode1Header equ $083CB0

        incbin "generated/data/083cb0.bin"
        ifne *-$83D38
        fail "ROM end moved"
        endif
