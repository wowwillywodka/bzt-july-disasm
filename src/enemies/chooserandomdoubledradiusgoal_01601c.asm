; $01601C..$016067 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Set state0; random angle=(RNG ASR.L8)&$1FF plus GLOBAL player angle. Goal=A3.XY + twice signed sine/cosine words. A3 is inherited, not loaded from ActorTarget. Counter and SavedXY unchanged.
        ifne *-$1601C
        fail "ROM start moved"
        endif

ChooseRandomDoubledRadiusGoal:
; Set state0; random angle=(RNG ASR.L8)&$1FF plus GLOBAL player angle. Goal=A3.XY + twice signed sine/cosine words. A3 is inherited, not loaded from ActorTarget. Counter and SavedXY unchanged.
        move.b       #$0, ActorState(a0)                           ; $01601C
        jsr          NextRandom.l                                  ; $016022
        asr.l        #$8, d2                                       ; $016028
        andi.w       #$1ff, d2                                     ; $01602A
        clr.l        d0                                            ; $01602E
        clr.l        d1                                            ; $016030
        move.w       d2, ActorGoalAngle(a0)                        ; $016032
        lea.l        AngleVectorPairs.w, a4                        ; $016036
        move.w       -$71ee(a6), d0                                ; $01603A
        add.w        ActorGoalAngle(a0), d0                        ; $01603E
        andi.w       #$1ff, d0                                     ; $016042
        lsl.w        #$2, d0                                       ; $016046
        move.w       $2(a4, d0.w), d1                              ; $016048
        move.w       (a4, d0.w), d0                                ; $01604C
        asl.w        #$1, d1                                       ; $016050
        asl.w        #$1, d0                                       ; $016052
        add.w        ActorX(a3), d0                                ; $016054
        move.w       d0, ActorGoalX(a0)                            ; $016058
        move.w       d1, d0                                        ; $01605C
        add.w        ActorY(a3), d0                                ; $01605E
        move.w       d0, ActorGoalY(a0)                            ; $016062
        rts                                                        ; $016066
        ifne *-$16068
        fail "ROM end moved"
        endif
