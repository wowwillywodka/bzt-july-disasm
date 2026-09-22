; $010FEA..$0113E9 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$10FEA
        fail "ROM start moved"
        endif

SpriteColumnSourceSteps equ $010FEA

        incbin "generated/data/010fea.bin"
        ifne *-$113EA
        fail "ROM end moved"
        endif
