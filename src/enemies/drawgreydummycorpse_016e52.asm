; $016E52..$016EE3 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$16E52
        fail "ROM start moved"
        endif

DrawGreyDummyCorpse:
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $016E52
        beq.w        loc_016E90                                    ; $016E58
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $016E5C
        beq.w        loc_016EA6                                    ; $016E62
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $016E66
        beq.w        loc_016ECA                                    ; $016E6C
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $016E70
        beq.w        loc_016EBC                                    ; $016E76
        cmpi.l       #$1c4576, ActorSpriteBank(a0)                 ; $016E7A
        move.w       #$2, d0                                       ; $016E82
        move.w       #$2, d2                                       ; $016E86
        jmp          DrawActorAnimation.l                          ; $016E8A

loc_016E90:
        cmpi.l       #$1c4576, ActorSpriteBank(a0)                 ; $016E90
        move.w       #$4, d0                                       ; $016E98
        move.w       #$5, d2                                       ; $016E9C
        jmp          DrawActorAnimation.l                          ; $016EA0

loc_016EA6:
        cmpi.l       #$1c4576, ActorSpriteBank(a0)                 ; $016EA6
        move.w       #$4, d0                                       ; $016EAE
        move.w       #$4, d2                                       ; $016EB2
        jmp          DrawActorAnimation.l                          ; $016EB6

loc_016EBC:
        move.w       #$3, d0                                       ; $016EBC
        move.w       #$1, d2                                       ; $016EC0
        jmp          DrawActorAnimation.l                          ; $016EC4

loc_016ECA:
        cmpi.b       #$1, ActorStateCounter(a0)                    ; $016ECA
        beq.w        loc_016ED6                                    ; $016ED0
        rts                                                        ; $016ED4

loc_016ED6:
        move.w       #$3, d0                                       ; $016ED6
        move.w       #$2, d2                                       ; $016EDA
        jmp          DrawActorAnimation.l                          ; $016EDE
        ifne *-$16EE4
        fail "ROM end moved"
        endif
