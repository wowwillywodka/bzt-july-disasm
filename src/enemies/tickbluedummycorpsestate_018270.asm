; $018270..$018285 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; CC decrements ActorState (offset38), NOT StateCounter. Ordinary3->2->1->0 then CA/state3; counter remains1. Drawing does not advance this transition.
        ifne *-$18270
        fail "ROM start moved"
        endif

TickBlueDummyCorpseState:
; CC decrements ActorState (offset38), NOT StateCounter. Ordinary3->2->1->0 then CA/state3; counter remains1. Drawing does not advance this transition.
        subq.b       #$1, ActorState(a0)                           ; $018270
        bne.w        loc_018284                                    ; $018274
        move.b       #$ca, ActorDeathMode(a0)                      ; $018278
        move.b       #$3, ActorState(a0)                           ; $01827E

loc_018284:
        rts                                                        ; $018284
        ifne *-$18286
        fail "ROM end moved"
        endif
