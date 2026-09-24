; $0193FC..$019441 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Draw-driven corpse countdown; update merely waits for zero.
        ifne *-$193FC
        fail "ROM start moved"
        endif

DrawLarvaCreatureCorpseTransition:
; Draw-driven corpse countdown; update merely waits for zero.
        cmpi.b       #$4, ActorStateCounter(a0)                    ; $0193FC
        beq.b        loc_01941E                                    ; $019402
        cmpi.b       #$3, ActorStateCounter(a0)                    ; $019404
        beq.b        loc_019430                                    ; $01940A
        cmpi.b       #$2, ActorStateCounter(a0)                    ; $01940C
        beq.b        loc_019430                                    ; $019412
        cmpi.b       #$1, ActorStateCounter(a0)                    ; $019414
        beq.b        DrawLarvaCreatureCorpseFinalFrame                         ; $01941A
        rts                                                        ; $01941C

loc_01941E:
        move.w       #$4, d0                                       ; $01941E
        move.w       #$1, d2                                       ; $019422
        subq.b       #$1, ActorStateCounter(a0)                    ; $019426
        jmp          DrawActorAnimation.l                          ; $01942A

loc_019430:
        move.w       #$4, d0                                       ; $019430
        move.w       #$2, d2                                       ; $019434
        subq.b       #$1, ActorStateCounter(a0)                    ; $019438
        jmp          DrawActorAnimation.l                          ; $01943C
        ifne *-$19442
        fail "ROM end moved"
        endif
