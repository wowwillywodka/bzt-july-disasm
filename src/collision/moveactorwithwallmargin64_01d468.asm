; $01D468..$01D5C9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Same algorithm as MoveActorWithWallMargin32, but wall fraction margin64 ($40..$BF). Used by living Dog/Denpyder; their corpse movement uses margin32. Player separation remains32 in both.
        ifne *-$1D468
        fail "ROM start moved"
        endif

MoveActorWithWallMargin64:
; Same algorithm as MoveActorWithWallMargin32, but wall fraction margin64 ($40..$BF). Used by living Dog/Denpyder; their corpse movement uses margin32. Player separation remains32 in both.
        move.w       ActorY(a0), -(a7)                             ; $01D468
        move.w       ActorX(a0), -(a7)                             ; $01D46C
        lea.l        rCellTypeByIndex(a6), a5                      ; $01D470
        bsr.w        GetVisibleMapBase                             ; $01D474
        clr.w        d3                                            ; $01D478
        move.w       ActorX(a0), d2                                ; $01D47A
        add.w        d0, d2                                        ; $01D47E
        asr.w        #$8, d2                                       ; $01D480
        move.w       ActorY(a0), d4                                ; $01D482
        add.w        d1, d4                                        ; $01D486
        clr.b        d4                                            ; $01D488
        asr.w        #$3, d4                                       ; $01D48A
        add.w        d4, d2                                        ; $01D48C
        move.b       (a1, d2.w), d3                                ; $01D48E
        move.b       (a5, d3.w), d3                                ; $01D492
        bsr.w        GetEnemyWalkability                           ; $01D496
        beq.b        loc_01D4E2                                    ; $01D49A

Margin64TryYOnly:
        move.w       ActorX(a0), d2                                ; $01D49C
        asr.w        #$8, d2                                       ; $01D4A0
        move.w       ActorY(a0), d4                                ; $01D4A2
        add.w        d1, d4                                        ; $01D4A6
        clr.b        d4                                            ; $01D4A8
        asr.w        #$3, d4                                       ; $01D4AA
        add.w        d4, d2                                        ; $01D4AC
        move.b       (a1, d2.w), d3                                ; $01D4AE
        move.b       (a5, d3.w), d3                                ; $01D4B2
        bsr.w        GetEnemyWalkability                           ; $01D4B6
        beq.b        loc_01D4E6                                    ; $01D4BA

Margin64TryXOnly:
        move.w       ActorX(a0), d2                                ; $01D4BC
        add.w        d0, d2                                        ; $01D4C0
        asr.w        #$8, d2                                       ; $01D4C2
        move.w       ActorY(a0), d4                                ; $01D4C4
        clr.b        d4                                            ; $01D4C8
        asr.w        #$3, d4                                       ; $01D4CA
        add.w        d4, d2                                        ; $01D4CC
        move.b       (a1, d2.w), d3                                ; $01D4CE
        move.b       (a5, d3.w), d3                                ; $01D4D2
        bsr.w        GetEnemyWalkability                           ; $01D4D6
        bne.b        Margin64ClampNearWalls                        ; $01D4DA
        add.w        d0, ActorX(a0)                                ; $01D4DC
        bra.b        Margin64ClampNearWalls                        ; $01D4E0

loc_01D4E2:
        add.w        d0, ActorX(a0)                                ; $01D4E2

loc_01D4E6:
        add.w        d1, ActorY(a0)                                ; $01D4E6

Margin64ClampNearWalls:
; Only semantic difference from margin32 variant: wall fractions clamp to$40/$BF rather than$20/$DF. Classification, slide priority, player push and marker exception are shared in meaning.
        move.w       ActorX(a0), d2                                ; $01D4EA
        asr.w        #$8, d2                                       ; $01D4EE
        move.w       ActorY(a0), d4                                ; $01D4F0
        clr.b        d4                                            ; $01D4F4
        asr.w        #$3, d4                                       ; $01D4F6
        add.w        d4, d2                                        ; $01D4F8
        adda.w       d2, a1                                        ; $01D4FA
        move.b       ActorFractionX(a0), d2                        ; $01D4FC
        cmpi.b       #$40, d2                                      ; $01D500
        bcc.b        loc_01D51C                                    ; $01D504
        move.b       -$1(a1), d3                                   ; $01D506
        move.b       (a5, d3.w), d3                                ; $01D50A
        bsr.w        GetEnemyWalkability                           ; $01D50E
        beq.b        loc_01D536                                    ; $01D512
        move.b       #$40, ActorFractionX(a0)                      ; $01D514
        bra.b        loc_01D536                                    ; $01D51A

