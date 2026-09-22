; $018B8C..$018BA1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; CB first sets CC/counter3; CC decrements counter each UPDATE; zero->CA/state3. Does not wait for drawing.
        ifne *-$18B8C
        fail "ROM start moved"
        endif

TickDogCorpseTransition:
; CB first sets CC/counter3; CC decrements counter each UPDATE; zero->CA/state3. Does not wait for drawing.
        subq.b       #$1, ActorStateCounter(a0)                    ; $018B8C
        bne.w        loc_018BA0                                    ; $018B90
        move.b       #$ca, ActorDeathMode(a0)                      ; $018B94
        move.b       #$3, ActorState(a0)                           ; $018B9A

loc_018BA0:
        rts                                                        ; $018BA0
        ifne *-$18BA2
        fail "ROM end moved"
        endif
