; $01B6AE..$01B6E7 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Signed HP<0 dies, else random offsets from current XY in [-512,511] per component, using ASR.L4 and then SWAP of SAME RNG result. State9; existing counter preserved.
        ifne *-$1B6AE
        fail "ROM start moved"
        endif

ChooseDenpyderWanderGoalOrDie:
; Signed HP<0 dies, else random offsets from current XY in [-512,511] per component, using ASR.L4 and then SWAP of SAME RNG result. State9; existing counter preserved.
        tst.w        ActorHealth(a0)                               ; $01B6AE
        bmi.b        EnterDenpyderDeath                            ; $01B6B2
        jsr          NextRandom.w                                  ; $01B6B4
        asr.l        #$4, d2                                       ; $01B6B8
        move.w       d2, d0                                        ; $01B6BA
        andi.w       #$3ff, d0                                     ; $01B6BC
        subi.w       #$200, d0                                     ; $01B6C0
        add.w        ActorX(a0), d0                                ; $01B6C4
        move.w       d0, ActorGoalX(a0)                            ; $01B6C8
        swap         d2                                            ; $01B6CC
        move.w       d2, d0                                        ; $01B6CE
        andi.w       #$3ff, d0                                     ; $01B6D0
        subi.w       #$200, d0                                     ; $01B6D4
        add.w        ActorY(a0), d0                                ; $01B6D8
        move.w       d0, ActorGoalY(a0)                            ; $01B6DC
        move.b       #$9, ActorState(a0)                           ; $01B6E0
        rts                                                        ; $01B6E6
        ifne *-$1B6E8
        fail "ROM end moved"
        endif
