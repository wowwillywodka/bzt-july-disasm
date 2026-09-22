; $01DFB6..$01DFBB | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1DFB6
        fail "ROM start moved"
        endif

ActorLocalFacingRemap equ $01DFB6

        incbin "generated/data/01dfb6.bin"
        ifne *-$1DFBC
        fail "ROM end moved"
        endif
