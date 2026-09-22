; $0194C0..$0194D5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; CC waits until draw has consumed StateCounter; thenCA/state3.
        ifne *-$194C0
        fail "ROM start moved"
        endif

WaitLarvaCreatureCorpseDrawing:
; CC waits until draw has consumed StateCounter; thenCA/state3.
        tst.b        ActorStateCounter(a0)                         ; $0194C0
        bne.w        loc_0194D4                                    ; $0194C4
        move.b       #$ca, ActorDeathMode(a0)                      ; $0194C8
        move.b       #$3, ActorState(a0)                           ; $0194CE

loc_0194D4:
        rts                                                        ; $0194D4
        ifne *-$194D6
        fail "ROM end moved"
        endif
