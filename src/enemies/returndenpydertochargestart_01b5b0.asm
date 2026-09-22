; $01B5B0..$01B61B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Return to most recent charge start, not permanent spawn point. X delta ASR2 but Y delta ASR3; both clamp +/-72. Counter reset20 each return tick. Returned vector length<=10 (actual delta only if ActorMarkerTracked=0) chooses wander goal or death.
        ifne *-$1B5B0
        fail "ROM start moved"
        endif

ReturnDenpyderToChargeStart:
; Return to most recent charge start, not permanent spawn point. X delta ASR2 but Y delta ASR3; both clamp +/-72. Counter reset20 each return tick. Returned vector length<=10 (actual delta only if ActorMarkerTracked=0) chooses wander goal or death.
        move.w       ActorGoalX(a0), d0                            ; $01B5B0
        sub.w        ActorX(a0), d0                                ; $01B5B4
        asr.w        #$2, d0                                       ; $01B5B8
        beq.b        loc_01B5D4                                    ; $01B5BA
        bpl.b        loc_01B5CA                                    ; $01B5BC
        cmpi.w       #$ffb8, d0                                    ; $01B5BE
        bge.b        loc_01B5D4                                    ; $01B5C2
        move.w       #$ffb8, d0                                    ; $01B5C4
        bra.b        loc_01B5D4                                    ; $01B5C8

loc_01B5CA:
        cmpi.w       #$48, d0                                      ; $01B5CA
        ble.b        loc_01B5D4                                    ; $01B5CE
        move.w       #$48, d0                                      ; $01B5D0

loc_01B5D4:
        move.w       ActorGoalY(a0), d1                            ; $01B5D4
        sub.w        ActorY(a0), d1                                ; $01B5D8
        asr.w        #$3, d1                                       ; $01B5DC
        beq.b        loc_01B5F8                                    ; $01B5DE
        bpl.b        loc_01B5EE                                    ; $01B5E0
        cmpi.w       #$ffb8, d1                                    ; $01B5E2
        bge.b        loc_01B5F8                                    ; $01B5E6
        move.w       #$ffb8, d1                                    ; $01B5E8
        bra.b        loc_01B5F8                                    ; $01B5EC

loc_01B5EE:
        cmpi.w       #$48, d1                                      ; $01B5EE
        ble.b        loc_01B5F8                                    ; $01B5F2
        move.w       #$48, d1                                      ; $01B5F4

loc_01B5F8:
        move.w       d0, ActorMotionX(a0)                          ; $01B5F8
        move.w       d1, ActorMotionY(a0)                          ; $01B5FC
        bsr.w        MoveActorWithWallMargin64                     ; $01B600
        jsr          OctagonalDistance.l                           ; $01B604
        move.b       #$14, ActorStateCounter(a0)                   ; $01B60A
        cmpi.w       #$a, d0                                       ; $01B610
        bls.w        ChooseDenpyderWanderGoalOrDie                 ; $01B614
        bra.w        RefreshEnemyTargetOrExit                      ; $01B618
        ifne *-$1B61C
        fail "ROM end moved"
        endif
