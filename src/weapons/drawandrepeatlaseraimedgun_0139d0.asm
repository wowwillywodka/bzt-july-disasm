; $0139D0..$013BF3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Laser Aimed Gun repeats fire while held in old phases1/2, consuming $40 per continuation; old phase2 resets to1. Continuation uses squared-distance hit parameter, unlike initial action. Draws targeting marker too.
        ifne *-$139D0
        fail "ROM start moved"
        endif

DrawAndRepeatLaserAimedGun:
; Laser Aimed Gun repeats fire while held in old phases1/2, consuming $40 per continuation; old phase2 resets to1. Continuation uses squared-distance hit parameter, unlike initial action. Draws targeting marker too.
        move.w       d1, -(a7)                                     ; $0139D0
        addi.w       #$d9, d0                                      ; $0139D2
        addi.w       #$118, d1                                     ; $0139D6
        move.w       #$ce, d4                                      ; $0139DA
        lea.l        WeaponRecoilOffsets(pc), a0                   ; $0139DE
        move.w       rWeaponActionPhase(a6), d3                    ; $0139E2
        beq.w        loc_013B4A                                    ; $0139E6
        move.b       (a0, d3.w), d2                                ; $0139EA
        ext.w        d2                                            ; $0139EE
        add.w        d2, d0                                        ; $0139F0
        sub.w        d2, d4                                        ; $0139F2
        sub.w        d2, d4                                        ; $0139F4
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $0139F6
        movem.w      d0-d1/d4, -(a7)                               ; $0139FA
        cmpi.w       #$3, rWeaponActionPhase(a6)                   ; $0139FE
        bhi.w        loc_013B3A                                    ; $013A04
        tst.w        rPlayerDeathTicks(a6)                         ; $013A08
        bne.w        loc_013B3A                                    ; $013A0C
        btst.b       #$4, rControllerState(a6)                     ; $013A10
        beq.w        loc_013B3A                                    ; $013A16
        clr.w        rStatusSoundScriptActive(a6)                                    ; $013A1A
        clr.w        rSoundEffectCooldown(a6)                                    ; $013A1E
        move.w       #$1e, d0                                      ; $013A22
        jsr          PlaySoundEventAndMaybeSendLink.l                         ; $013A26
        move.w       #$f, rSoundEffectCooldown(a6)                               ; $013A2C

loc_013A32:
        tst.w        rVBlankTransferPhasesRemaining(a6)                                    ; $013A32
        bne.b        loc_013A32                                    ; $013A36
        clr.w        d0                                            ; $013A38
        move.b       rSelectedInventorySlot(a6), d0                ; $013A3A
        lsl.w        #$8, d0                                       ; $013A3E
        lsl.w        #$1, d0                                       ; $013A40
        addi.w       #$93e0, d0                                    ; $013A42
        move.w       d0, d5                                        ; $013A46
        movea.l      #VDP_DATA, a4                                 ; $013A48
        lea.l        rInventorySlots(a6), a0                       ; $013A4E
        clr.w        d0                                            ; $013A52
        move.b       rSelectedInventorySlot(a6), d0                ; $013A54
        mulu.w       #$4, d0                                       ; $013A58
        cmpi.w       #$40, $2(a0, d0.w)                            ; $013A5C
        bhi.b        loc_013A70                                    ; $013A62
        bsr.w        ExhaustSelectedItemAndEraseHud                ; $013A64
        movem.w      (a7)+, d0-d1/d4                               ; $013A68
        bra.w        loc_013B4A                                    ; $013A6C

loc_013A70:
        cmpi.w       #$3, rWeaponActionPhase(a6)                   ; $013A70
        bne.b        loc_013A7E                                    ; $013A76
        move.w       #$1, rWeaponActionPhase(a6)                   ; $013A78

loc_013A7E:
        subi.w       #$40, $2(a0, d0.w)                            ; $013A7E
        addi.l       #$40, rAmmoUsageFixedCounter(a6)              ; $013A84
        move.w       $2(a0, d0.w), -(a7)                           ; $013A8C
        move.w       d5, d0                                        ; $013A90
        addi.w       #$68, d0                                      ; $013A92
        move.w       d0, d1                                        ; $013A96
        andi.w       #$3fff, d1                                    ; $013A98
        ori.w        #$4000, d1                                    ; $013A9C
        swap         d1                                            ; $013AA0
        lsr.w        #$8, d0                                       ; $013AA2
        lsr.w        #$6, d0                                       ; $013AA4
        move.w       d0, d1                                        ; $013AA6
        move.l       d1, VDP_CONTROL.l                             ; $013AA8
        move.w       (a7)+, d0                                     ; $013AAE
        subq.w       #$1, d0                                       ; $013AB0
        lsr.w        #$8, d0                                       ; $013AB2
        addq.w       #$1, d0                                       ; $013AB4
        jsr          DrawInventoryQuantityDigits.l                            ; $013AB6
        move.w       #$3, d1                                       ; $013ABC
        cmpi.w       #$0, rSelectedCharacter(a6)                   ; $013AC0
        bne.b        loc_013ACC                                    ; $013AC6
        move.w       #$5, d1                                       ; $013AC8

