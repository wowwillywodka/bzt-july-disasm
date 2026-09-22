; $07B5E4..$07BC43 | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7B5E4
        fail "ROM start moved"
        endif

CharacterBiographyStrings equ $07B5E4
Data_07BC1A equ $07BC1A

        incbin "generated/data/07b5e4.bin"
        ifne *-$7BC44
        fail "ROM end moved"
        endif
