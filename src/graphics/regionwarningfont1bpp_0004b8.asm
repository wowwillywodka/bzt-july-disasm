; $0004B8..$00068F | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$4B8
        fail "ROM start moved"
        endif

RegionWarningFont1Bpp equ $0004B8

        incbin "generated/data/0004b8.bin"
        ifne *-$690
        fail "ROM end moved"
        endif
