; $01B7AA..$01B7D3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Wake8 counts12 down to0, then state0/counter2. Counter already0 returns and stays8. No automatic wake from dormant7 by proximity in this local update.
        ifne *-$1B7AA
        fail "ROM start moved"
        endif

TickDenpyderWake:
; Wake8 counts12 down to0, then state0/counter2. Counter already0 returns and stays8. No automatic wake from dormant7 by proximity in this local update.
        tst.b        ActorStateCounter(a0)                         ; $01B7AA
        beq.b        loc_01B7A6                                    ; $01B7AE
        subq.b       #$1, ActorStateCounter(a0)                    ; $01B7B0
        bne.b        loc_01B7A6                                    ; $01B7B4
        move.b       #$0, ActorState(a0)                           ; $01B7B6
        move.b       #$2, ActorStateCounter(a0)                    ; $01B7BC
        rts                                                        ; $01B7C2

DenpyderTickUnassignedStateSix:
        subq.b       #$1, ActorStateCounter(a0)                    ; $01B7C4
        bne.b        loc_01B7A6                                    ; $01B7C8
        move.b       #$c9, ActorDeathMode(a0)                      ; $01B7CA
        bra.w        EnterDenpyderDeath                            ; $01B7D0
        ifne *-$1B7D4
        fail "ROM end moved"
        endif
