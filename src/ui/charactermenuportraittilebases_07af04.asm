; $07AF04..$07AF0D | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7AF04
        fail "ROM start moved"
        endif

CharacterMenuPortraitTileBases equ $07AF04
Data_07AF06 equ $07AF06
Data_07AF08 equ $07AF08
Data_07AF0A equ $07AF0A
Data_07AF0C equ $07AF0C

        incbin "generated/data/07af04.bin"
        ifne *-$7AF0E
        fail "ROM end moved"
        endif
