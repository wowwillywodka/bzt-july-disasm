; $0146EC..$0147A1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Laser Aimed Gun initial shot: lowering guard only, consume$100; linear distance parameter, character0 halves, unsigned word threshold<$400. Continuation in draw uses another formula.
        ifne *-$146EC
        fail "ROM start moved"
        endif

FireLaserAimedGun:
; Laser Aimed Gun initial shot: lowering guard only, consume$100; linear distance parameter, character0 halves, unsigned word threshold<$400. Continuation in draw uses another formula.
        tst.w        rWeaponLoweringOffset(a6)                     ; $0146EC
        bne.w        loc_0147A0                                    ; $0146F0
        clr.w        rStatusSoundScriptActive(a6)                                    ; $0146F4
        clr.w        rSoundEffectCooldown(a6)                                    ; $0146F8
        move.w       #$1e, d0                                      ; $0146FC
        jsr          PlaySoundEventAndMaybeSendLink.l                         ; $014700
        move.w       #$f, rSoundEffectCooldown(a6)                               ; $014706
        move.w       #$1, rWeaponActionPhase(a6)                   ; $01470C
        bsr.w        ConsumeSelectedItemAndUpdateHud               ; $014712
        move.l       d0, -(a7)                                     ; $014716
        move.w       #$1, d0                                       ; $014718
        move.w       rPlayerX(a6), d1                              ; $01471C
        move.w       rPlayerY(a6), d2                              ; $014720
        bsr.w        ActivateEpisode1WallStages                    ; $014724
        move.l       (a7)+, d0                                     ; $014728
        move.w       #$8, d1                                       ; $01472A
        cmpi.w       #$0, rSelectedCharacter(a6)                   ; $01472E
        bne.b        loc_01473A                                    ; $014734
        move.w       #$c, d1                                       ; $014736

loc_01473A:
        move.w       rViewSwayAngleOffset(a6), d2                                ; $01473A
        addi.w       #$40, d2                                      ; $01473E
        jsr          SelectPlayerWeaponAimTarget.l                 ; $014742
        cmpa.l       #$0, a1                                       ; $014748
        beq.b        loc_01478E                                    ; $01474E
        movea.l      a1, a0                                        ; $014750
        move.w       $24(a0), d0                                   ; $014752
        sub.w        rPlayerX(a6), d0                              ; $014756
        move.w       $26(a0), d1                                   ; $01475A
        sub.w        rPlayerY(a6), d1                              ; $01475E
        bsr.w        OctagonalDistance                             ; $014762
        cmpi.w       #$0, rSelectedCharacter(a6)                   ; $014766
        bne.b        loc_014770                                    ; $01476C
        asr.w        #$1, d0                                       ; $01476E

loc_014770:
        cmpi.w       #$400, d0                                     ; $014770
        bcc.b        loc_0147A0                                    ; $014774
        move.w       rPlayerX(a6), d3                              ; $014776
        move.w       rPlayerY(a6), d4                              ; $01477A
        sub.w        $24(a0), d3                                   ; $01477E
        sub.w        $26(a0), d4                                   ; $014782
        movea.l      ActorHitCallback(a0), a1                      ; $014786
        jsr          (a1)                                          ; $01478A
        bra.b        loc_0147A0                                    ; $01478C

loc_01478E:
        jsr          ClassifyPlayerCellForWeapon.l                       ; $01478E
        bne.b        loc_01479A                                    ; $014794
        bsr.w        TraceMissedShotAndSpawnImpact                 ; $014796

loc_01479A:
        jsr          TraceShotToDamageablePanel.l                  ; $01479A

loc_0147A0:
        rts                                                        ; $0147A0
        ifne *-$147A2
        fail "ROM end moved"
        endif
