; $028BD2..$0290DB | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$28BD2
        fail "ROM start moved"
        endif

RetainedFloorSecurityStrings equ $028BD2

        incbin "generated/data/028bd2.bin"
        ifne *-$290DC
        fail "ROM end moved"
        endif
