; $07B3E2..$07B465 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Character-selection UI helper (five portraits/biographies), not a geometry-episode selector. See docs/GAME_FLOW.md.
        ifne *-$7B3E2
        fail "ROM start moved"
        endif

DrawCharacterDescription:
; Character-selection UI helper (five portraits/biographies), not a geometry-episode selector. See docs/GAME_FLOW.md.
        move.w       ramSelectedCharacter.l, d0                    ; $07B3E2
        mulu.w       #$13e, d0                                     ; $07B3E8
        lea.l        CharacterBiographyStrings.l, a0               ; $07B3EC
        adda.l       d0, a0                                        ; $07B3F2
        cmpi.w       #$e102, $ff2a4c.l                             ; $07B3F4
        beq.w        loc_07B408                                    ; $07B3FC
        move.w       #$f0a4, d0                                    ; $07B400
        bra.w        loc_07B40C                                    ; $07B404

loc_07B408:
        move.w       #$e0a4, d0                                    ; $07B408

loc_07B40C:
        move.w       #$5, d7                                       ; $07B40C

loc_07B410:
        movem.l      d0/d7/a0, -(a7)                               ; $07B410
        jsr          PrintCharacterMenuText.l                      ; $07B414
        movem.l      (a7)+, d0/d7/a0                               ; $07B41A
        adda.l       #$12, a0                                      ; $07B41E
        addi.w       #$100, d0                                     ; $07B424
        dbra         d7, loc_07B410                                ; $07B428
        cmpi.w       #$e102, $ff2a4c.l                             ; $07B42C
        beq.w        loc_07B440                                    ; $07B434
        move.w       #$f682, d0                                    ; $07B438
        bra.w        loc_07B444                                    ; $07B43C

loc_07B440:
        move.w       #$e682, d0                                    ; $07B440

loc_07B444:
        move.w       #$5, d7                                       ; $07B444

loc_07B448:
        movem.l      d0/d7/a0, -(a7)                               ; $07B448
        jsr          PrintCharacterMenuText.l                      ; $07B44C
        movem.l      (a7)+, d0/d7/a0                               ; $07B452
        adda.l       #$23, a0                                      ; $07B456
        addi.w       #$100, d0                                     ; $07B45C
        dbra         d7, loc_07B448                                ; $07B460
        rts                                                        ; $07B464
        ifne *-$7B466
        fail "ROM end moved"
        endif
