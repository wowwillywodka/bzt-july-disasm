; $164148..$16481F | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$164148
        fail "ROM start moved"
        endif

InventoryQuantityDigitRows equ $164148
InventoryQuantityDigitPaddingTile equ $1641C0
HealthNumberMaskTiles equ $1641E0
GameplayHudGlyphTiles equ $164320

        incbin "generated/data/164148.bin"
        ifne *-$164820
        fail "ROM end moved"
        endif
