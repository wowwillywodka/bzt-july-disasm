; $012EF6..$0130C5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Hand grenade: advance phase; old phase3->4 emits once; phase5->0 ends. Initial VelocityZ=8. Uses same bouncing flight as Gunrock.
        ifne *-$12EF6
        fail "ROM start moved"
        endif

DrawAndThrowHandGrenade:
; Hand grenade: advance phase; old phase3->4 emits once; phase5->0 ends. Initial VelocityZ=8. Uses same bouncing flight as Gunrock.
        addi.w       #$e8, d0                                      ; $012EF6
        addi.w       #$134, d1                                     ; $012EFA
        move.w       rWeaponActionPhase(a6), d3                    ; $012EFE
        bne.b        loc_012F2A                                    ; $012F02
        cmpi.w       #$f8, d0                                      ; $012F04
        bcc.b        loc_012F28                                    ; $012F08
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $012F0A
        move.w       d0, (a2)+                                     ; $012F0E
        move.w       rSpriteAttributeNextLink(a6), d2                                ; $012F10
        ori.w        #$b00, d2                                     ; $012F14
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $012F18
        move.w       d2, (a2)+                                     ; $012F1C
        move.w       #$a4ef, (a2)+                                 ; $012F1E
        move.w       d1, (a2)+                                     ; $012F22
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $012F24

loc_012F28:
        rts                                                        ; $012F28

loc_012F2A:
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $012F2A
        cmpi.w       #$6, rWeaponActionPhase(a6)                   ; $012F2E
        bne.b        loc_012F3A                                    ; $012F34
        clr.w        rWeaponActionPhase(a6)                        ; $012F36

loc_012F3A:
        subq.w       #$1, d3                                       ; $012F3A
        lsl.w        #$3, d3                                       ; $012F3C
        lea.l        HandGrenadeActionSpriteMappings(pc), a0                  ; $012F3E
        adda.w       d3, a0                                        ; $012F42
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $012F44
        move.w       (a0)+, (a2)+                                  ; $012F48
        move.w       rSpriteAttributeNextLink(a6), d2                                ; $012F4A
        or.w         (a0)+, d2                                     ; $012F4E
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $012F50
        move.w       d2, (a2)+                                     ; $012F54
        move.l       (a0)+, (a2)+                                  ; $012F56
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $012F58
        cmpi.w       #$4, rWeaponActionPhase(a6)                   ; $012F5C
        bne.w        loc_0130C4                                    ; $012F62
        jsr          AllocateActor.l                               ; $012F66
        beq.w        loc_0130C4                                    ; $012F6C
        move.w       rPlayerFacingVectorX(a6), d0                                ; $012F70
        asr.w        #$2, d0                                       ; $012F74
        move.w       d0, $2e(a0)                                   ; $012F76
        add.w        rPlayerX(a6), d0                              ; $012F7A
        move.w       d0, $24(a0)                                   ; $012F7E
        move.w       rPlayerFacingVectorY(a6), d0                                ; $012F82
        asr.w        #$2, d0                                       ; $012F86
        move.w       d0, $30(a0)                                   ; $012F88
        add.w        rPlayerY(a6), d0                              ; $012F8C
        move.w       d0, $26(a0)                                   ; $012F90
        move.b       #$32, $38(a0)                                 ; $012F94
        move.l       a0, -(a7)                                     ; $012F9A
        move.w       #$10, d1                                      ; $012F9C
        move.w       rViewSwayAngleOffset(a6), d2                                ; $012FA0
        addi.w       #$40, d2                                      ; $012FA4
        jsr          SelectPlayerWeaponAimTarget.l                 ; $012FA8
        movea.l      (a7)+, a0                                     ; $012FAE
        cmpa.l       #$0, a1                                       ; $012FB0
        beq.b        loc_013010                                    ; $012FB6
        tst.w        rLinkRole(a6)                                 ; $012FB8
        beq.b        loc_012FCC                                    ; $012FBC
        cmpa.l       #$ff123a, a1                                  ; $012FBE
        bne.b        loc_012FCC                                    ; $012FC4
        clr.w        d0                                            ; $012FC6
        clr.w        d1                                            ; $012FC8
        bra.b        loc_012FD8                                    ; $012FCA

