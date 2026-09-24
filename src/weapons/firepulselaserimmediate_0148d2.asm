; $0148D2..$014989 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Pulse Laser immediate0E: linear hit with LONG threshold like Shotgun. Normal ammo helper zeroes upper D0; no division remainder is copied into it by target selection.
        ifne *-$148D2
        fail "ROM start moved"
        endif

FirePulseLaserImmediate:
; Pulse Laser immediate0E: linear hit with LONG threshold like Shotgun. Normal ammo helper zeroes upper D0; no division remainder is copied into it by target selection.
        tst.w        rWeaponLoweringOffset(a6)                     ; $0148D2
        bne.w        loc_014988                                    ; $0148D6
        clr.w        rStatusSoundScriptActive(a6)                                    ; $0148DA
        clr.w        rSoundEffectCooldown(a6)                                    ; $0148DE
        move.w       #$1e, d0                                      ; $0148E2
        jsr          PlaySoundEventAndMaybeSendLink.l                         ; $0148E6
        move.w       #$f, rSoundEffectCooldown(a6)                               ; $0148EC
        move.w       #$1, rWeaponActionPhase(a6)                   ; $0148F2
        bsr.w        ConsumeSelectedItemAndUpdateHud               ; $0148F8
        move.l       d0, -(a7)                                     ; $0148FC
        move.w       #$1, d0                                       ; $0148FE
        move.w       rPlayerX(a6), d1                              ; $014902
        move.w       rPlayerY(a6), d2                              ; $014906
        bsr.w        ActivateEpisode1WallStages                    ; $01490A
        move.l       (a7)+, d0                                     ; $01490E
        move.w       #$8, d1                                       ; $014910
        cmpi.w       #$0, rSelectedCharacter(a6)                   ; $014914
        bne.b        loc_014920                                    ; $01491A
        move.w       #$c, d1                                       ; $01491C

loc_014920:
        move.w       rViewSwayAngleOffset(a6), d2                                ; $014920
        addi.w       #$40, d2                                      ; $014924
        jsr          SelectPlayerWeaponAimTarget.l                 ; $014928
        cmpa.l       #$0, a1                                       ; $01492E
        beq.b        loc_014976                                    ; $014934
        movea.l      a1, a0                                        ; $014936
        move.w       $24(a0), d0                                   ; $014938
        sub.w        rPlayerX(a6), d0                              ; $01493C
        move.w       $26(a0), d1                                   ; $014940
        sub.w        rPlayerY(a6), d1                              ; $014944
        bsr.w        OctagonalDistance                             ; $014948
        cmpi.w       #$0, rSelectedCharacter(a6)                   ; $01494C
        bne.b        loc_014956                                    ; $014952
        asr.w        #$1, d0                                       ; $014954

loc_014956:
        cmpi.l       #$400, d0                                     ; $014956
        bcc.b        loc_014988                                    ; $01495C
        move.w       rPlayerX(a6), d3                              ; $01495E
        move.w       rPlayerY(a6), d4                              ; $014962
        sub.w        $24(a0), d3                                   ; $014966
        sub.w        $26(a0), d4                                   ; $01496A
        movea.l      ActorHitCallback(a0), a1                      ; $01496E
        jsr          (a1)                                          ; $014972
        bra.b        loc_014988                                    ; $014974

loc_014976:
        jsr          ClassifyPlayerCellForWeapon.l                       ; $014976
        bne.b        loc_014982                                    ; $01497C
        bsr.w        TraceMissedShotAndSpawnImpact                 ; $01497E

loc_014982:
        jsr          TraceShotToDamageablePanel.l                  ; $014982

loc_014988:
        rts                                                        ; $014988
        ifne *-$1498A
        fail "ROM end moved"
        endif
