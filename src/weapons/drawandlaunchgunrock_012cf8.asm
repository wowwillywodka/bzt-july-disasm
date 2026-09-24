; $012CF8..$012ECD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Gunrock: phase1->2 emits one bouncing projectile; animation ends at5->0. Player actor flight uses shared UpdateBouncingProjectile; initial VelocityZ=18.
        ifne *-$12CF8
        fail "ROM start moved"
        endif

DrawAndLaunchGunrock:
; Gunrock: phase1->2 emits one bouncing projectile; animation ends at5->0. Player actor flight uses shared UpdateBouncingProjectile; initial VelocityZ=18.
        addi.w       #$e1, d0                                      ; $012CF8
        addi.w       #$120, d1                                     ; $012CFC
        lea.l        WeaponRecoilOffsets(pc), a0                   ; $012D00
        move.w       rWeaponActionPhase(a6), d3                    ; $012D04
        beq.b        loc_012D24                                    ; $012D08
        move.b       (a0, d3.w), d2                                ; $012D0A
        ext.w        d2                                            ; $012D0E
        add.w        d2, d0                                        ; $012D10
        add.w        d2, d1                                        ; $012D12
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $012D14
        cmpi.w       #$5, rWeaponActionPhase(a6)                   ; $012D18
        bne.b        loc_012D24                                    ; $012D1E
        clr.w        rWeaponActionPhase(a6)                        ; $012D20

loc_012D24:
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $012D24
        move.w       d0, (a2)+                                     ; $012D28
        move.w       rSpriteAttributeNextLink(a6), d2                                ; $012D2A
        ori.w        #$e00, d2                                     ; $012D2E
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $012D32
        move.w       d2, (a2)+                                     ; $012D36
        move.w       #$a4ef, (a2)+                                 ; $012D38
        move.w       d1, (a2)+                                     ; $012D3C
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $012D3E
        cmpi.w       #$2, rWeaponActionPhase(a6)                   ; $012D42
        bne.w        loc_013842                                    ; $012D48
        subq.w       #$5, d1                                       ; $012D4C
        subq.w       #$8, d0                                       ; $012D4E
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $012D50
        move.w       d0, (a2)+                                     ; $012D54
        move.w       rSpriteAttributeNextLink(a6), d2                                ; $012D56
        ori.w        #$a00, d2                                     ; $012D5A
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $012D5E
        move.w       d2, (a2)+                                     ; $012D62
        move.w       #$a4fb, (a2)+                                 ; $012D64
        move.w       d1, (a2)+                                     ; $012D68
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $012D6A
        jsr          AllocateActor.l                               ; $012D6E
        beq.w        loc_012ECC                                    ; $012D74
        move.w       rPlayerFacingVectorX(a6), d0                                ; $012D78
        asr.w        #$2, d0                                       ; $012D7C
        move.w       d0, $2e(a0)                                   ; $012D7E
        add.w        rPlayerX(a6), d0                              ; $012D82
        move.w       d0, $24(a0)                                   ; $012D86
        move.w       rPlayerFacingVectorY(a6), d0                                ; $012D8A
        asr.w        #$2, d0                                       ; $012D8E
        move.w       d0, $30(a0)                                   ; $012D90
        add.w        rPlayerY(a6), d0                              ; $012D94
        move.w       d0, $26(a0)                                   ; $012D98
        move.b       #$32, $38(a0)                                 ; $012D9C
        move.l       a0, -(a7)                                     ; $012DA2
        move.w       #$10, d1                                      ; $012DA4
        move.w       rViewSwayAngleOffset(a6), d2                                ; $012DA8
        addi.w       #$40, d2                                      ; $012DAC
        jsr          SelectPlayerWeaponAimTarget.l                 ; $012DB0
        movea.l      (a7)+, a0                                     ; $012DB6
        cmpa.l       #$0, a1                                       ; $012DB8
        beq.b        loc_012E18                                    ; $012DBE
        tst.w        rLinkRole(a6)                                 ; $012DC0
        beq.b        loc_012DD4                                    ; $012DC4
        cmpa.l       #$ff123a, a1                                  ; $012DC6
        bne.b        loc_012DD4                                    ; $012DCC
        clr.w        d0                                            ; $012DCE
        clr.w        d1                                            ; $012DD0
        bra.b        loc_012DE0                                    ; $012DD2

loc_012DD4:
        move.w       $2e(a1), d0                                   ; $012DD4
        lsl.w        #$2, d0                                       ; $012DD8
        move.w       $30(a1), d1                                   ; $012DDA
        lsl.w        #$2, d1                                       ; $012DDE

