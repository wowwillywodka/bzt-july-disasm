; $01B7D4..$01B815 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Begin charge state$0A; counter=(target distance ASR6)+6; SavedXY=current XY and goal=ActorTarget XY. Saved point is refreshed on each new charge.
        ifne *-$1B7D4
        fail "ROM start moved"
        endif

BeginDenpyderCharge:
; Begin charge state$0A; counter=(target distance ASR6)+6; SavedXY=current XY and goal=ActorTarget XY. Saved point is refreshed on each new charge.
        movea.l      ActorTarget(a0), a3                           ; $01B7D4
        move.b       #$a, ActorState(a0)                           ; $01B7D8
        move.w       ActorX(a0), d0                                ; $01B7DE
        sub.w        ActorX(a3), d0                                ; $01B7E2
        move.w       ActorY(a0), d1                                ; $01B7E6
        sub.w        ActorY(a3), d1                                ; $01B7EA
        jsr          OctagonalDistance.l                           ; $01B7EE
        asr.w        #$6, d0                                       ; $01B7F4
        addq.w       #$6, d0                                       ; $01B7F6
        move.b       d0, ActorStateCounter(a0)                     ; $01B7F8
        move.w       ActorX(a0), ActorSavedX(a0)                   ; $01B7FC
        move.w       ActorY(a0), ActorSavedY(a0)                   ; $01B802
        move.w       ActorX(a3), ActorGoalX(a0)                    ; $01B808
        move.w       ActorY(a3), ActorGoalY(a0)                    ; $01B80E
        rts                                                        ; $01B814
        ifne *-$1B816
        fail "ROM end moved"
        endif
