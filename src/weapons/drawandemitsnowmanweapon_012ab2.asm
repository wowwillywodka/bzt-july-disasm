; $012AB2..$012CF7 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Snowman: save OLD phase, advance 1..4->0; old phases1/2/3 emit particles (phase3 can loop while held, costing $40). Same local flight/hit logic as flamethrower; CurrentWeaponId differs.
        ifne *-$12AB2
        fail "ROM start moved"
        endif

DrawAndEmitSnowmanWeapon:
; Snowman: save OLD phase, advance 1..4->0; old phases1/2/3 emit particles (phase3 can loop while held, costing $40). Same local flight/hit logic as flamethrower; CurrentWeaponId differs.
        addi.w       #$d9, d0                                      ; $012AB2
        addi.w       #$114, d1                                     ; $012AB6
        move.w       rWeaponActionPhase(a6), d7                    ; $012ABA
        lea.l        WeaponRecoilOffsets(pc), a0                   ; $012ABE
        move.w       rWeaponActionPhase(a6), d3                    ; $012AC2
        beq.b        loc_012AE0                                    ; $012AC6
        move.b       (a0, d3.w), d2                                ; $012AC8
        ext.w        d2                                            ; $012ACC
        add.w        d2, d0                                        ; $012ACE
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $012AD0
        cmpi.w       #$5, rWeaponActionPhase(a6)                   ; $012AD4
        bne.b        loc_012AE0                                    ; $012ADA
        clr.w        rWeaponActionPhase(a6)                        ; $012ADC

loc_012AE0:
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $012AE0
        move.w       d0, (a2)+                                     ; $012AE4
        move.w       rSpriteAttributeNextLink(a6), d2                                ; $012AE6
        ori.w        #$b00, d2                                     ; $012AEA
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $012AEE
        move.w       d2, (a2)+                                     ; $012AF2
        move.w       #$a4ef, (a2)+                                 ; $012AF4
        move.w       d1, (a2)+                                     ; $012AF8
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $012AFA
        tst.w        rPlayerDeathTicks(a6)                         ; $012AFE
        bne.w        loc_012CF6                                    ; $012B02
        cmpi.w       #$2, d7                                       ; $012B06
        beq.w        loc_012BBA                                    ; $012B0A
        cmpi.w       #$3, d7                                       ; $012B0E
        beq.b        loc_012B38                                    ; $012B12
        cmpi.w       #$1, d7                                       ; $012B14
        bne.w        loc_012CF6                                    ; $012B18
        clr.w        rStatusSoundScriptActive(a6)                                    ; $012B1C
        clr.w        rSoundEffectCooldown(a6)                                    ; $012B20
        move.w       #$37, d0                                      ; $012B24
        jsr          PlaySoundEventAndMaybeSendLink.l                         ; $012B28
        move.w       #$14, rSoundEffectCooldown(a6)                              ; $012B2E
        bra.w        loc_012BBA                                    ; $012B34

loc_012B38:
        btst.b       #$4, rControllerState(a6)                     ; $012B38
        beq.b        loc_012BBA                                    ; $012B3E
        move.w       #$3, rWeaponActionPhase(a6)                   ; $012B40

loc_012B46:
        tst.w        rVBlankTransferPhasesRemaining(a6)                                    ; $012B46
        bne.b        loc_012B46                                    ; $012B4A
        clr.w        d0                                            ; $012B4C
        move.b       rSelectedInventorySlot(a6), d0                ; $012B4E
        lsl.w        #$8, d0                                       ; $012B52
        lsl.w        #$1, d0                                       ; $012B54
        addi.w       #$93e0, d0                                    ; $012B56
        move.w       d0, d5                                        ; $012B5A
        movea.l      #VDP_DATA, a4                                 ; $012B5C
        lea.l        rInventorySlots(a6), a0                       ; $012B62
        clr.w        d0                                            ; $012B66
        move.b       rSelectedInventorySlot(a6), d0                ; $012B68
        mulu.w       #$4, d0                                       ; $012B6C
        cmpi.w       #$40, $2(a0, d0.w)                            ; $012B70
        bhi.b        loc_012B84                                    ; $012B76
        bsr.w        ExhaustSelectedItemAndEraseHud                ; $012B78
        move.w       #$4, rWeaponActionPhase(a6)                   ; $012B7C
        bra.b        loc_012BBA                                    ; $012B82

loc_012B84:
        subi.w       #$40, $2(a0, d0.w)                            ; $012B84
        move.w       $2(a0, d0.w), -(a7)                           ; $012B8A
        move.w       d5, d0                                        ; $012B8E
        addi.w       #$68, d0                                      ; $012B90
        move.w       d0, d1                                        ; $012B94
        andi.w       #$3fff, d1                                    ; $012B96
        ori.w        #$4000, d1                                    ; $012B9A
        swap         d1                                            ; $012B9E
        lsr.w        #$8, d0                                       ; $012BA0
        lsr.w        #$6, d0                                       ; $012BA2
        move.w       d0, d1                                        ; $012BA4
        move.l       d1, VDP_CONTROL.l                             ; $012BA6
        move.w       (a7)+, d0                                     ; $012BAC
        subq.w       #$1, d0                                       ; $012BAE
        lsr.w        #$8, d0                                       ; $012BB0
        addq.w       #$1, d0                                       ; $012BB2
        jsr          DrawInventoryQuantityDigits.l                            ; $012BB4

