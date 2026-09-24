; $013D92..$013F2F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Pulse Laser ID0F: old phase1->2 emits slow projectile. Hit callback is ApplyPlayerDistanceHit, NOT explosion. ID0E is separate immediate-hit weapon; both item messages say PULSE LASER.
        ifne *-$13D92
        fail "ROM start moved"
        endif

DrawAndLaunchPulseLaserProjectile:
; Pulse Laser ID0F: old phase1->2 emits slow projectile. Hit callback is ApplyPlayerDistanceHit, NOT explosion. ID0E is separate immediate-hit weapon; both item messages say PULSE LASER.
        addi.w       #$e1, d0                                      ; $013D92
        addi.w       #$120, d1                                     ; $013D96
        lea.l        WeaponRecoilOffsets(pc), a0                   ; $013D9A
        move.w       rWeaponActionPhase(a6), d3                    ; $013D9E
        beq.b        loc_013DBE                                    ; $013DA2
        move.b       (a0, d3.w), d2                                ; $013DA4
        ext.w        d2                                            ; $013DA8
        add.w        d2, d0                                        ; $013DAA
        add.w        d2, d1                                        ; $013DAC
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $013DAE
        cmpi.w       #$5, rWeaponActionPhase(a6)                   ; $013DB2
        bne.b        loc_013DBE                                    ; $013DB8
        clr.w        rWeaponActionPhase(a6)                        ; $013DBA

loc_013DBE:
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $013DBE
        move.w       d0, (a2)+                                     ; $013DC2
        move.w       rSpriteAttributeNextLink(a6), d2                                ; $013DC4
        ori.w        #$e00, d2                                     ; $013DC8
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $013DCC
        move.w       d2, (a2)+                                     ; $013DD0
        move.w       #$a4ef, (a2)+                                 ; $013DD2
        move.w       d1, (a2)+                                     ; $013DD6
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $013DD8
        cmpi.w       #$2, rWeaponActionPhase(a6)                   ; $013DDC
        bne.w        loc_013F2E                                    ; $013DE2
        subq.w       #$5, d1                                       ; $013DE6
        subq.w       #$8, d0                                       ; $013DE8
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $013DEA
        move.w       d0, (a2)+                                     ; $013DEE
        move.w       rSpriteAttributeNextLink(a6), d2                                ; $013DF0
        ori.w        #$a00, d2                                     ; $013DF4
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $013DF8
        move.w       d2, (a2)+                                     ; $013DFC
        move.w       #$a4fb, (a2)+                                 ; $013DFE
        move.w       d1, (a2)+                                     ; $013E02
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $013E04
        jsr          AllocateActor.l                               ; $013E08
        beq.w        loc_013F2E                                    ; $013E0E
        move.b       #$ff, $38(a0)                                 ; $013E12
        move.l       a0, -(a7)                                     ; $013E18
        move.w       #$8, d1                                       ; $013E1A
        move.w       rViewSwayAngleOffset(a6), d2                                ; $013E1E
        addi.w       #$40, d2                                      ; $013E22
        jsr          SelectPlayerWeaponAimTarget.l                 ; $013E26
        movea.l      (a7)+, a0                                     ; $013E2C
        cmpa.l       #$0, a1                                       ; $013E2E
        beq.b        loc_013E72                                    ; $013E34
        tst.w        rLinkRole(a6)                                 ; $013E36
        beq.b        loc_013E4A                                    ; $013E3A
        cmpa.l       #$ff123a, a1                                  ; $013E3C
        bne.b        loc_013E4A                                    ; $013E42
        clr.w        d0                                            ; $013E44
        clr.w        d1                                            ; $013E46
        bra.b        loc_013E56                                    ; $013E48

loc_013E4A:
        move.w       $2e(a1), d0                                   ; $013E4A
        lsl.w        #$2, d0                                       ; $013E4E
        move.w       $30(a1), d1                                   ; $013E50
        lsl.w        #$2, d1                                       ; $013E54

