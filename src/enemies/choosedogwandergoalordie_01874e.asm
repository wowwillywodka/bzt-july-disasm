; $01874E..$018787 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; HP<0 -> death; else offsets[-512,511] from one RNG ASR.L4 then SWAP, state7; preserves counter.
        ifne *-$1874E
        fail "ROM start moved"
        endif

ChooseDogWanderGoalOrDie:
; HP<0 -> death; else offsets[-512,511] from one RNG ASR.L4 then SWAP, state7; preserves counter.
        tst.w        ActorHealth(a0)                               ; $01874E
        bmi.b        EnterDogDeath                                 ; $018752
        jsr          NextRandom.w                                  ; $018754
        asr.l        #$4, d2                                       ; $018758
        move.w       d2, d0                                        ; $01875A
        andi.w       #$3ff, d0                                     ; $01875C
        subi.w       #$200, d0                                     ; $018760
        add.w        ActorX(a0), d0                                ; $018764
        move.w       d0, ActorGoalX(a0)                            ; $018768
        swap         d2                                            ; $01876C
        move.w       d2, d0                                        ; $01876E
        andi.w       #$3ff, d0                                     ; $018770
        subi.w       #$200, d0                                     ; $018774
        add.w        ActorY(a0), d0                                ; $018778
        move.w       d0, ActorGoalY(a0)                            ; $01877C
        move.b       #$7, ActorState(a0)                           ; $018780
        rts                                                        ; $018786
        ifne *-$18788
        fail "ROM end moved"
        endif
