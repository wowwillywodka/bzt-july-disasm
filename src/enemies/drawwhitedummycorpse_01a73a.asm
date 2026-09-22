; $01A73A..$01A7C5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; CB/CC transition is driven by DRAW calls, decrementing StateCounter4..1. C8/C9 switches bank to DogSpriteBank ($29ACF6), animation5/frame4. Default corpse3/3.
        ifne *-$1A73A
        fail "ROM start moved"
        endif

DrawWhiteDummyCorpse:
; CB/CC transition is driven by DRAW calls, decrementing StateCounter4..1. C8/C9 switches bank to DogSpriteBank ($29ACF6), animation5/frame4. Default corpse3/3.
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $01A73A
        beq.w        loc_01A778                                    ; $01A740
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $01A744
        beq.w        loc_01A78E                                    ; $01A74A
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $01A74E
        beq.w        loc_01A7FC                                    ; $01A754
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $01A758
        beq.w        loc_01A7A4                                    ; $01A75E
        cmpi.l       #$2214b0, ActorSpriteBank(a0)                 ; $01A762
        move.w       #$3, d0                                       ; $01A76A
        move.w       #$3, d2                                       ; $01A76E
        jmp          DrawActorAnimation.l                          ; $01A772

loc_01A778:
        move.l       #DogSpriteBank, ActorSpriteBank(a0)           ; $01A778
        move.w       #$5, d0                                       ; $01A780
        move.w       #$4, d2                                       ; $01A784
        jmp          DrawActorAnimation.l                          ; $01A788

loc_01A78E:
        move.l       #DogSpriteBank, ActorSpriteBank(a0)           ; $01A78E
        move.w       #$5, d0                                       ; $01A796
        move.w       #$4, d2                                       ; $01A79A
        jmp          DrawActorAnimation.l                          ; $01A79E

loc_01A7A4:
        cmpi.b       #$4, ActorStateCounter(a0)                    ; $01A7A4
        beq.b        DrawWhiteDummyCorpseTransition                ; $01A7AA
        cmpi.b       #$3, ActorStateCounter(a0)                    ; $01A7AC
        beq.b        loc_01A7D8                                    ; $01A7B2
        cmpi.b       #$2, ActorStateCounter(a0)                    ; $01A7B4
        beq.b        loc_01A7D8                                    ; $01A7BA
        cmpi.b       #$1, ActorStateCounter(a0)                    ; $01A7BC
        beq.b        loc_01A7EA                                    ; $01A7C2
        rts                                                        ; $01A7C4
        ifne *-$1A7C6
        fail "ROM end moved"
        endif
