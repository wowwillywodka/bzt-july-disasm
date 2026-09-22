; $014620..$0146EB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Buligun immediate shot: lowering guard only, consume$100, activate wall stages, select aim target. D0=(distance^2>>8) ASR.W1; characters0/2 halve again. Unsigned word threshold<$400.
        ifne *-$14620
        fail "ROM start moved"
        endif

FireBuligun:
; Buligun immediate shot: lowering guard only, consume$100, activate wall stages, select aim target. D0=(distance^2>>8) ASR.W1; characters0/2 halve again. Unsigned word threshold<$400.
        tst.w        rWeaponLoweringOffset(a6)                     ; $014620
        bne.w        loc_0146EA                                    ; $014624
        clr.w        -$55a0(a6)                                    ; $014628
        clr.w        -$559e(a6)                                    ; $01462C
        move.w       #$1d, d0                                      ; $014630
        jsr          SoundRoutine_00DF84.l                         ; $014634
        move.w       #$14, -$559e(a6)                              ; $01463A
        move.w       #$1, rWeaponActionPhase(a6)                   ; $014640
        bsr.w        ConsumeSelectedItemAndUpdateHud               ; $014646
        move.l       d0, -(a7)                                     ; $01464A
        move.w       #$1, d0                                       ; $01464C
        move.w       rPlayerX(a6), d1                              ; $014650
        move.w       rPlayerY(a6), d2                              ; $014654
        bsr.w        ActivateEpisode1WallStages                    ; $014658
        move.l       (a7)+, d0                                     ; $01465C
        move.w       #$1, d1                                       ; $01465E
        cmpi.w       #$0, rSelectedCharacter(a6)                   ; $014662
        beq.b        loc_014672                                    ; $014668
        cmpi.w       #$2, rSelectedCharacter(a6)                   ; $01466A
        bne.b        loc_014676                                    ; $014670

loc_014672:
        move.w       #$4, d1                                       ; $014672

loc_014676:
        move.w       -$71b0(a6), d2                                ; $014676
        addi.w       #$40, d2                                      ; $01467A
        jsr          SelectPlayerWeaponAimTarget.l                 ; $01467E
        cmpa.l       #$0, a1                                       ; $014684
        beq.b        loc_0146D8                                    ; $01468A
        movea.l      a1, a0                                        ; $01468C
        move.w       $24(a0), d0                                   ; $01468E
        sub.w        rPlayerX(a6), d0                              ; $014692
        move.w       $26(a0), d1                                   ; $014696
        sub.w        rPlayerY(a6), d1                              ; $01469A
        bsr.w        OctagonalDistance                             ; $01469E
        mulu.w       d0, d0                                        ; $0146A2
        asr.l        #$8, d0                                       ; $0146A4
        asr.w        #$1, d0                                       ; $0146A6
        cmpi.w       #$0, rSelectedCharacter(a6)                   ; $0146A8
        beq.b        loc_0146B8                                    ; $0146AE
        cmpi.w       #$2, rSelectedCharacter(a6)                   ; $0146B0
        bne.b        loc_0146BA                                    ; $0146B6

loc_0146B8:
        asr.w        #$1, d0                                       ; $0146B8

loc_0146BA:
        cmpi.w       #$400, d0                                     ; $0146BA
        bcc.b        loc_0146EA                                    ; $0146BE
        move.w       rPlayerX(a6), d3                              ; $0146C0
        move.w       rPlayerY(a6), d4                              ; $0146C4
        sub.w        $24(a0), d3                                   ; $0146C8
        sub.w        $26(a0), d4                                   ; $0146CC
        movea.l      ActorHitCallback(a0), a1                      ; $0146D0
        jsr          (a1)                                          ; $0146D4
        bra.b        loc_0146EA                                    ; $0146D6

loc_0146D8:
        jsr          ObjectsRoutine_00A3D2.l                       ; $0146D8
        bne.b        loc_0146E4                                    ; $0146DE
        bsr.w        TraceMissedShotAndSpawnImpact                 ; $0146E0

loc_0146E4:
        jsr          TraceShotToDamageablePanel.l                  ; $0146E4

loc_0146EA:
        rts                                                        ; $0146EA
        ifne *-$146EC
        fail "ROM end moved"
        endif
