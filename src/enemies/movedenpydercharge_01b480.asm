; $01B480..$01B503 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Charge/default state: decrement counter; zero finishes immediately. Every remaining multiple of4 refresh target goal. Components ASR1 clamped +/-72. Returned vector length<=10 (actual delta only if ActorMarkerTracked=0) also finishes.
        ifne *-$1B480
        fail "ROM start moved"
        endif

MoveDenpyderCharge:
; Charge/default state: decrement counter; zero finishes immediately. Every remaining multiple of4 refresh target goal. Components ASR1 clamped +/-72. Returned vector length<=10 (actual delta only if ActorMarkerTracked=0) also finishes.
        subq.b       #$1, ActorStateCounter(a0)                    ; $01B480
        beq.b        FinishDenpyderChargeAndTryHit                 ; $01B484
        move.b       ActorStateCounter(a0), d0                     ; $01B486
        andi.w       #$3, d0                                       ; $01B48A
        bne.b        loc_01B4A0                                    ; $01B48E
        movea.l      ActorTarget(a0), a3                           ; $01B490
        move.w       ActorX(a3), ActorGoalX(a0)                    ; $01B494
        move.w       ActorY(a3), ActorGoalY(a0)                    ; $01B49A

loc_01B4A0:
        move.w       ActorGoalX(a0), d0                            ; $01B4A0
        sub.w        ActorX(a0), d0                                ; $01B4A4
        asr.w        #$1, d0                                       ; $01B4A8
        beq.b        loc_01B4C4                                    ; $01B4AA
        bpl.b        loc_01B4BA                                    ; $01B4AC
        cmpi.w       #$ffb8, d0                                    ; $01B4AE
        bge.b        loc_01B4C4                                    ; $01B4B2
        move.w       #$ffb8, d0                                    ; $01B4B4
        bra.b        loc_01B4C4                                    ; $01B4B8

loc_01B4BA:
        cmpi.w       #$48, d0                                      ; $01B4BA
        ble.b        loc_01B4C4                                    ; $01B4BE
        move.w       #$48, d0                                      ; $01B4C0

loc_01B4C4:
        move.w       ActorGoalY(a0), d1                            ; $01B4C4
        sub.w        ActorY(a0), d1                                ; $01B4C8
        asr.w        #$1, d1                                       ; $01B4CC
        beq.b        loc_01B4E8                                    ; $01B4CE
        bpl.b        loc_01B4DE                                    ; $01B4D0
        cmpi.w       #$ffb8, d1                                    ; $01B4D2
        bge.b        loc_01B4E8                                    ; $01B4D6
        move.w       #$ffb8, d1                                    ; $01B4D8
        bra.b        loc_01B4E8                                    ; $01B4DC

loc_01B4DE:
        cmpi.w       #$48, d1                                      ; $01B4DE
        ble.b        loc_01B4E8                                    ; $01B4E2
        move.w       #$48, d1                                      ; $01B4E4

loc_01B4E8:
        move.w       d0, ActorMotionX(a0)                          ; $01B4E8
        move.w       d1, ActorMotionY(a0)                          ; $01B4EC
        bsr.w        MoveActorWithWallMargin64                     ; $01B4F0
        jsr          OctagonalDistance.l                           ; $01B4F4
        cmpi.w       #$a, d0                                       ; $01B4FA
        bls.b        FinishDenpyderChargeAndTryHit                 ; $01B4FE
        bra.w        RefreshEnemyTargetOrExit                      ; $01B500
        ifne *-$1B504
        fail "ROM end moved"
        endif
