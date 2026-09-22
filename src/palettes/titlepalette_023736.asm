; $023736..$023755 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$23736
        fail "ROM start moved"
        endif

TitlePalette equ $023736

        incbin "generated/data/023736.bin"
        ifne *-$23756
        fail "ROM end moved"
        endif