loc_012DE0:
        add.w        $24(a1), d0                                   ; $012DE0
        sub.w        rPlayerX(a6), d0                              ; $012DE4
        add.w        $26(a1), d1                                   ; $012DE8
        sub.w        rPlayerY(a6), d1                              ; $012DEC
        bsr.w        OctagonalDistance                             ; $012DF0
        move.w       d0, d1                                        ; $012DF4
        asr.w        #$6, d1                                       ; $012DF6
        addq.w       #$8, d1                                       ; $012DF8
        move.b       d1, $38(a0)                                   ; $012DFA
; Original writes scaled velocity to A1=TARGET at +$2E/+$30, not new projectile A0. Same defect exists in hand-grenade path. Preserve bytes.
        move.w       d0, d1                                        ; $012DFE
        muls.w       $2e(a1), d0                                   ; $012E00
        asr.l        #$8, d0                                       ; $012E04
        asr.l        #$3, d0                                       ; $012E06
        move.w       d0, $2e(a1)                                   ; $012E08
        muls.w       $30(a1), d1                                   ; $012E0C
        asr.l        #$8, d1                                       ; $012E10
        asr.l        #$3, d1                                       ; $012E12
        move.w       d1, $30(a1)                                   ; $012E14

loc_012E18:
        clr.b        ActorUpdateDelay(a0)                                       ; $012E18
        move.l       #UpdateBouncingProjectile, ActorUpdateCallback(a0) ; $012E1C
        move.l       #DrawGunrockProjectileTile, ActorDrawCallback(a0) ; $012E24
        move.l       #ExplodeProjectileOnNearHit, ActorHitCallback(a0) ; $012E2C
        ori.w        #ActorFlagAimAnyView, ActorFlags(a0)                                  ; $012E34
        move.w       rPlayerViewOffsetZ(a6), d0                                ; $012E3A
        sub.w        rTransitHeightOffset(a6), d0                                ; $012E3E
        subq.w       #$6, d0                                       ; $012E42
        move.w       d0, $28(a0)                                   ; $012E44
        move.w       #$12, $32(a0)                                 ; $012E48
        jsr          ClassifyPlayerCellForWeapon.l                       ; $012E4E
        beq.b        loc_012E5E                                    ; $012E54
        move.l       #ResolveSpecialCellProjectileImpact, ActorUpdateCallback(a0) ; $012E56

loc_012E5E:
; Character1 doubles projectile XY velocity; fuse is (byte(fuse+1) ASR.B 1), with signed byte wrap behavior.
        cmpi.w       #$1, rSelectedCharacter(a6)                   ; $012E5E
        bne.b        loc_012E7A                                    ; $012E64
        lsl.w        $2e(a0)                                       ; $012E66
        lsl.w        $30(a0)                                       ; $012E6A
        move.b       $38(a0), d0                                   ; $012E6E
        addq.b       #$1, d0                                       ; $012E72
        asr.b        #$1, d0                                       ; $012E74
        move.b       d0, $38(a0)                                   ; $012E76

loc_012E7A:
        tst.w        rLinkRole(a6)                                 ; $012E7A
        beq.b        loc_012ECC                                    ; $012E7E
        move.l       #RemoveActorAndSendLink, ActorExitCallback(a0) ; $012E80
        move.l       #QueueActorPositionLinkCommand, ActorLinkCallback(a0)   ; $012E88
        lea.l        rSharedScratchBuffer(a6), a1                                ; $012E90
        move.b       #$4, (a1)+                                    ; $012E94
        move.b       $42(a0), (a1)+                                ; $012E98
        move.w       $24(a0), (a1)+                                ; $012E9C
        move.w       $26(a0), (a1)+                                ; $012EA0
        move.b       $29(a0), (a1)+                                ; $012EA4
        move.b       $5(a0), d0                                    ; $012EA8
        ori.w        #$20, d0                                      ; $012EAC
        move.b       d0, (a1)+                                     ; $012EB0
        move.b       $36(a0), (a1)+                                ; $012EB2
        move.b       #$0, (a1)+                                    ; $012EB6
        move.w       $2e(a0), (a1)+                                ; $012EBA
        move.w       $30(a0), (a1)+                                ; $012EBE
        lea.l        rSharedScratchBuffer(a6), a0                                ; $012EC2
        jsr          QueueLinkCommand.l                            ; $012EC6

loc_012ECC:
        rts                                                        ; $012ECC
        ifne *-$12ECE
        fail "ROM end moved"
        endif
