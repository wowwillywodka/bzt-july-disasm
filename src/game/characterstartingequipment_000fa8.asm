; $000FA8..$000FCF | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$FA8
        fail "ROM start moved"
        endif

CharacterStartingEquipment equ $000FA8

        incbin "generated/data/000fa8.bin"
        ifne *-$FD0
        fail "ROM end moved"
        endif
