; $088406..$08848D | episode-header
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$88406
        fail "ROM start moved"
        endif

Episode2Header equ $088406

        incbin "generated/data/088406.bin"
        ifne *-$8848E
        fail "ROM end moved"
        endif
