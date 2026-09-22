; $018B36..$018B8B | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$18B36
        fail "ROM start moved"
        endif

UpdateDogCorpse:
        clr.b        ActorUpdateDelay(a0)                          ; $018B36
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $018B3A
        beq.w        loc_018B7E                                    ; $018B40
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $018B44
        beq.w        TickDogCorpseTransition                       ; $018B4A
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $018B4E
        beq.w        loc_018B7A                                    ; $018B54
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $018B58
        beq.w        loc_018B7A                                    ; $018B5E
        cmpi.b       #$ce, ActorDeathMode(a0)                      ; $018B62
        beq.w        loc_018B7A                                    ; $018B68
        cmpi.b       #$ca, ActorDeathMode(a0)                      ; $018B6C
        beq.w        MoveDogCorpseAndCheckContact                  ; $018B72
        bra.w        MoveDogCorpseAndCheckContact                  ; $018B76

loc_018B7A:
        bra.w        MoveDogCorpseAndCheckContact                  ; $018B7A

loc_018B7E:
        move.b       #$cc, ActorDeathMode(a0)                      ; $018B7E
        move.b       #$3, ActorStateCounter(a0)                    ; $018B84
        rts                                                        ; $018B8A
        ifne *-$18B8C
        fail "ROM end moved"
        endif
