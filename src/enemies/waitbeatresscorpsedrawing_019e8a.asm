; $019E8A..$019E9F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Wait for StateCounter==0 written by corpse drawing.
        ifne *-$19E8A
        fail "ROM start moved"
        endif

WaitBeatressCorpseDrawing:
; Wait for StateCounter==0 written by corpse drawing.
        tst.b        ActorStateCounter(a0)                         ; $019E8A
        bne.w        loc_019E9E                                    ; $019E8E
        move.b       #$ca, ActorDeathMode(a0)                      ; $019E92
        move.b       #$3, ActorState(a0)                           ; $019E98

loc_019E9E:
        rts                                                        ; $019E9E
        ifne *-$19EA0
        fail "ROM end moved"
        endif
