; $0176EC..$01777D | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$176EC
        fail "ROM start moved"
        endif

DrawGreenDummyCorpse:
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $0176EC
        beq.w        loc_01772A                                    ; $0176F2
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $0176F6
        beq.w        loc_017740                                    ; $0176FC
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $017700
        beq.w        loc_017764                                    ; $017706
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $01770A
        beq.w        loc_017756                                    ; $017710
        cmpi.l       #$1e1910, ActorSpriteBank(a0)                 ; $017714
        move.w       #$2, d0                                       ; $01771C
        move.w       #$2, d2                                       ; $017720
        jmp          DrawActorAnimation.l                          ; $017724

loc_01772A:
        cmpi.l       #$1e1910, ActorSpriteBank(a0)                 ; $01772A
        move.w       #$4, d0                                       ; $017732
        move.w       #$5, d2                                       ; $017736
        jmp          DrawActorAnimation.l                          ; $01773A

loc_017740:
        cmpi.l       #$1e1910, ActorSpriteBank(a0)                 ; $017740
        move.w       #$4, d0                                       ; $017748
        move.w       #$4, d2                                       ; $01774C
        jmp          DrawActorAnimation.l                          ; $017750

loc_017756:
        move.w       #$3, d0                                       ; $017756
        move.w       #$1, d2                                       ; $01775A
        jmp          DrawActorAnimation.l                          ; $01775E

loc_017764:
        cmpi.b       #$1, ActorStateCounter(a0)                    ; $017764
        beq.w        loc_017770                                    ; $01776A
        rts                                                        ; $01776E

loc_017770:
        move.w       #$3, d0                                       ; $017770
        move.w       #$2, d2                                       ; $017774
        jmp          DrawActorAnimation.l                          ; $017778
        ifne *-$1777E
        fail "ROM end moved"
        endif
