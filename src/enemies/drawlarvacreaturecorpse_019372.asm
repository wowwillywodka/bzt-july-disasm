; $019372..$0193FB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Final3/3; CB/CC draw decrements counter4..1 via4/1,4/2,4/2,4/3. C8/C9 force Dog bank5/4; CE forces Dog bank6/1.
        ifne *-$19372
        fail "ROM start moved"
        endif

DrawLarvaCreatureCorpse:
; Final3/3; CB/CC draw decrements counter4..1 via4/1,4/2,4/2,4/3. C8/C9 force Dog bank5/4; CE forces Dog bank6/1.
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $019372
        beq.w        loc_0193BA                                    ; $019378
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $01937C
        beq.w        loc_0193D0                                    ; $019382
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $019386
        beq.w        loc_019454                                    ; $01938C
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $019390
        beq.w        DrawLarvaCreatureCorpseTransition             ; $019396
        cmpi.b       #$ce, ActorDeathMode(a0)                      ; $01939A
        beq.w        loc_0193E6                                    ; $0193A0
        cmpi.l       #$25626c, ActorSpriteBank(a0)                 ; $0193A4
        move.w       #$3, d0                                       ; $0193AC
        move.w       #$3, d2                                       ; $0193B0
        jmp          DrawActorAnimation.l                          ; $0193B4

loc_0193BA:
        move.l       #DogSpriteBank, ActorSpriteBank(a0)           ; $0193BA
        move.w       #$5, d0                                       ; $0193C2
        move.w       #$4, d2                                       ; $0193C6
        jmp          DrawActorAnimation.l                          ; $0193CA

loc_0193D0:
        move.l       #DogSpriteBank, ActorSpriteBank(a0)           ; $0193D0
        move.w       #$5, d0                                       ; $0193D8
        move.w       #$4, d2                                       ; $0193DC
        jmp          DrawActorAnimation.l                          ; $0193E0

loc_0193E6:
        move.l       #DogSpriteBank, ActorSpriteBank(a0)           ; $0193E6
        move.w       #$6, d0                                       ; $0193EE
        move.w       #$1, d2                                       ; $0193F2
        jmp          DrawActorAnimation.l                          ; $0193F6
        ifne *-$193FC
        fail "ROM end moved"
        endif