loc_012BBA:
        jsr          AllocateActor.l                               ; $012BBA
        beq.w        loc_012CF6                                    ; $012BC0
        move.b       #$ff, $38(a0)                                 ; $012BC4
        move.l       a0, -(a7)                                     ; $012BCA
        move.w       #$8, d1                                       ; $012BCC
        move.w       rViewSwayAngleOffset(a6), d2                                ; $012BD0
        addi.w       #$40, d2                                      ; $012BD4
        jsr          SelectPlayerWeaponAimTarget.l                 ; $012BD8
        movea.l      (a7)+, a0                                     ; $012BDE
        cmpa.l       #$0, a1                                       ; $012BE0
        beq.b        loc_012C24                                    ; $012BE6
        tst.w        rLinkRole(a6)                                 ; $012BE8
        beq.b        loc_012BFC                                    ; $012BEC
        cmpa.l       #$ff123a, a1                                  ; $012BEE
        bne.b        loc_012BFC                                    ; $012BF4
        clr.w        d0                                            ; $012BF6
        clr.w        d1                                            ; $012BF8
        bra.b        loc_012C08                                    ; $012BFA

loc_012BFC:
        move.w       $2e(a1), d0                                   ; $012BFC
        lsl.w        #$2, d0                                       ; $012C00
        move.w       $30(a1), d1                                   ; $012C02
        lsl.w        #$2, d1                                       ; $012C06

loc_012C08:
        add.w        $24(a1), d0                                   ; $012C08
        sub.w        rPlayerX(a6), d0                              ; $012C0C
        add.w        $26(a1), d1                                   ; $012C10
        sub.w        rPlayerY(a6), d1                              ; $012C14
        bsr.w        OctagonalDistance                             ; $012C18
        asr.w        #$7, d0                                       ; $012C1C
        addq.b       #$1, d0                                       ; $012C1E
        move.b       d0, $38(a0)                                   ; $012C20

loc_012C24:
        clr.b        ActorUpdateDelay(a0)                                       ; $012C24
        move.l       #UpdateSnowmanParticle, ActorUpdateCallback(a0) ; $012C28
        move.l       #DrawSharedFireEffectTile, ActorDrawCallback(a0)            ; $012C30
        move.w       rPlayerFacingVectorX(a6), d0                                ; $012C38
        asr.w        #$2, d0                                       ; $012C3C
        move.w       d0, $2e(a0)                                   ; $012C3E
        add.w        rPlayerX(a6), d0                              ; $012C42
        move.w       d0, $24(a0)                                   ; $012C46
        move.w       rPlayerFacingVectorY(a6), d0                                ; $012C4A
        asr.w        #$2, d0                                       ; $012C4E
        move.w       d0, $30(a0)                                   ; $012C50
        add.w        rPlayerY(a6), d0                              ; $012C54
        move.w       d0, $26(a0)                                   ; $012C58
        jsr          NextRandom.l                                  ; $012C5C
        asr.w        #$8, d2                                       ; $012C62
        andi.w       #$1f, d2                                      ; $012C64
        subi.w       #$10, d2                                      ; $012C68
        add.w        d2, $2e(a0)                                   ; $012C6C
        swap         d2                                            ; $012C70
        andi.w       #$1f, d2                                      ; $012C72
        subi.w       #$10, d2                                      ; $012C76
        add.w        d2, $30(a0)                                   ; $012C7A
        move.w       rPlayerViewOffsetZ(a6), d0                                ; $012C7E
        sub.w        rTransitHeightOffset(a6), d0                                ; $012C82
        subi.w       #$c, d0                                       ; $012C86
        move.w       d0, $28(a0)                                   ; $012C8A
        move.w       #$fffe, $32(a0)                               ; $012C8E
        jsr          ClassifyPlayerCellForWeapon.l                       ; $012C94
        beq.b        loc_012CA4                                    ; $012C9A
        move.l       #ResolveSpecialCellParticleImpact, ActorUpdateCallback(a0)              ; $012C9C

loc_012CA4:
        tst.w        rLinkRole(a6)                                 ; $012CA4
        beq.b        loc_012CF6                                    ; $012CA8
        move.l       #RemoveActorAndSendLink, ActorExitCallback(a0) ; $012CAA
        move.l       #QueueActorPositionLinkCommand0EFlag04, ActorLinkCallback(a0)                ; $012CB2
        lea.l        rSharedScratchBuffer(a6), a1                                ; $012CBA
        move.b       #$4, (a1)+                                    ; $012CBE
        move.b       $42(a0), (a1)+                                ; $012CC2
        move.w       $24(a0), (a1)+                                ; $012CC6
        move.w       $26(a0), (a1)+                                ; $012CCA
        move.b       $29(a0), (a1)+                                ; $012CCE
        move.b       $5(a0), d0                                    ; $012CD2
        ori.w        #$20, d0                                      ; $012CD6
        move.b       d0, (a1)+                                     ; $012CDA
        move.b       $36(a0), (a1)+                                ; $012CDC
        move.b       #$4, (a1)+                                    ; $012CE0
        move.w       $2e(a0), (a1)+                                ; $012CE4
        move.w       $30(a0), (a1)+                                ; $012CE8
        lea.l        rSharedScratchBuffer(a6), a0                                ; $012CEC
        jsr          QueueLinkCommand.l                            ; $012CF0

loc_012CF6:
        rts                                                        ; $012CF6
        ifne *-$12CF8
        fail "ROM end moved"
        endif
