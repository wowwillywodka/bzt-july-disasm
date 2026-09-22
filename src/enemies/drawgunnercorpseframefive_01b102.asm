; $01B102..$01B113 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Live counter3/2 draw selects frame5 and decrements counter.
        ifne *-$1B102
        fail "ROM start moved"
        endif

DrawGunnerCorpseFrameFive:
; Live counter3/2 draw selects frame5 and decrements counter.
        move.w       #$3, d0                                       ; $01B102
        move.w       #$5, d2                                       ; $01B106
        subq.b       #$1, ActorStateCounter(a0)                    ; $01B10A
        jmp          DrawActorAnimation.l                          ; $01B10E
        ifne *-$1B114
        fail "ROM end moved"
        endif
