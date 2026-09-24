; $07B0DA..$07B215 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Character-selection UI helper (five portraits/biographies), not a geometry-episode selector. See docs/GAME_FLOW.md.
        ifne *-$7B0DA
        fail "ROM start moved"
        endif

DrawCharacterSelectionScreen:
; Character-selection UI helper (five portraits/biographies), not a geometry-episode selector. See docs/GAME_FLOW.md.
        lea.l        CharacterMenuPortraitPalette.l, a0            ; $07B0DA
        lea.l        $ff0778.l, a1                                 ; $07B0E0
        jsr          CopyOneTile.l                                 ; $07B0E6
        lea.l        CharacterMenuSpritePalette.l, a0          ; $07B0EC
        jsr          CopyOneTile.l                                 ; $07B0F2
        lea.l        DeceasedStampPalette.l, a0              ; $07B0F8
        jsr          CopyOneTile.l                                 ; $07B0FE
        lea.l        CharacterMenuTextPalette.l, a0                ; $07B104
        jsr          CopyOneTile.l                                 ; $07B10A
        lea.l        KirstenHolstedMenuPortraitTiles.l, a0                             ; $07B110
        move.w       CharacterMenuPortraitTileBases(pc), d0        ; $07B116
        move.w       #$ac, d1                                      ; $07B11A
        jsr          UploadTiles.l                                 ; $07B11E
        lea.l        ChrisOlsenMenuPortraitTiles.l, a0                             ; $07B124
        move.w       Data_07AF06(pc), d0                           ; $07B12A
        move.w       #$ac, d1                                      ; $07B12E
        jsr          UploadTiles.l                                 ; $07B132
        lea.l        VictorReisenMenuPortraitTiles.l, a0                             ; $07B138
        move.w       Data_07AF08(pc), d0                           ; $07B13E
        move.w       #$ac, d1                                      ; $07B142
        jsr          UploadTiles.l                                 ; $07B146
        lea.l        ErichHerselMenuPortraitTiles.l, a0                             ; $07B14C
        move.w       Data_07AF0A(pc), d0                           ; $07B152
        move.w       #$ac, d1                                      ; $07B156
        jsr          UploadTiles.l                                 ; $07B15A
        lea.l        VernerRombergMenuPortraitTiles.l, a0                             ; $07B160
        move.w       Data_07AF0C(pc), d0                           ; $07B166
        move.w       #$ac, d1                                      ; $07B16A
        jsr          UploadTiles.l                                 ; $07B16E
        lea.l        CommonInterfaceCompressedTiles.l, a3          ; $07B174
        move.w       #$4b0, d0                                     ; $07B17A
        jsr          DecompressBytePairToVramLong.l                ; $07B17E
        move.l       #$74400001, VDP_CONTROL.l                     ; $07B184
        lea.l        DeceasedStampTiles.l, a0            ; $07B18E
        move.w       #$86f, d7                                     ; $07B194

loc_07B198:
        move.l       (a0)+, VDP_DATA.l                             ; $07B198
        dbra         d7, loc_07B198                                ; $07B19E
        lea.l        CharacterMenuSpriteTiles.l, a0                 ; $07B1A2
        lea.l        CharacterMenuArrowTileUploadIndices.l, a1                   ; $07B1A8
        move.w       #$546, d0                                     ; $07B1AE
        move.w       #$18, d1                                      ; $07B1B2
        move.w       #$20, d2                                      ; $07B1B6
        jsr          UploadTileRectangle.l                         ; $07B1BA
        lea.l        CharacterMenuSpriteTiles.l, a0                 ; $07B1C0
        lea.l        CharacterMenuPromptTileUploadIndices.l, a1               ; $07B1C6
        move.w       #$552, d0                                     ; $07B1CC
        move.w       #$20, d1                                      ; $07B1D0
        move.w       #$20, d2                                      ; $07B1D4
        jsr          UploadTileRectangle.l                         ; $07B1D8
        jsr          DrawCharacterMenuIcons.l                      ; $07B1DE
        move.w       #$0, d0                                       ; $07B1E4
        jsr          WriteVerticalScrollToVsram.l                         ; $07B1E8
        jsr          WriteScreenTile.l                             ; $07B1EE
        lea.l        Data_07BC1A.l, a0                             ; $07B1F4
        move.w       #$ee00, d0                                    ; $07B1FA
        jsr          PrintCharacterMenuText.l                      ; $07B1FE
        lea.l        Data_07BC1A.l, a0                             ; $07B204
        move.w       #$fe00, d0                                    ; $07B20A
        jsr          PrintCharacterMenuText.l                      ; $07B20E
        rts                                                        ; $07B214
        ifne *-$7B216
        fail "ROM end moved"
        endif
