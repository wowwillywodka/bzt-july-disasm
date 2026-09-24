; $01DDA6..$01DDD3 | m68k
; Maintained assembly input; no extraction occurs during build.
; State 2+: retire charge when target is missing or beyond $C00.
        ifne *-$1DDA6
        fail "ROM start moved"
        endif

RetireWallChargeWhenTargetFar:
        bsr.w        SelectEnemyPlayerTarget                       ; $01DDA6
        cmpa.l       #$0, a1                                       ; $01DDAA
        beq.w        RestoreWallChargeCellAndRemove                     ; $01DDB0
        move.w       ActorX(a0), d0                                ; $01DDB4
        sub.w        ActorX(a1), d0                                   ; $01DDB8
        move.w       ActorY(a0), d1                                ; $01DDBC
        sub.w        ActorY(a1), d1                                   ; $01DDC0
        jsr          OctagonalDistance.l                           ; $01DDC4
        cmpi.w       #$c00, d0                                     ; $01DDCA
        bhi.w        RestoreWallChargeCellAndRemove                     ; $01DDCE
        rts                                                        ; $01DDD2
        ifne *-$1DDD4
        fail "ROM end moved"
        endif
