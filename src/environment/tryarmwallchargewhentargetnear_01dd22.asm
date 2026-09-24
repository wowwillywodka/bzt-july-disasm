; $01DD22..$01DD81 | m68k
; Maintained assembly input; no extraction occurs during build.
; State 0: select a target; arm countdown only inside range with clear rays.
        ifne *-$1DD22
        fail "ROM start moved"
        endif

TryArmWallChargeWhenTargetNear:
        bsr.w        SelectEnemyPlayerTarget                       ; $01DD22
        cmpa.l       #$0, a1                                       ; $01DD26
        beq.w        RestoreWallChargeCellAndRemove                     ; $01DD2C
        move.w       ActorX(a0), d0                                ; $01DD30
        sub.w        ActorX(a1), d0                                   ; $01DD34
        move.w       ActorY(a0), d1                                ; $01DD38
        sub.w        ActorY(a1), d1                                   ; $01DD3C
        jsr          OctagonalDistance.l                           ; $01DD40
        cmpi.w       #$c00, d0                                     ; $01DD46
        bhi.w        RestoreWallChargeCellAndRemove                     ; $01DD4A
        cmpa.l       #ramPlayerActorProxy, a1                                  ; $01DD4E
        bne.b        loc_01DD64                                    ; $01DD54
        cmpi.w       #$4, rSelectedCharacter(a6)                   ; $01DD56
        bne.b        loc_01DD64                                    ; $01DD5C
        cmpi.w       #$180, d0                                     ; $01DD5E
        bhi.b        loc_01DD80                                    ; $01DD62

loc_01DD64:
        cmpi.w       #$300, d0                                     ; $01DD64
        bhi.b        loc_01DD80                                    ; $01DD68
        move.w       ActorX(a1), d0                                   ; $01DD6A
        move.w       ActorY(a1), d1                                   ; $01DD6E
        move.w       ActorX(a0), d3                                ; $01DD72
        move.w       ActorY(a0), d4                                ; $01DD76
        bsr.w        TraceFiveRayObstructionInActiveWindow         ; $01DD7A
        beq.b        StartWallChargeCountdown                         ; $01DD7E

loc_01DD80:
        rts                                                        ; $01DD80
        ifne *-$1DD82
        fail "ROM end moved"
        endif