loc_01D51C:
        cmpi.b       #$bf, d2                                      ; $01D51C
        bls.b        loc_01D536                                    ; $01D520
        move.b       $1(a1), d3                                    ; $01D522
        move.b       (a5, d3.w), d3                                ; $01D526
        bsr.w        GetEnemyWalkability                           ; $01D52A
        beq.b        loc_01D536                                    ; $01D52E
        move.b       #$bf, ActorFractionX(a0)                      ; $01D530

loc_01D536:
        move.b       ActorFractionY(a0), d2                        ; $01D536
        cmpi.b       #$40, d2                                      ; $01D53A
        bcc.b        loc_01D556                                    ; $01D53E
        move.b       -$20(a1), d3                                  ; $01D540
        move.b       (a5, d3.w), d3                                ; $01D544
        bsr.w        GetEnemyWalkability                           ; $01D548
        beq.b        Margin64PushFromLocalPlayer                   ; $01D54C
        move.b       #$40, ActorFractionY(a0)                      ; $01D54E
        bra.b        Margin64PushFromLocalPlayer                   ; $01D554

loc_01D556:
        cmpi.b       #$bf, d2                                      ; $01D556
        bls.b        Margin64PushFromLocalPlayer                   ; $01D55A
        move.b       $20(a1), d3                                   ; $01D55C
        move.b       (a5, d3.w), d3                                ; $01D560
        bsr.w        GetEnemyWalkability                           ; $01D564
        beq.b        Margin64PushFromLocalPlayer                   ; $01D568
        move.b       #$bf, ActorFractionY(a0)                      ; $01D56A

Margin64PushFromLocalPlayer:
; Same global-player formula as margin32, NOT a64-unit actor/player radius. No collision recheck after position rewrite.
        move.w       ActorX(a0), d0                                ; $01D570
        sub.w        rPlayerX(a6), d0                              ; $01D574
        move.w       ActorY(a0), d1                                ; $01D578
        sub.w        rPlayerY(a6), d1                              ; $01D57C
        move.w       d0, d3                                        ; $01D580
        move.w       d1, d4                                        ; $01D582
        jsr          OctagonalDistance.l                           ; $01D584
        addq.w       #$1, d0                                       ; $01D58A
        beq.b        Margin64ReturnDisplacement                    ; $01D58C
        cmpi.w       #$20, d0                                      ; $01D58E
        bcc.b        Margin64ReturnDisplacement                    ; $01D592
        ext.l        d3                                            ; $01D594
        ext.l        d4                                            ; $01D596
        lsl.l        #$5, d3                                       ; $01D598
        lsl.l        #$5, d4                                       ; $01D59A
        divs.w       d0, d3                                        ; $01D59C
        divs.w       d0, d4                                        ; $01D59E
        add.w        rPlayerX(a6), d3                              ; $01D5A0
        add.w        rPlayerY(a6), d4                              ; $01D5A4
        move.w       d3, ActorX(a0)                                ; $01D5A8
        move.w       d4, ActorY(a0)                                ; $01D5AC

Margin64ReturnDisplacement:
; Compute actual XY displacement, then optionally lose it to tracked-marker helper. Motion fields are not rewritten.
        move.w       ActorX(a0), d0                                ; $01D5B0
        sub.w        (a7)+, d0                                     ; $01D5B4
        move.w       ActorY(a0), d1                                ; $01D5B6
        sub.w        (a7)+, d1                                     ; $01D5BA
        tst.b        ActorMarkerTracked(a0)                        ; $01D5BC
        beq.b        loc_01D5C8                                    ; $01D5C0
; Same tracked-marker return-register exception as $1D460.
        jsr          UpdateTrackedActorMarkerAfterMove.l           ; $01D5C2

loc_01D5C8:
        rts                                                        ; $01D5C8
        ifne *-$1D5CA
        fail "ROM end moved"
        endif
