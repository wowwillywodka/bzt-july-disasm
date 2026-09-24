; $01DC20..$01DC31 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Retained missed-shot effect: count state 3 down, rise in Z, remove.
        ifne *-$1DC20
        fail "ROM start moved"
        endif

UpdateMissedShotImpact:
        clr.b        ActorUpdateDelay(a0)                          ; $01DC20
        subq.b       #$1, ActorState(a0)                           ; $01DC24
        bmi.w        RemoveActorAndSendLink                        ; $01DC28
        addq.w       #$2, ActorZ(a0)                               ; $01DC2C
        rts                                                        ; $01DC30
        ifne *-$1DC32
        fail "ROM end moved"
        endif
