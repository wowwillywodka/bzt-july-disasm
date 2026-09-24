; $00E024..$00E153 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; D0.w=distance-like hit parameter; D3/D4 direction. Optional signed scene-height scaling, strict unsigned <$400 cutoff, HP loss only when rBulletProofVestSlotIndex<0. See docs/ENEMY_PROJECTILES.md; HUD/feedback effects remain external.
        ifne *-$E024
        fail "ROM start moved"
        endif

ApplyPlayerDistanceHit:
; D0.w=distance-like hit parameter; D3/D4 direction. Optional signed scene-height scaling, strict unsigned <$400 cutoff, HP loss only when rBulletProofVestSlotIndex<0. See docs/ENEMY_PROJECTILES.md; HUD/feedback effects remain external.
        tst.b        rPauseMapAndHitFlashToggle(a6)                                    ; $00E024
        beq.b        loc_00E032                                    ; $00E028
        move.w       #$f, rPlayerDamageFlashColor(a6)                               ; $00E02A
        rts                                                        ; $00E030

loc_00E032:
        tst.w        rPlayerDeathTicks(a6)                         ; $00E032
        beq.b        loc_00E03A                                    ; $00E036
        rts                                                        ; $00E038

loc_00E03A:
        move.l       a0, -(a7)                                     ; $00E03A
        move.w       d0, d1                                        ; $00E03C
        move.w       d2, -(a7)                                     ; $00E03E
        tst.w        rPlayerViewOffsetZ(a6)                                    ; $00E040
        beq.b        loc_00E05A                                    ; $00E044
        bmi.b        loc_00E052                                    ; $00E046
        move.w       d1, d2                                        ; $00E048
        asr.w        #$2, d2                                       ; $00E04A
        sub.w        d2, d1                                        ; $00E04C
        sub.w        d2, d0                                        ; $00E04E
        bra.b        loc_00E05A                                    ; $00E050

loc_00E052:
        move.w       d1, d2                                        ; $00E052
        asr.w        #$1, d2                                       ; $00E054
        add.w        d2, d1                                        ; $00E056
        add.w        d2, d0                                        ; $00E058

loc_00E05A:
        move.w       (a7)+, d2                                     ; $00E05A
        cmpi.w       #$400, d1                                     ; $00E05C
        bcs.b        loc_00E066                                    ; $00E060
        movea.l      (a7)+, a0                                     ; $00E062
        rts                                                        ; $00E064

loc_00E066:
        asr.w        #$6, d1                                       ; $00E066
        lea.l        PlayerDamageViewOffsets(pc), a1               ; $00E068
        tst.w        rBulletProofVestSlotIndex(a6)                                    ; $00E06C
        bpl.b        loc_00E0A0                                    ; $00E070
        neg.w        d1                                            ; $00E072
        addi.w       #$10, d1                                      ; $00E074
        cmpi.w       #$3, rSelectedCharacter(a6)                   ; $00E078
        bne.b        loc_00E086                                    ; $00E07E
        move.w       d1, d0                                        ; $00E080
        asr.w        #$2, d0                                       ; $00E082
        sub.w        d0, d1                                        ; $00E084

loc_00E086:
        cmpi.w       #$4, rSelectedCharacter(a6)                   ; $00E086
        bne.b        loc_00E090                                    ; $00E08C
        asr.w        #$1, d1                                       ; $00E08E

loc_00E090:
        move.w       rPlayerHealth(a6), rPlayerHealthBeforeHit(a6)                 ; $00E090
        sub.w        d1, rPlayerHealth(a6)                         ; $00E096
        subi.w       #$10, d1                                      ; $00E09A
        neg.w        d1                                            ; $00E09E

