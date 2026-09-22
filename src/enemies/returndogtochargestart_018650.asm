; $018650..$0186BB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Return to last charge start: X ASR2, Y ASR3, clamp72; counter20 each tick; returned vector length<=10 (actual delta only if ActorMarkerTracked=0) chooses wander/death.
        ifne *-$18650
        fail "ROM start moved"
        endif

ReturnDogToChargeStart:
; Return to last charge start: X ASR2, Y ASR3, clamp72; counter20 each tick; returned vector length<=10 (actual delta only if ActorMarkerTracked=0) chooses wander/death.
        move.w       ActorGoalX(a0), d0                            ; $018650
        sub.w        ActorX(a0), d0                                ; $018654
        asr.w        #$2, d0                                       ; $018658
        beq.b        loc_018674                                    ; $01865A
        bpl.b        loc_01866A                                    ; $01865C
        cmpi.w       #$ffb8, d0                                    ; $01865E
        bge.b        loc_018674                                    ; $018662
        move.w       #$ffb8, d0                                    ; $018664
        bra.b        loc_018674                                    ; $018668

loc_01866A:
        cmpi.w       #$48, d0                                      ; $01866A
        ble.b        loc_018674                                    ; $01866E
        move.w       #$48, d0                                      ; $018670

loc_018674:
        move.w       ActorGoalY(a0), d1                            ; $018674
        sub.w        ActorY(a0), d1                                ; $018678
        asr.w        #$3, d1                                       ; $01867C
        beq.b        loc_018698                                    ; $01867E
        bpl.b        loc_01868E                                    ; $018680
        cmpi.w       #$ffb8, d1                                    ; $018682
        bge.b        loc_018698                                    ; $018686
        move.w       #$ffb8, d1                                    ; $018688
        bra.b        loc_018698                                    ; $01868C

loc_01868E:
        cmpi.w       #$48, d1                                      ; $01868E
        ble.b        loc_018698                                    ; $018692
        move.w       #$48, d1                                      ; $018694

loc_018698:
        move.w       d0, ActorMotionX(a0)                          ; $018698
        move.w       d1, ActorMotionY(a0)                          ; $01869C
        bsr.w        MoveActorWithWallMargin64                     ; $0186A0
        jsr          OctagonalDistance.l                           ; $0186A4
        move.b       #$14, ActorStateCounter(a0)                   ; $0186AA
        cmpi.w       #$a, d0                                       ; $0186B0
        bls.w        ChooseDogWanderGoalOrDie                      ; $0186B4
        bra.w        RefreshEnemyTargetOrExit                      ; $0186B8
        ifne *-$186BC
        fail "ROM end moved"
        endif
