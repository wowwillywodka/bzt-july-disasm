; $07B390..$07B3E1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Character-selection UI helper (five portraits/biographies), not a geometry-episode selector. See docs/GAME_FLOW.md.
        ifne *-$7B390
        fail "ROM start moved"
        endif

UploadCharacterPreview:
; Character-selection UI helper (five portraits/biographies), not a geometry-episode selector. See docs/GAME_FLOW.md.
        move.w       ramSelectedCharacter.l, d0                    ; $07B390
        lsl.w        #$2, d0                                       ; $07B396
        lea.l        CharacterMenuPortraitTilemapPointers(pc), a0  ; $07B398
        movea.l      (a0, d0.w), a0                                ; $07B39C
        adda.l       #$20, a0                                      ; $07B3A0
        move.w       #$b, d1                                       ; $07B3A6
        move.w       #$40, d2                                      ; $07B3AA
        lea.l        CharacterMenuPortraitTileBases(pc), a1        ; $07B3AE
        lsr.w        #$1, d0                                       ; $07B3B2
        move.w       (a1, d0.w), d3                                ; $07B3B4
        move.w       #$10, d0                                      ; $07B3B8
        cmpi.w       #$e102, $ff2a4c.l                             ; $07B3BC
        beq.w        loc_07B3D0                                    ; $07B3C4
        movea.w      #$e102, a1                                    ; $07B3C8
        bra.w        loc_07B3D4                                    ; $07B3CC

loc_07B3D0:
        movea.w      #$f102, a1                                    ; $07B3D0

loc_07B3D4:
        move.w       a1, $ff2a4c.l                                 ; $07B3D4
        jsr          UploadAttributedTilemap.l                     ; $07B3DA
        rts                                                        ; $07B3E0
        ifne *-$7B3E2
        fail "ROM end moved"
        endif
