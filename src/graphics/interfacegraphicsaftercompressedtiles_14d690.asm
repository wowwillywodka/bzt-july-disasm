; $14D690..$15D457 | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$14D690
        fail "ROM start moved"
        endif

InterfaceGraphicsBank equ $14D690
KirstenHolstedGameplayPortraitTiles equ $14D690
KirstenHolstedGameplayPortraitTilemap equ $14EB70
ChrisOlsenGameplayPortraitTiles equ $14ECF0
ChrisOlsenGameplayPortraitTilemap equ $1501F0
VictorReisenGameplayPortraitTiles equ $150370
VictorReisenGameplayPortraitTilemap equ $151870
ErichHerselGameplayPortraitTiles equ $1519F0
ErichHerselGameplayPortraitTilemap equ $152EF0
VernerRombergGameplayPortraitTiles equ $153070
VernerRombergGameplayPortraitTilemap equ $154550
KirstenHolstedMenuPortraitTiles equ $1546D0
KirstenHolstedMenuPortraitTilemap equ $155B90
ChrisOlsenMenuPortraitTiles equ $155D10
ChrisOlsenMenuPortraitTilemap equ $1571D0
VictorReisenMenuPortraitTiles equ $157350
VictorReisenMenuPortraitTilemap equ $158830
ErichHerselMenuPortraitTiles equ $1589B0
ErichHerselMenuPortraitTilemap equ $159E90
VernerRombergMenuPortraitTiles equ $15A010
VernerRombergMenuPortraitTilemap equ $15B4D0
RetainedPauseMapBackdrop equ $15B650
RetainedPauseMapBackdropTilemap equ $15B658
RetainedPauseMapBackdropTiles equ $15BF18
PauseMapCellTilePattern00 equ $15CA58
PauseMapCellTilePattern01 equ $15CA5A
PauseMapCellTilePattern02 equ $15CA68
PauseMapCellTilePattern03 equ $15CA6A
PauseMapCellTilePattern04 equ $15CA78
PauseMapCellTilePattern05 equ $15CA7A
PauseMapCellTilePattern06 equ $15CA88
PauseMapCellTilePattern07 equ $15CA8A
RetainedPauseMapTailTiles equ $15CA98
PasswordEntryExtraTile equ $15CCB8
InventoryStatusTiles equ $15CCD8
RetainedPanoramaAnimationTiles0 equ $15D158
RetainedPanoramaAnimationTiles1 equ $15D258
RetainedPanoramaAnimationTiles2 equ $15D358

        incbin "generated/data/14d690.bin"
        ifne *-$15D458
        fail "ROM end moved"
        endif
