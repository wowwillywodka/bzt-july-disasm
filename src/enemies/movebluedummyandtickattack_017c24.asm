; $017C24..$017CC1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; ASR3 clamp +/-25. Attack state1 skips collision; attack starts before collision. Reselect if BOTH absolute returned components<25 (actual delta only if ActorMarkerTracked=0); arrival checks later only refresh.
        ifne *-$17C24
        fail "ROM start moved"
        endif

MoveBlueDummyAndTickAttack:
; ASR3 clamp +/-25. Attack state1 skips collision; attack starts before collision. Reselect if BOTH absolute returned components<25 (actual delta only if ActorMarkerTracked=0); arrival checks later only refresh.
        clr.w        d2                                            ; $017C24
        move.w       ActorGoalX(a0), d0                            ; $017C26
        sub.w        ActorX(a0), d0                                ; $017C2A
        asr.w        #$3, d0                                       ; $017C2E
        tst.w        d0                                            ; $017C30
        beq.b        loc_017C4C                                    ; $017C32
        bpl.b        loc_017C42                                    ; $017C34
        cmpi.w       #$ffe7, d0                                    ; $017C36
        bge.b        loc_017C4C                                    ; $017C3A
        move.w       #$ffe7, d0                                    ; $017C3C
        bra.b        loc_017C4C                                    ; $017C40

loc_017C42:
        cmpi.w       #$19, d0                                      ; $017C42
        ble.b        loc_017C4C                                    ; $017C46
        move.w       #$19, d0                                      ; $017C48

loc_017C4C:
        move.w       ActorGoalY(a0), d1                            ; $017C4C
        sub.w        ActorY(a0), d1                                ; $017C50
        asr.w        #$3, d1                                       ; $017C54
        tst.w        d1                                            ; $017C56
        beq.b        loc_017C72                                    ; $017C58
        bpl.b        loc_017C68                                    ; $017C5A
        cmpi.w       #$ffe7, d1                                    ; $017C5C
        bge.b        loc_017C72                                    ; $017C60
        move.w       #$ffe7, d1                                    ; $017C62
        bra.b        loc_017C72                                    ; $017C66

loc_017C68:
        cmpi.w       #$19, d1                                      ; $017C68
        ble.b        loc_017C72                                    ; $017C6C
        move.w       #$19, d1                                      ; $017C6E

loc_017C72:
        cmpi.b       #$1, ActorState(a0)                           ; $017C72
        beq.w        TickBlueDummyAttack                           ; $017C78
        move.w       d0, ActorMotionX(a0)                          ; $017C7C
        move.w       d1, ActorMotionY(a0)                          ; $017C80
        bsr.w        TickBlueDummyAttack                           ; $017C84
        cmpi.b       #$1, ActorState(a0)                           ; $017C88
        beq.w        BlueDummyAttackCountdown                      ; $017C8E
        move.w       ActorMotionX(a0), d0                          ; $017C92
        move.w       ActorMotionY(a0), d1                          ; $017C96
        bsr.w        MoveActorWithWallMargin32                     ; $017C9A
        tst.w        d0                                            ; $017C9E
        bpl.b        loc_017CA4                                    ; $017CA0
        neg.w        d0                                            ; $017CA2

loc_017CA4:
        tst.w        d1                                            ; $017CA4
        bpl.b        loc_017CAA                                    ; $017CA6
        neg.w        d1                                            ; $017CA8

loc_017CAA:
        cmpi.w       #$19, d0                                      ; $017CAA
        bge.b        CheckBlueDummyGoalAndRefresh                  ; $017CAE
        cmpi.w       #$19, d1                                      ; $017CB0
        bge.b        CheckBlueDummyGoalAndRefresh                  ; $017CB4
        clr.w        ActorMotionX(a0)                              ; $017CB6
        clr.w        ActorMotionY(a0)                              ; $017CBA
        jmp          ChooseBlueDummyGoalOrDie(pc)                  ; $017CBE
        ifne *-$17CC2
        fail "ROM end moved"
        endif
