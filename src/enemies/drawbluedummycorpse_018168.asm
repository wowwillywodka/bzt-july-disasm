; $018168..$018219 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Final corpse2/2; CB3/1, CC3/2 only if counter1. C8 forces own bank4/4, C9 own bank4/5, CE own bank5/1.
        ifne *-$18168
        fail "ROM start moved"
        endif

DrawBlueDummyCorpse:
; Final corpse2/2; CB3/1, CC3/2 only if counter1. C8 forces own bank4/4, C9 own bank4/5, CE own bank5/1.
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $018168
        beq.w        loc_0181B0                                    ; $01816E
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $018172
        beq.w        loc_0181C6                                    ; $018178
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $01817C
        beq.w        loc_018200                                    ; $018182
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $018186
        beq.w        loc_0181F2                                    ; $01818C
        cmpi.b       #$ce, ActorDeathMode(a0)                      ; $018190
        beq.w        loc_0181DC                                    ; $018196
        cmpi.l       #$27d95c, ActorSpriteBank(a0)                 ; $01819A
        move.w       #$2, d0                                       ; $0181A2
        move.w       #$2, d2                                       ; $0181A6
        jmp          DrawActorAnimation.l                          ; $0181AA

loc_0181B0:
        move.l       #BlueDummySpriteBank, ActorSpriteBank(a0)     ; $0181B0
        move.w       #$4, d0                                       ; $0181B8
        move.w       #$5, d2                                       ; $0181BC
        jmp          DrawActorAnimation.l                          ; $0181C0

loc_0181C6:
        move.l       #BlueDummySpriteBank, ActorSpriteBank(a0)     ; $0181C6
        move.w       #$4, d0                                       ; $0181CE
        move.w       #$4, d2                                       ; $0181D2
        jmp          DrawActorAnimation.l                          ; $0181D6

loc_0181DC:
        move.l       #BlueDummySpriteBank, ActorSpriteBank(a0)     ; $0181DC
        move.w       #$5, d0                                       ; $0181E4
        move.w       #$1, d2                                       ; $0181E8
        jmp          DrawActorAnimation.l                          ; $0181EC

loc_0181F2:
        move.w       #$3, d0                                       ; $0181F2
        move.w       #$1, d2                                       ; $0181F6
        jmp          DrawActorAnimation.l                          ; $0181FA

loc_018200:
        cmpi.b       #$1, ActorStateCounter(a0)                    ; $018200
        beq.w        loc_01820C                                    ; $018206
        rts                                                        ; $01820A

loc_01820C:
        move.w       #$3, d0                                       ; $01820C
        move.w       #$2, d2                                       ; $018210
        jmp          DrawActorAnimation.l                          ; $018214
        ifne *-$1821A
        fail "ROM end moved"
        endif
