; $023336..$023735 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$23336
        fail "ROM start moved"
        endif

TitleAnimationCurves equ $023336

        incbin "generated/data/023336.bin"
        ifne *-$23736
        fail "ROM end moved"
        endif