loc_012FCC:
        move.w       $2e(a1), d0                                   ; $012FCC
        lsl.w        #$2, d0                                       ; $012FD0
        move.w       $30(a1), d1                                   ; $012FD2
        lsl.w        #$2, d1                                       ; $012FD6

loc_012FD8:
        add.w        $24(a1), d0                                   ; $012FD8
        sub.w        rPlayerX(a6), d0                              ; $012FDC
        add.w        $26(a1), d1                                   ; $012FE0
        sub.w        rPlayerY(a6), d1                              ; $012FE4
        bsr.w        OctagonalDistance                             ; $012FE8
        move.w       d0, d1                                        ; $012FEC
        asr.w        #$6, d1                                       ; $012FEE
        addq.w       #$8, d1                                       ; $012FF0
        move.b       d1, $38(a0)                                   ; $012FF2
; Original velocity scaling writes to target A1, not projectile A0. See Gunrock counterpart and tests.
        move.w       d0, d1                                        ; $012FF6
        muls.w       $2e(a1), d0                                   ; $012FF8
        asr.l        #$8, d0                                       ; $012FFC
        asr.l        #$3, d0                                       ; $012FFE
        move.w       d0, $2e(a1)                                   ; $013000
        muls.w       $30(a1), d1                                   ; $013004
        asr.l        #$8, d1                                       ; $013008
        asr.l        #$3, d1                                       ; $01300A
        move.w       d1, $30(a1)                                   ; $01300C

loc_013010:
        clr.b        ActorUpdateDelay(a0)                                       ; $013010
        move.l       #UpdateBouncingProjectile, ActorUpdateCallback(a0) ; $013014
        move.l       #DrawGunrockProjectileTile, ActorDrawCallback(a0) ; $01301C
        move.l       #ExplodeProjectileOnNearHit, ActorHitCallback(a0) ; $013024
        ori.w        #ActorFlagAimAnyView, ActorFlags(a0)                                  ; $01302C
        move.w       rPlayerViewOffsetZ(a6), d0                                ; $013032
        sub.w        rTransitHeightOffset(a6), d0                                ; $013036
        subq.w       #$6, d0                                       ; $01303A
        move.w       d0, $28(a0)                                   ; $01303C
        move.w       #$8, $32(a0)                                  ; $013040
        jsr          ClassifyPlayerCellForWeapon.l                       ; $013046
        beq.b        loc_013056                                    ; $01304C
        move.l       #ResolveSpecialCellProjectileImpact, ActorUpdateCallback(a0) ; $01304E

loc_013056:
        cmpi.w       #$1, rSelectedCharacter(a6)                   ; $013056
        bne.b        loc_013072                                    ; $01305C
        lsl.w        $2e(a0)                                       ; $01305E
        lsl.w        $30(a0)                                       ; $013062
        move.b       $38(a0), d0                                   ; $013066
        addq.b       #$1, d0                                       ; $01306A
        asr.b        #$1, d0                                       ; $01306C
        move.b       d0, $38(a0)                                   ; $01306E

loc_013072:
        tst.w        rLinkRole(a6)                                 ; $013072
        beq.b        loc_0130C4                                    ; $013076
        move.l       #RemoveActorAndSendLink, ActorExitCallback(a0) ; $013078
        move.l       #QueueActorPositionLinkCommand, ActorLinkCallback(a0)   ; $013080
        lea.l        rSharedScratchBuffer(a6), a1                                ; $013088
        move.b       #$4, (a1)+                                    ; $01308C
        move.b       $42(a0), (a1)+                                ; $013090
        move.w       $24(a0), (a1)+                                ; $013094
        move.w       $26(a0), (a1)+                                ; $013098
        move.b       $29(a0), (a1)+                                ; $01309C
        move.b       $5(a0), d0                                    ; $0130A0
        ori.w        #$20, d0                                      ; $0130A4
        move.b       d0, (a1)+                                     ; $0130A8
        move.b       $36(a0), (a1)+                                ; $0130AA
        move.b       #$0, (a1)+                                    ; $0130AE
        move.w       $2e(a0), (a1)+                                ; $0130B2
        move.w       $30(a0), (a1)+                                ; $0130B6
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0130BA
        jsr          QueueLinkCommand.l                            ; $0130BE

loc_0130C4:
        rts                                                        ; $0130C4
        ifne *-$130C6
        fail "ROM end moved"
        endif
