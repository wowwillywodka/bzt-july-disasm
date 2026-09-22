; $01821A..$01826F | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$1821A
        fail "ROM start moved"
        endif

UpdateBlueDummyCorpse:
        clr.b        ActorUpdateDelay(a0)                          ; $01821A
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $01821E
        beq.w        loc_018262                                    ; $018224
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $018228
        beq.w        TickBlueDummyCorpseState                      ; $01822E
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $018232
        beq.w        loc_01825E                                    ; $018238
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $01823C
        beq.w        loc_01825E                                    ; $018242
        cmpi.b       #$ce, ActorDeathMode(a0)                      ; $018246
        beq.w        loc_01825E                                    ; $01824C
        cmpi.b       #$ca, ActorDeathMode(a0)                      ; $018250
        beq.w        MoveBlueDummyCorpseAndTryPickup               ; $018256
        bra.w        MoveBlueDummyCorpseAndTryPickup               ; $01825A

loc_01825E:
        bra.w        MoveBlueDummyCorpseAndTryPickup               ; $01825E

loc_018262:
        move.b       #$cc, ActorDeathMode(a0)                      ; $018262
        move.b       #$1, ActorStateCounter(a0)                    ; $018268
        rts                                                        ; $01826E
        ifne *-$18270
        fail "ROM end moved"
        endif