loc_00E0A0:
        lsl.w        #$2, d1                                       ; $00E0A0
        andi.w       #$3c, d1                                      ; $00E0A2
        adda.w       d1, a1                                        ; $00E0A6
        tst.w        rBulletProofVestSlotIndex(a6)                                    ; $00E0A8
        bpl.b        loc_00E0C0                                    ; $00E0AC
        lsr.w        #$3, d1                                       ; $00E0AE
        neg.w        d1                                            ; $00E0B0
        addi.w       #$f, d1                                       ; $00E0B2
        cmp.w        rPlayerDamageFlashColor(a6), d1                                ; $00E0B6
        bls.b        loc_00E0C0                                    ; $00E0BA
        move.w       d1, rPlayerDamageFlashColor(a6)                                ; $00E0BC

loc_00E0C0:
; The July ROM loads the table's vertical velocity, then clears it immediately.
; Keep both instructions: the table value does not survive this path.
        tst.w        rPlayerViewVerticalVelocity(a6)                                    ; $00E0C0
        bne.b        loc_00E0D4                                    ; $00E0C4
        tst.w        rPlayerViewOffsetZ(a6)                                    ; $00E0C6
        bne.b        loc_00E0D4                                    ; $00E0CA
        move.w       (a1), rPlayerViewVerticalVelocity(a6)                              ; $00E0CC
        clr.w        rPlayerViewVerticalVelocity(a6)                                    ; $00E0D0

loc_00E0D4:
        move.w       $2(a1), -(a7)                                 ; $00E0D4
        move.w       d3, d0                                        ; $00E0D8
        move.w       d4, d1                                        ; $00E0DA
        bsr.w        OctagonalDistance                             ; $00E0DC
        move.w       (a7)+, d1                                     ; $00E0E0
        muls.w       d1, d3                                        ; $00E0E2
        muls.w       d1, d4                                        ; $00E0E4
        addq.w       #$1, d0                                       ; $00E0E6
        divs.w       d0, d3                                        ; $00E0E8
        divs.w       d0, d4                                        ; $00E0EA

loc_00E0EC:
        move.w       d3, d0                                        ; $00E0EC
        move.w       d4, d1                                        ; $00E0EE
        jsr          OctagonalDistance(pc)                         ; $00E0F0
        cmpi.w       #$100, d0                                     ; $00E0F4
        bls.b        loc_00E100                                    ; $00E0F8
        asr.w        #$1, d3                                       ; $00E0FA
        asr.w        #$1, d4                                       ; $00E0FC
        bra.b        loc_00E0EC                                    ; $00E0FE

loc_00E100:
        andi.l       #$ffff, d3                                    ; $00E100
        andi.l       #$ffff, d4                                    ; $00E106
        ext.l        d3                                            ; $00E10C
        ext.l        d4                                            ; $00E10E
        move.w       rPlayerHealth(a6), d0                         ; $00E110
        lsr.w        #$3, d0                                       ; $00E114
        tst.w        d0                                            ; $00E116
        beq.b        loc_00E11E                                    ; $00E118
        divs.w       d0, d3                                        ; $00E11A
        divs.w       d0, d4                                        ; $00E11C

loc_00E11E:
        move.w       d3, rPlayerHitImpulseX(a6)                                ; $00E11E
        move.w       d4, rPlayerHitImpulseY(a6)                                ; $00E122
        cmpi.w       #$7, (a1)                                     ; $00E126
        bcs.b        loc_00E138                                    ; $00E12A
        move.w       #$fff0, rPlayerViewOffsetTargetZ(a6)                            ; $00E12C
        move.w       #$14, rPlayerViewTargetHoldTicks(a6)                              ; $00E132

loc_00E138:
        bsr.w        QueueHealthThresholdStatusMessage                              ; $00E138
        tst.w        rBulletProofVestSlotIndex(a6)                                    ; $00E13C
        bpl.b        loc_00E14A                                    ; $00E140
        bsr.w        UpdatePlayerHealthHudDigits                              ; $00E142
        movea.l      (a7)+, a0                                     ; $00E146
        rts                                                        ; $00E148

loc_00E14A:
        jsr          ConsumeVestChargeOnHit.l                            ; $00E14A
        movea.l      (a7)+, a0                                     ; $00E150
        rts                                                        ; $00E152
        ifne *-$E154
        fail "ROM end moved"
        endif
