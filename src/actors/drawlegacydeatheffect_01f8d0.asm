; $01F8D0..$01F981 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Selects frames 0/1 or 3/4 from a legacy $26-byte resource, then calls the July $36-byte reader. Storage/runtime mismatch is preserved.
        ifne *-$1F8D0
        fail "ROM start moved"
        endif

DrawLegacyDeathEffect:
; Selects frames 0/1 or 3/4 from a legacy $26-byte resource, then calls the July $36-byte reader. Storage/runtime mismatch is preserved.
        move.l       #LegacyDeathEffectSpriteBank, ActorSpriteBank(a0) ; $01F8D0
        clr.w        d0                                            ; $01F8D8
        move.w       rGameTick(a6), d2                             ; $01F8DA
        add.b        ActorLinkId(a0), d2                           ; $01F8DE
        asr.w        #$2, d2                                       ; $01F8E2
        andi.w       #$1, d2                                       ; $01F8E4
        btst.b       #$0, ActorStateCounter(a0)                    ; $01F8E8
        beq.w        DrawActorAnimation                            ; $01F8EE
        addq.w       #$3, d2                                       ; $01F8F2
        bra.w        DrawActorAnimation                            ; $01F8F4
UpdateLegacyDeathEffect:
; Independent update entry: damp XY motion, then reuse the shared enemy
; target/obstacle exit gate. The draw branch above never falls through here.
        clr.b        ActorUpdateDelay(a0)                          ; $01F8F8
        move.w       ActorMotionX(a0), d0                          ; $01F8FC
        bmi.b        loc_01F906                                    ; $01F900
        asr.w        #$1, d0                                       ; $01F902
        bra.b        loc_01F90C                                    ; $01F904

loc_01F906:
        neg.w        d0                                            ; $01F906
        asr.w        #$1, d0                                       ; $01F908
        neg.w        d0                                            ; $01F90A

loc_01F90C:
        move.w       d0, ActorMotionX(a0)                          ; $01F90C
        move.w       ActorMotionY(a0), d1                          ; $01F910
        bmi.b        loc_01F91A                                    ; $01F914
        asr.w        #$1, d1                                       ; $01F916
        bra.b        loc_01F920                                    ; $01F918

loc_01F91A:
        neg.w        d1                                            ; $01F91A
        asr.w        #$1, d1                                       ; $01F91C
        neg.w        d1                                            ; $01F91E

loc_01F920:
        move.w       d1, ActorMotionY(a0)                          ; $01F920
        move.w       d0, d2                                        ; $01F924
        or.w         d1, d2                                        ; $01F926
        beq.b        loc_01F936                                    ; $01F928
        move.w       d0, ActorMotionX(a0)                          ; $01F92A
        move.w       d1, ActorMotionY(a0)                          ; $01F92E
        bsr.w        MoveActorWithWallMargin32                     ; $01F932

loc_01F936:
        bra.w        SteerEnemyMotionAtNearbyWall                         ; $01F936
        clr.w        ActorMotionX(a0)                              ; $01F93A
        clr.w        ActorMotionY(a0)                              ; $01F93E
        neg.w        d3                                            ; $01F942
        neg.w        d4                                            ; $01F944
        move.w       d0, -(a7)                                     ; $01F946
        move.w       d3, d0                                        ; $01F948
        move.w       d4, d1                                        ; $01F94A
        jsr          OctagonalDistance.l                           ; $01F94C
        ext.l        d3                                            ; $01F952
        ext.l        d4                                            ; $01F954
        lsl.l        #$8, d3                                       ; $01F956
        lsl.l        #$8, d4                                       ; $01F958
        addq.w       #$1, d0                                       ; $01F95A
        beq.b        loc_01F962                                    ; $01F95C
        divs.w       d0, d3                                        ; $01F95E
        divs.w       d0, d4                                        ; $01F960

loc_01F962:
        move.w       #$400, d0                                     ; $01F962
        sub.w        (a7)+, d0                                     ; $01F966
        bmi.b        loc_01F980                                    ; $01F968
        asr.w        #$4, d0                                       ; $01F96A
        muls.w       d0, d3                                        ; $01F96C
        muls.w       d0, d4                                        ; $01F96E
        asr.l        #$8, d3                                       ; $01F970
        asr.l        #$8, d4                                       ; $01F972
        move.w       d3, ActorMotionX(a0)                          ; $01F974
        move.w       d4, ActorMotionY(a0)                          ; $01F978
        addq.b       #$1, ActorStateCounter(a0)                    ; $01F97C

loc_01F980:
        rts                                                        ; $01F980
        ifne *-$1F982
        fail "ROM end moved"
        endif
