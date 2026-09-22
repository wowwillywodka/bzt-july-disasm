; $015AF8..$015B89 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Corpse render uses animations 3/4/5/6. CMP of bank address in several branches has no conditional consumer; it does not select another bank.
        ifne *-$15AF8
        fail "ROM start moved"
        endif

DrawBloodBodyCorpse:
; Corpse render uses animations 3/4/5/6. CMP of bank address in several branches has no conditional consumer; it does not select another bank.
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $015AF8
        beq.w        loc_015B36                                    ; $015AFE
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $015B02
        beq.w        loc_015B4C                                    ; $015B08
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $015B0C
        beq.w        loc_015B70                                    ; $015B12
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $015B16
        beq.w        loc_015B62                                    ; $015B1C
        cmpi.l       #$164820, ActorSpriteBank(a0)                 ; $015B20
        move.w       #$4, d0                                       ; $015B28
        move.w       #$2, d2                                       ; $015B2C
        jmp          DrawActorAnimation.l                          ; $015B30

loc_015B36:
        cmpi.l       #$164820, ActorSpriteBank(a0)                 ; $015B36
        move.w       #$3, d0                                       ; $015B3E
        move.w       #$5, d2                                       ; $015B42
        jmp          DrawActorAnimation.l                          ; $015B46

loc_015B4C:
        cmpi.l       #$164820, ActorSpriteBank(a0)                 ; $015B4C
        move.w       #$6, d0                                       ; $015B54
        move.w       #$4, d2                                       ; $015B58
        jmp          DrawActorAnimation.l                          ; $015B5C

loc_015B62:
        move.w       #$5, d0                                       ; $015B62
        move.w       #$1, d2                                       ; $015B66
        jmp          DrawActorAnimation.l                          ; $015B6A

loc_015B70:
        cmpi.b       #$1, ActorStateCounter(a0)                    ; $015B70
        beq.w        loc_015B7C                                    ; $015B76
        rts                                                        ; $015B7A

loc_015B7C:
        move.w       #$5, d0                                       ; $015B7C
        move.w       #$2, d2                                       ; $015B80
        jmp          DrawActorAnimation.l                          ; $015B84
        ifne *-$15B8A
        fail "ROM end moved"
        endif
