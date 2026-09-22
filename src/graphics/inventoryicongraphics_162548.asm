; $162548..$164147 | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$162548
        fail "ROM start moved"
        endif

InventoryIconGraphics equ $162548
Data_162748 equ $162748
Data_162948 equ $162948
Data_162B48 equ $162B48
Data_162D48 equ $162D48
Data_162F48 equ $162F48
Data_163148 equ $163148
Data_163348 equ $163348
Data_163548 equ $163548
Data_163748 equ $163748
Data_163948 equ $163948
Data_163B48 equ $163B48
Data_163D48 equ $163D48
Data_163F48 equ $163F48

        incbin "generated/data/162548.bin"
        ifne *-$164148
        fail "ROM end moved"
        endif