loc_013ACC:
        move.w       rViewSwayAngleOffset(a6), d2                                ; $013ACC
        lsl.w        #$1, d2                                       ; $013AD0
        addi.w       #$40, d2                                      ; $013AD2
        jsr          SelectPlayerWeaponAimTarget.l                 ; $013AD6
        cmpa.l       #$0, a1                                       ; $013ADC
        beq.b        loc_013B28                                    ; $013AE2
        movea.l      a1, a0                                        ; $013AE4
        move.w       $24(a0), d0                                   ; $013AE6
        sub.w        rPlayerX(a6), d0                              ; $013AEA
        move.w       $26(a0), d1                                   ; $013AEE
        sub.w        rPlayerY(a6), d1                              ; $013AF2
        bsr.w        OctagonalDistance                             ; $013AF6
        mulu.w       d0, d0                                        ; $013AFA
        asr.l        #$8, d0                                       ; $013AFC
        asr.w        #$1, d0                                       ; $013AFE
        cmpi.w       #$0, rSelectedCharacter(a6)                   ; $013B00
        bne.b        loc_013B0A                                    ; $013B06
        asr.w        #$1, d0                                       ; $013B08

loc_013B0A:
        cmpi.w       #$400, d0                                     ; $013B0A
        bcc.b        loc_013B3A                                    ; $013B0E
        move.w       rPlayerX(a6), d3                              ; $013B10
        move.w       rPlayerY(a6), d4                              ; $013B14
        sub.w        $24(a0), d3                                   ; $013B18
        sub.w        $26(a0), d4                                   ; $013B1C
        movea.l      ActorHitCallback(a0), a1                      ; $013B20
        jsr          (a1)                                          ; $013B24
        bra.b        loc_013B3A                                    ; $013B26

loc_013B28:
        jsr          ClassifyPlayerCellForWeapon.l                       ; $013B28
        bne.b        loc_013B34                                    ; $013B2E
        bsr.w        TraceMissedShotAndSpawnImpact                 ; $013B30

loc_013B34:
        jsr          TraceShotToDamageablePanel.l                  ; $013B34

loc_013B3A:
        movem.w      (a7)+, d0-d1/d4                               ; $013B3A
        cmpi.w       #$5, rWeaponActionPhase(a6)                   ; $013B3E
        bne.b        loc_013B4A                                    ; $013B44
        clr.w        rWeaponActionPhase(a6)                        ; $013B46

loc_013B4A:
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $013B4A
        move.w       d0, (a2)+                                     ; $013B4E
        move.w       rSpriteAttributeNextLink(a6), d2                                ; $013B50
        ori.w        #$b00, d2                                     ; $013B54
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $013B58
        move.w       d2, (a2)+                                     ; $013B5C
        move.w       #$a4ef, (a2)+                                 ; $013B5E
        subq.w       #$3, d1                                       ; $013B62
        move.w       d1, (a2)+                                     ; $013B64
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $013B66
        addq.w       #$3, d1                                       ; $013B6A
        cmpi.w       #$2, rWeaponActionPhase(a6)                   ; $013B6C
        bne.b        loc_013B96                                    ; $013B72
        subq.w       #$5, d1                                       ; $013B74
        subq.w       #$7, d0                                       ; $013B76
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $013B78
        move.w       d0, (a2)+                                     ; $013B7C
        move.w       rSpriteAttributeNextLink(a6), d2                                ; $013B7E
        ori.w        #$a00, d2                                     ; $013B82
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $013B86
        move.w       d2, (a2)+                                     ; $013B8A
        move.w       #$a4fb, (a2)+                                 ; $013B8C
        move.w       d1, (a2)+                                     ; $013B90
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $013B92

loc_013B96:
        move.w       (a7)+, d1                                     ; $013B96
        lsl.w        #$1, d1                                       ; $013B98
        addi.w       #$11e, d1                                     ; $013B9A
        move.w       d4, d2                                        ; $013B9E
        subi.w       #$ce, d2                                      ; $013BA0
        lsl.w        #$2, d2                                       ; $013BA4
        lea.l        rLaserReticleFrameSampleBase(a6), a0                                 ; $013BA6
        tst.b        (a0, d2.w)                                    ; $013BAA
        beq.b        loc_013BF2                                    ; $013BAE
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $013BB0
        move.w       d4, (a2)+                                     ; $013BB4
        move.w       rSpriteAttributeNextLink(a6), d0                                ; $013BB6
        ori.w        #$0, d0                                       ; $013BBA
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $013BBE
        move.w       d0, (a2)+                                     ; $013BC2
        move.w       d1, d0                                        ; $013BC4
        subi.w       #$11e, d0                                     ; $013BC6
        bclr.l       #$0, d0                                       ; $013BCA
        lea.l        rCenterScreenColumnDepthWord(a6), a0                                  ; $013BCE
        move.w       (a0, d0.w), d0                                ; $013BD2
        lsr.w        #$4, d0                                       ; $013BD6
        cmpi.w       #$4, d0                                       ; $013BD8
        bls.b        loc_013BE2                                    ; $013BDC
        move.w       #$4, d0                                       ; $013BDE

loc_013BE2:
        addi.w       #$a2f7, d0                                    ; $013BE2
        move.w       d0, (a2)+                                     ; $013BE6
        subq.w       #$1, d1                                       ; $013BE8
        move.w       d1, (a2)+                                     ; $013BEA
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $013BEC
        addq.w       #$1, d1                                       ; $013BF0

loc_013BF2:
        rts                                                        ; $013BF2
        ifne *-$13BF4
        fail "ROM end moved"
        endif
