; $01BA8C..$01BB07 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; CB/CC draw countdown4..1:2/1,1/1,1/2,1/3; writes Z=$10,0,-$20 on last three. Final corpse1/3; C8/C9 would choose3/4 but normal death overwrites modes.
        ifne *-$1BA8C
        fail "ROM start moved"
        endif

DrawDenpyderCorpse:
; CB/CC draw countdown4..1:2/1,1/1,1/2,1/3; writes Z=$10,0,-$20 on last three. Final corpse1/3; C8/C9 would choose3/4 but normal death overwrites modes.
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $01BA8C
        beq.w        loc_01BACA                                    ; $01BA92
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $01BA96
        beq.w        loc_01BAD8                                    ; $01BA9C
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $01BAA0
        beq.w        loc_01BB62                                    ; $01BAA6
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $01BAAA
        beq.w        loc_01BAE6                                    ; $01BAB0
        cmpi.l       #$23e84a, ActorSpriteBank(a0)                 ; $01BAB4
        move.w       #$1, d0                                       ; $01BABC
        move.w       #$3, d2                                       ; $01BAC0
        jmp          DrawActorAnimation.l                          ; $01BAC4

loc_01BACA:
        move.w       #$3, d0                                       ; $01BACA
        move.w       #$4, d2                                       ; $01BACE
        jmp          DrawActorAnimation.l                          ; $01BAD2

loc_01BAD8:
        move.w       #$3, d0                                       ; $01BAD8
        move.w       #$4, d2                                       ; $01BADC
        jmp          DrawActorAnimation.l                          ; $01BAE0

loc_01BAE6:
        cmpi.b       #$4, ActorStateCounter(a0)                    ; $01BAE6
        beq.b        DrawDenpyderCorpseTransition                  ; $01BAEC
        cmpi.b       #$3, ActorStateCounter(a0)                    ; $01BAEE
        beq.b        loc_01BB1A                                    ; $01BAF4
        cmpi.b       #$2, ActorStateCounter(a0)                    ; $01BAF6
        beq.b        loc_01BB32                                    ; $01BAFC
        cmpi.b       #$1, ActorStateCounter(a0)                    ; $01BAFE
        beq.b        loc_01BB4A                                    ; $01BB04
        rts                                                        ; $01BB06
        ifne *-$1BB08
        fail "ROM end moved"
        endif
