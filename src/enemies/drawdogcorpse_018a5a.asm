; $018A5A..$018AE3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Final3/3; ordinary transition4/1..3, update-driven. C8->5/4; C9->5/5 (invalid, fallback0); CE->6/1. CMPI.L bank checks do not change bank or branch.
        ifne *-$18A5A
        fail "ROM start moved"
        endif

DrawDogCorpse:
; Final3/3; ordinary transition4/1..3, update-driven. C8->5/4; C9->5/5 (invalid, fallback0); CE->6/1. CMPI.L bank checks do not change bank or branch.
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $018A5A
        beq.w        loc_018AA2                                    ; $018A60
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $018A64
        beq.w        loc_018AB8                                    ; $018A6A
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $018A6E
        beq.w        loc_018B26                                    ; $018A74
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $018A78
        beq.w        DrawDogCorpseTransition                       ; $018A7E
        cmpi.b       #$ce, ActorDeathMode(a0)                      ; $018A82
        beq.w        loc_018ACE                                    ; $018A88
        cmpi.l       #$29acf6, ActorSpriteBank(a0)                 ; $018A8C
        move.w       #$3, d0                                       ; $018A94
        move.w       #$3, d2                                       ; $018A98
        jmp          DrawActorAnimation.l                          ; $018A9C

loc_018AA2:
        cmpi.l       #$29acf6, ActorSpriteBank(a0)                 ; $018AA2
        move.w       #$5, d0                                       ; $018AAA
        move.w       #$5, d2                                       ; $018AAE
        jmp          DrawActorAnimation.l                          ; $018AB2

loc_018AB8:
        cmpi.l       #$29acf6, ActorSpriteBank(a0)                 ; $018AB8
        move.w       #$5, d0                                       ; $018AC0
        move.w       #$4, d2                                       ; $018AC4
        jmp          DrawActorAnimation.l                          ; $018AC8

loc_018ACE:
        cmpi.l       #$29acf6, ActorSpriteBank(a0)                 ; $018ACE
        move.w       #$6, d0                                       ; $018AD6
        move.w       #$1, d2                                       ; $018ADA
        jmp          DrawActorAnimation.l                          ; $018ADE
        ifne *-$18AE4
        fail "ROM end moved"
        endif
