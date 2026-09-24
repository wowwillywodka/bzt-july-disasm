; $01E4FA..$01E59D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; A0=source actor, or zero for player origin; D5.w=all required flag bits.
; Search active actors on the same floor, excluding A0; choose minimum octagonal distance.
; If A0 is nonzero, also consider the local player with synthetic flags $00DA.
; A1=actor, zero for player, or -1 when none; D6.w=distance or $FFFF.
        ifne *-$1E4FA
        fail "ROM start moved"
        endif

FindNearestActorOrPlayerWithFlags:
        movea.l      #$ffffffff, a1                                ; $01E4FA
        move.w       #$ffff, d6                                    ; $01E500
        move.w       rPlayerX(a6), d3                              ; $01E504
        move.w       rPlayerY(a6), d4                              ; $01E508
        move.w       rCurrentFloor(a6), d7                         ; $01E50C
        cmpa.l       #$0, a0                                       ; $01E510
        beq.b        loc_01E524                                    ; $01E516
        move.w       ActorX(a0), d3                                   ; $01E518
        move.w       ActorY(a0), d4                                   ; $01E51C
        move.b       ActorFloor(a0), d7                                   ; $01E520

loc_01E524:
        move.w       rActiveActorCount(a6), rNearestActorScanRemaining(a6)             ; $01E524
        beq.b        loc_01E566                                    ; $01E52A
        movea.l      rActiveActorHead(a6), a3                      ; $01E52C

loc_01E530:
        cmpa.l       a0, a3                                        ; $01E530
        beq.b        loc_01E55E                                    ; $01E532
        move.w       ActorFlags(a3), d0                                    ; $01E534
        and.w        d5, d0                                        ; $01E538
        cmp.w        d5, d0                                        ; $01E53A
        bne.b        loc_01E55E                                    ; $01E53C
        cmp.b        ActorFloor(a3), d7                                   ; $01E53E
        bne.b        loc_01E55E                                    ; $01E542
        move.w       d3, d0                                        ; $01E544
        move.w       d4, d1                                        ; $01E546
        sub.w        ActorX(a3), d0                                   ; $01E548
        sub.w        ActorY(a3), d1                                   ; $01E54C
        jsr          OctagonalDistance.l                           ; $01E550
        cmp.w        d6, d0                                        ; $01E556
        bcc.b        loc_01E55E                                    ; $01E558
        move.w       d0, d6                                        ; $01E55A
        movea.l      a3, a1                                        ; $01E55C

loc_01E55E:
        movea.l      (a3), a3                                      ; $01E55E
        subq.w       #$1, rNearestActorScanRemaining(a6)                               ; $01E560
        bne.b        loc_01E530                                    ; $01E564

loc_01E566:
        cmpa.l       #$0, a0                                       ; $01E566
        beq.b        loc_01E59C                                    ; $01E56C
        move.w       #ActorFlagSyntheticPlayer, d0                                      ; $01E56E
        and.w        d5, d0                                        ; $01E572
        cmp.w        d5, d0                                        ; $01E574
        bne.b        loc_01E59C                                    ; $01E576
        cmp.b        rCurrentFloorLow(a6), d7                      ; $01E578
        bne.b        loc_01E59C                                    ; $01E57C
        move.w       d3, d0                                        ; $01E57E
        move.w       d4, d1                                        ; $01E580
        sub.w        rPlayerX(a6), d0                              ; $01E582
        sub.w        rPlayerY(a6), d1                              ; $01E586
        jsr          OctagonalDistance.l                           ; $01E58A
        cmp.w        d6, d0                                        ; $01E590
        bcc.b        loc_01E59C                                    ; $01E592
        move.w       d0, d6                                        ; $01E594
        movea.l      #$0, a1                                       ; $01E596

loc_01E59C:
        rts                                                        ; $01E59C
        ifne *-$1E59E
        fail "ROM end moved"
        endif
