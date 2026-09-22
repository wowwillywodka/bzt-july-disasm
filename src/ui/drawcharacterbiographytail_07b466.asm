; $07B466..$07B49D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Character-selection UI helper (five portraits/biographies), not a geometry-episode selector. See docs/GAME_FLOW.md.
        ifne *-$7B466
        fail "ROM start moved"
        endif

DrawCharacterBiographyTail:
; Character-selection UI helper (five portraits/biographies), not a geometry-episode selector. See docs/GAME_FLOW.md.
        move.w       ramSelectedCharacter.l, d0                    ; $07B466
        mulu.w       #$13e, d0                                     ; $07B46C
        lea.l        CharacterBiographyStrings.l, a0               ; $07B470
        adda.l       d0, a0                                        ; $07B476
        adda.l       #$11b, a0                                     ; $07B478
        cmpi.w       #$e102, $ff2a4c.l                             ; $07B47E
        beq.w        loc_07B492                                    ; $07B486
        move.w       #$fb82, d0                                    ; $07B48A
        bra.w        loc_07B496                                    ; $07B48E

loc_07B492:
        move.w       #$eb82, d0                                    ; $07B492

loc_07B496:
        jsr          PrintCharacterMenuText.l                      ; $07B496
        rts                                                        ; $07B49C
        ifne *-$7B49E
        fail "ROM end moved"
        endif
