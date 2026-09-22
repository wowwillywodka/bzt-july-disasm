; $019DF2..$019E29 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Draw-driven corpse countdown, not update-driven; decrements before renderer call.
        ifne *-$19DF2
        fail "ROM start moved"
        endif

DrawBeatressCorpseTransition:
; Draw-driven corpse countdown, not update-driven; decrements before renderer call.
        move.w       #$3, d0                                       ; $019DF2
        move.w       #$1, d2                                       ; $019DF6
        subq.b       #$1, ActorStateCounter(a0)                    ; $019DFA
        jmp          DrawActorAnimation.l                          ; $019DFE

loc_019E04:
        move.w       #$3, d0                                       ; $019E04
        move.w       #$2, d2                                       ; $019E08
        subq.b       #$1, ActorStateCounter(a0)                    ; $019E0C
        jmp          DrawActorAnimation.l                          ; $019E10

loc_019E16:
        move.w       #$3, d0                                       ; $019E16
        move.w       #$3, d2                                       ; $019E1A
        subq.b       #$1, ActorStateCounter(a0)                    ; $019E1E
        jmp          DrawActorAnimation.l                          ; $019E22

loc_019E28:
        bra.b        loc_019DD0                                    ; $019E28
        ifne *-$19E2A
        fail "ROM end moved"
        endif
