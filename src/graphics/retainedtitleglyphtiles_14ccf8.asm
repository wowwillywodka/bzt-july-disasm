; $14CCF8..$14D037 | vdp-tiles
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$14CCF8
        fail "ROM start moved"
        endif

RetainedTitleGlyphTiles equ $14CCF8
RetainedTitleGlyphTile01 equ $14CD18
RetainedTitleGlyphTile02 equ $14CD38
RetainedTitleGlyphTile03 equ $14CD58
RetainedTitleGlyphTile04 equ $14CD78
RetainedTitleGlyphTile05 equ $14CD98
RetainedTitleGlyphTile06 equ $14CDB8
RetainedTitleGlyphTile07 equ $14CDD8
RetainedTitleGlyphTile08 equ $14CDF8
RetainedTitleGlyphTile09 equ $14CE18
RetainedTitleGlyphTile10 equ $14CE38
RetainedTitleGlyphTile11 equ $14CE58
RetainedTitleGlyphTile12 equ $14CE78
RetainedTitleGlyphTile13 equ $14CE98
RetainedTitleGlyphTile14 equ $14CEB8
RetainedTitleGlyphTile15 equ $14CED8
RetainedTitleGlyphTile16 equ $14CEF8
RetainedTitleGlyphTile17 equ $14CF18
RetainedTitleGlyphTile18 equ $14CF38
RetainedTitleGlyphTile19 equ $14CF58
RetainedTitleGlyphTile20 equ $14CF78
RetainedTitleGlyphTile21 equ $14CF98
RetainedTitleGlyphTile22 equ $14CFB8
RetainedTitleGlyphTile23 equ $14CFD8
RetainedTitleGlyphTile24 equ $14CFF8
RetainedTitleGlyphTile25 equ $14D018

        incbin "generated/data/14ccf8.bin"
        ifne *-$14D038
        fail "ROM end moved"
        endif
