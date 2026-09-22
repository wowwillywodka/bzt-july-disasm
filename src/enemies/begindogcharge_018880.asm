; $018880..$0188C1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Charge8; counter=(distance ASR6)+6; SavedXY=current XY and GoalXY=ActorTarget XY. Refreshed on each new charge.
        ifne *-$18880
        fail "ROM start moved"
        endif

BeginDogCharge:
; Charge8; counter=(distance ASR6)+6; SavedXY=current XY and GoalXY=ActorTarget XY. Refreshed on each new charge.
        movea.l      ActorTarget(a0), a3                           ; $018880
        move.b       #$8, ActorState(a0)                           ; $018884
        move.w       ActorX(a0), d0                                ; $01888A
        sub.w        ActorX(a3), d0                                ; $01888E
        move.w       ActorY(a0), d1                                ; $018892
        sub.w        ActorY(a3), d1                                ; $018896
        jsr          OctagonalDistance.l                           ; $01889A
        asr.w        #$6, d0                                       ; $0188A0
        addq.w       #$6, d0                                       ; $0188A2
        move.b       d0, ActorStateCounter(a0)                     ; $0188A4
        move.w       ActorX(a0), ActorSavedX(a0)                   ; $0188A8
        move.w       ActorY(a0), ActorSavedY(a0)                   ; $0188AE
        move.w       ActorX(a3), ActorGoalX(a0)                    ; $0188B4
        move.w       ActorY(a3), ActorGoalY(a0)                    ; $0188BA
        rts                                                        ; $0188C0
        ifne *-$188C2
        fail "ROM end moved"
        endif