loc_013E56:
        add.w        $24(a1), d0                                   ; $013E56
        sub.w        rPlayerX(a6), d0                              ; $013E5A
        add.w        $26(a1), d1                                   ; $013E5E
        sub.w        rPlayerY(a6), d1                              ; $013E62
        bsr.w        OctagonalDistance                             ; $013E66
        asr.w        #$7, d0                                       ; $013E6A
        addq.b       #$1, d0                                       ; $013E6C
        move.b       d0, $38(a0)                                   ; $013E6E

loc_013E72:
        clr.b        ActorUpdateDelay(a0)                                       ; $013E72
        move.l       #UpdateSlowProjectile, ActorUpdateCallback(a0) ; $013E76
        move.l       #DrawSlowProjectileTile, ActorDrawCallback(a0) ; $013E7E
        move.l       #ApplyPlayerDistanceHit, ActorHitCallback(a0) ; $013E86
        ori.w        #ActorFlagAimAnyView, ActorFlags(a0)                                  ; $013E8E
        move.w       rPlayerFacingVectorX(a6), d0                                ; $013E94
        asr.w        #$1, d0                                       ; $013E98
        move.w       d0, $2e(a0)                                   ; $013E9A
        asr.w        #$1, d0                                       ; $013E9E
        add.w        rPlayerX(a6), d0                              ; $013EA0
        move.w       d0, $24(a0)                                   ; $013EA4
        move.w       rPlayerFacingVectorY(a6), d0                                ; $013EA8
        asr.w        #$1, d0                                       ; $013EAC
        move.w       d0, $30(a0)                                   ; $013EAE
        asr.w        #$1, d0                                       ; $013EB2
        add.w        rPlayerY(a6), d0                              ; $013EB4
        move.w       d0, $26(a0)                                   ; $013EB8
        move.w       rPlayerViewOffsetZ(a6), d0                                ; $013EBC
        sub.w        rTransitHeightOffset(a6), d0                                ; $013EC0
        subi.w       #$c, d0                                       ; $013EC4
        move.w       d0, $28(a0)                                   ; $013EC8
        jsr          ClassifyPlayerCellForWeapon.l                       ; $013ECC
        beq.b        loc_013EDC                                    ; $013ED2
        move.l       #ResolveSpecialCellProjectileImpact, ActorUpdateCallback(a0) ; $013ED4

loc_013EDC:
        tst.w        rLinkRole(a6)                                 ; $013EDC
        beq.b        loc_013F2E                                    ; $013EE0
        move.l       #RemoveActorAndSendLink, ActorExitCallback(a0) ; $013EE2
        move.l       #QueueActorPositionLinkCommand0F, ActorLinkCallback(a0)                ; $013EEA
        lea.l        rSharedScratchBuffer(a6), a1                                ; $013EF2
        move.b       #$4, (a1)+                                    ; $013EF6
        move.b       $42(a0), (a1)+                                ; $013EFA
        move.w       $24(a0), (a1)+                                ; $013EFE
        move.w       $26(a0), (a1)+                                ; $013F02
        move.b       $29(a0), (a1)+                                ; $013F06
        move.b       $5(a0), d0                                    ; $013F0A
        ori.w        #$20, d0                                      ; $013F0E
        move.b       d0, (a1)+                                     ; $013F12
        move.b       $36(a0), (a1)+                                ; $013F14
        move.b       #$1, (a1)+                                    ; $013F18
        move.w       $2e(a0), (a1)+                                ; $013F1C
        move.w       $30(a0), (a1)+                                ; $013F20
        lea.l        rSharedScratchBuffer(a6), a0                                ; $013F24
        jsr          QueueLinkCommand.l                            ; $013F28

loc_013F2E:
        rts                                                        ; $013F2E
        ifne *-$13F30
        fail "ROM end moved"
        endif
