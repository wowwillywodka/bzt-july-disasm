; $07B336..$07B38F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Character-selection UI helper (five portraits/biographies), not a geometry-episode selector. See docs/GAME_FLOW.md.
        ifne *-$7B336
        fail "ROM start moved"
        endif

ScrollCharacterMenuUp:
; Character-selection UI helper (five portraits/biographies), not a geometry-episode selector. See docs/GAME_FLOW.md.
        jsr          UploadCharacterPreview.l                      ; $07B336
        jsr          DrawCharacterDescription.l                    ; $07B33C
        move.w       ramSelectedCharacter.l, d0                    ; $07B342
        lea.l        ramCharacterAvailable0.l, a0                  ; $07B348
        cmpi.b       #$1, (a0, d0.w)                               ; $07B34E
        beq.w        loc_07B35E                                    ; $07B354
        jsr          UploadCharacterMenuPanel.l                    ; $07B358

loc_07B35E:
        move.w       #$1f, d7                                      ; $07B35E

loc_07B362:
        jsr          WaitForVBlank.l                               ; $07B362
        subq.w       #$8, $ff2a4e.l                                ; $07B368
        move.w       $ff2a4e.l, d0                                 ; $07B36E
        jsr          WriteScreenTile.l                             ; $07B374
        jsr          VideoRoutine_021E4A.l                         ; $07B37A
        jsr          DrawCharacterMenuIcons(pc)                    ; $07B380
        dbra         d7, loc_07B362                                ; $07B384
        jsr          VideoRoutine_07B4FE.l                         ; $07B388
        rts                                                        ; $07B38E
        ifne *-$7B390
        fail "ROM end moved"
        endif
