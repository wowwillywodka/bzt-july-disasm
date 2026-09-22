; $01666E..$0166FF | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$1666E
        fail "ROM start moved"
        endif

DrawStananCorpse:
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $01666E
        beq.w        loc_0166AC                                    ; $016674
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $016678
        beq.w        loc_0166C2                                    ; $01667E
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $016682
        beq.w        loc_0166E6                                    ; $016688
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $01668C
        beq.w        loc_0166D8                                    ; $016692
        cmpi.l       #$1848e2, ActorSpriteBank(a0)                 ; $016696
        move.w       #$4, d0                                       ; $01669E
        move.w       #$2, d2                                       ; $0166A2
        jmp          DrawActorAnimation.l                          ; $0166A6

loc_0166AC:
        cmpi.l       #$1848e2, ActorSpriteBank(a0)                 ; $0166AC
        move.w       #$3, d0                                       ; $0166B4
        move.w       #$5, d2                                       ; $0166B8
        jmp          DrawActorAnimation.l                          ; $0166BC

loc_0166C2:
        cmpi.l       #$1848e2, ActorSpriteBank(a0)                 ; $0166C2
        move.w       #$6, d0                                       ; $0166CA
        move.w       #$4, d2                                       ; $0166CE
        jmp          DrawActorAnimation.l                          ; $0166D2

loc_0166D8:
        move.w       #$5, d0                                       ; $0166D8
        move.w       #$1, d2                                       ; $0166DC
        jmp          DrawActorAnimation.l                          ; $0166E0

loc_0166E6:
        cmpi.b       #$1, ActorStateCounter(a0)                    ; $0166E6
        beq.w        loc_0166F2                                    ; $0166EC
        rts                                                        ; $0166F0

loc_0166F2:
        move.w       #$5, d0                                       ; $0166F2
        move.w       #$2, d2                                       ; $0166F6
        jmp          DrawActorAnimation.l                          ; $0166FA
        ifne *-$16700
        fail "ROM end moved"
        endif
