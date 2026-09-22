; $01B1B2..$01B1B9 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$1B1B2
        fail "ROM start moved"
        endif

BeginGunnerCorpseTransition:
        move.b       #$cc, ActorDeathMode(a0)                      ; $01B1B2
        rts                                                        ; $01B1B8
        ifne *-$1B1BA
        fail "ROM end moved"
        endif
