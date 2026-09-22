; $016152..$016193 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$16152
        fail "ROM start moved"
        endif

RetainedRandomActorDirection:
        jsr          NextRandom.l                                  ; $016152
        asr.l        #$4, d2                                       ; $016158
        andi.w       #$1ff, d2                                     ; $01615A
        lea.l        AngleVectorPairs.w, a4                        ; $01615E
        move.w       -$71ee(a6), d0                                ; $016162
        add.w        d2, d0                                        ; $016166
        andi.w       #$1ff, d0                                     ; $016168
        lsl.w        #$2, d0                                       ; $01616C
        move.w       $2(a4, d0.w), d1                              ; $01616E
        move.w       (a4, d0.w), d0                                ; $016172
        asl.w        #$1, d0                                       ; $016176
        asl.w        #$1, d1                                       ; $016178
        add.w        ActorX(a3), d0                                ; $01617A
        move.w       d0, ActorGoalX(a0)                            ; $01617E
        clr.w        d0                                            ; $016182
        move.w       d1, d0                                        ; $016184
        add.w        ActorY(a3), d0                                ; $016186
        move.w       d0, ActorGoalY(a0)                            ; $01618A
        clr.w        ActorCloseGoalFlag(a0)                        ; $01618E
        rts                                                        ; $016192
        ifne *-$16194
        fail "ROM end moved"
        endif
