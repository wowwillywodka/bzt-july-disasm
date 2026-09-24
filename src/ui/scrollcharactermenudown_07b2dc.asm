; $07B2DC..$07B335 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Character-selection UI helper (five portraits/biographies), not a geometry-episode selector. See docs/GAME_FLOW.md.
        ifne *-$7B2DC
        fail "ROM start moved"
        endif

ScrollCharacterMenuDown:
; Character-selection UI helper (five portraits/biographies), not a geometry-episode selector. See docs/GAME_FLOW.md.
        jsr          UploadCharacterPreview.l                      ; $07B2DC
        jsr          DrawCharacterDescription.l                    ; $07B2E2
        move.w       ramSelectedCharacter.l, d0                    ; $07B2E8
        lea.l        ramCharacterAvailable0.l, a0                  ; $07B2EE
        cmpi.b       #$1, (a0, d0.w)                               ; $07B2F4
        beq.w        loc_07B304                                    ; $07B2FA
        jsr          UploadDeceasedStamp.l                    ; $07B2FE

loc_07B304:
        move.w       #$1f, d7                                      ; $07B304

loc_07B308:
        jsr          WaitForVBlank.l                               ; $07B308
        addq.w       #$8, $ff2a4e.l                                ; $07B30E
        move.w       $ff2a4e.l, d0                                 ; $07B314
        jsr          WriteScreenTile.l                             ; $07B31A
        jsr          WriteVerticalScrollToVsram.l                         ; $07B320
        jsr          DrawCharacterMenuIcons(pc)                    ; $07B326
        dbra         d7, loc_07B308                                ; $07B32A
        jsr          ClearCharacterMenuTilemapRegion.l                         ; $07B32E
        rts                                                        ; $07B334
        ifne *-$7B336
        fail "ROM end moved"
        endif
