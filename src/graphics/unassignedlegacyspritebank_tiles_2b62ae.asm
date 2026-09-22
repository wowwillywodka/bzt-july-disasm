; $2B62AE..$2B92AD | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2B62AE
        fail "ROM start moved"
        endif

UnassignedLegacySpriteBank_Tiles equ $2B62AE

        incbin "generated/data/2b62ae.bin"
        ifne *-$2B92AE
        fail "ROM end moved"
        endif
