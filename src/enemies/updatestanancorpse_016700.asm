; $016700..$01674B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Corpse CB->CC; CC decrements State, not StateCounter; after three ticks sets CA/state3. Not an attack router.
        ifne *-$16700
        fail "ROM start moved"
        endif

UpdateStananCorpse:
; Corpse CB->CC; CC decrements State, not StateCounter; after three ticks sets CA/state3. Not an attack router.
        clr.b        ActorUpdateDelay(a0)                          ; $016700
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $016704
        beq.w        loc_01673E                                    ; $01670A
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $01670E
        beq.w        TickStananCorpseTransition                    ; $016714
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $016718
        beq.w        loc_01673A                                    ; $01671E
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $016722
        beq.w        loc_01673A                                    ; $016728
        cmpi.b       #$ca, ActorDeathMode(a0)                      ; $01672C
        beq.w        StananMoveCorpse                              ; $016732
        bra.w        StananMoveCorpse                              ; $016736

loc_01673A:
        bra.w        StananMoveCorpse                              ; $01673A

loc_01673E:
        move.b       #$cc, ActorDeathMode(a0)                      ; $01673E
        move.b       #$1, ActorStateCounter(a0)                    ; $016744
        rts                                                        ; $01674A
        ifne *-$1674C
        fail "ROM end moved"
        endif
