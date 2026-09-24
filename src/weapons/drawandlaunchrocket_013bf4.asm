; $013BF4..$013D91 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Rocket: old phase1->2 emits once. Flight=UpdatePlayerRocket, hit=ExplodeProjectileOnNearHit, velocity=forward ASR1, spawn offset=forward ASR2.
        ifne *-$13BF4
        fail "ROM start moved"
        endif

DrawAndLaunchRocket:
; Rocket: old phase1->2 emits once. Flight=UpdatePlayerRocket, hit=ExplodeProjectileOnNearHit, velocity=forward ASR1, spawn offset=forward ASR2.
        addi.w       #$e1, d0                                      ; $013BF4
        addi.w       #$120, d1                                     ; $013BF8
        lea.l        WeaponRecoilOffsets(pc), a0                   ; $013BFC
        move.w       rWeaponActionPhase(a6), d3                    ; $013C00
        beq.b        loc_013C20                                    ; $013C04
        move.b       (a0, d3.w), d2                                ; $013C06
        ext.w        d2                                            ; $013C0A
        add.w        d2, d0                                        ; $013C0C
        add.w        d2, d1                                        ; $013C0E
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $013C10
        cmpi.w       #$5, rWeaponActionPhase(a6)                   ; $013C14
        bne.b        loc_013C20                                    ; $013C1A
        clr.w        rWeaponActionPhase(a6)                        ; $013C1C

loc_013C20:
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $013C20
        move.w       d0, (a2)+                                     ; $013C24
        move.w       rSpriteAttributeNextLink(a6), d2                                ; $013C26
        ori.w        #$e00, d2                                     ; $013C2A
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $013C2E
        move.w       d2, (a2)+                                     ; $013C32
        move.w       #$a4ef, (a2)+                                 ; $013C34
        move.w       d1, (a2)+                                     ; $013C38
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $013C3A
        cmpi.w       #$2, rWeaponActionPhase(a6)                   ; $013C3E
        bne.w        loc_013D90                                    ; $013C44
        subq.w       #$5, d1                                       ; $013C48
        subq.w       #$8, d0                                       ; $013C4A
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $013C4C
        move.w       d0, (a2)+                                     ; $013C50
        move.w       rSpriteAttributeNextLink(a6), d2                                ; $013C52
        ori.w        #$a00, d2                                     ; $013C56
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $013C5A
        move.w       d2, (a2)+                                     ; $013C5E
        move.w       #$a4fb, (a2)+                                 ; $013C60
        move.w       d1, (a2)+                                     ; $013C64
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $013C66
        jsr          AllocateActor.l                               ; $013C6A
        beq.w        loc_013D90                                    ; $013C70
        move.b       #$ff, $38(a0)                                 ; $013C74
        move.l       a0, -(a7)                                     ; $013C7A
        move.w       #$8, d1                                       ; $013C7C
        move.w       rViewSwayAngleOffset(a6), d2                                ; $013C80
        addi.w       #$40, d2                                      ; $013C84
        jsr          SelectPlayerWeaponAimTarget.l                 ; $013C88
        movea.l      (a7)+, a0                                     ; $013C8E
        cmpa.l       #$0, a1                                       ; $013C90
        beq.b        loc_013CD4                                    ; $013C96
        tst.w        rLinkRole(a6)                                 ; $013C98
        beq.b        loc_013CAC                                    ; $013C9C
        cmpa.l       #$ff123a, a1                                  ; $013C9E
        bne.b        loc_013CAC                                    ; $013CA4
        clr.w        d0                                            ; $013CA6
        clr.w        d1                                            ; $013CA8
        bra.b        loc_013CB8                                    ; $013CAA

loc_013CAC:
        move.w       $2e(a1), d0                                   ; $013CAC
        lsl.w        #$2, d0                                       ; $013CB0
        move.w       $30(a1), d1                                   ; $013CB2
        lsl.w        #$2, d1                                       ; $013CB6

loc_013CB8:
        add.w        $24(a1), d0                                   ; $013CB8
        sub.w        rPlayerX(a6), d0                              ; $013CBC
        add.w        $26(a1), d1                                   ; $013CC0
        sub.w        rPlayerY(a6), d1                              ; $013CC4
        bsr.w        OctagonalDistance                             ; $013CC8
        asr.w        #$7, d0                                       ; $013CCC
        addq.b       #$1, d0                                       ; $013CCE
        move.b       d0, $38(a0)                                   ; $013CD0

loc_013CD4:
        clr.b        ActorUpdateDelay(a0)                                       ; $013CD4
        move.l       #UpdatePlayerRocket, ActorUpdateCallback(a0)  ; $013CD8
        move.l       #DrawSharedFireEffectTile, ActorDrawCallback(a0)            ; $013CE0
        move.l       #ExplodeProjectileOnNearHit, ActorHitCallback(a0) ; $013CE8
        ori.w        #ActorFlagAimAnyView, ActorFlags(a0)                                  ; $013CF0
        move.w       rPlayerFacingVectorX(a6), d0                                ; $013CF6
        asr.w        #$1, d0                                       ; $013CFA
        move.w       d0, $2e(a0)                                   ; $013CFC
        asr.w        #$1, d0                                       ; $013D00
        add.w        rPlayerX(a6), d0                              ; $013D02
        move.w       d0, $24(a0)                                   ; $013D06
        move.w       rPlayerFacingVectorY(a6), d0                                ; $013D0A
        asr.w        #$1, d0                                       ; $013D0E
        move.w       d0, $30(a0)                                   ; $013D10
        asr.w        #$1, d0                                       ; $013D14
        add.w        rPlayerY(a6), d0                              ; $013D16
        move.w       d0, $26(a0)                                   ; $013D1A
        move.w       rPlayerViewOffsetZ(a6), d0                                ; $013D1E
        sub.w        rTransitHeightOffset(a6), d0                                ; $013D22
        subi.w       #$c, d0                                       ; $013D26
        move.w       d0, $28(a0)                                   ; $013D2A
        jsr          ClassifyPlayerCellForWeapon.l                       ; $013D2E
        beq.b        loc_013D3E                                    ; $013D34
        move.l       #ResolveSpecialCellProjectileImpact, ActorUpdateCallback(a0) ; $013D36

loc_013D3E:
        tst.w        rLinkRole(a6)                                 ; $013D3E
        beq.b        loc_013D90                                    ; $013D42
        move.l       #RemoveActorAndSendLink, ActorExitCallback(a0) ; $013D44
        move.l       #QueueActorPositionLinkCommand0F, ActorLinkCallback(a0)                ; $013D4C
        lea.l        rSharedScratchBuffer(a6), a1                                ; $013D54
        move.b       #$4, (a1)+                                    ; $013D58
        move.b       $42(a0), (a1)+                                ; $013D5C
        move.w       $24(a0), (a1)+                                ; $013D60
        move.w       $26(a0), (a1)+                                ; $013D64
        move.b       $29(a0), (a1)+                                ; $013D68
        move.b       $5(a0), d0                                    ; $013D6C
        ori.w        #$20, d0                                      ; $013D70
        move.b       d0, (a1)+                                     ; $013D74
        move.b       $36(a0), (a1)+                                ; $013D76
        move.b       #$1, (a1)+                                    ; $013D7A
        move.w       $2e(a0), (a1)+                                ; $013D7E
        move.w       $30(a0), (a1)+                                ; $013D82
        lea.l        rSharedScratchBuffer(a6), a0                                ; $013D86
        jsr          QueueLinkCommand.l                            ; $013D8A

loc_013D90:
        rts                                                        ; $013D90
        ifne *-$13D92
        fail "ROM end moved"
        endif
