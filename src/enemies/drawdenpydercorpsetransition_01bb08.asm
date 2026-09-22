; $01BB08..$01BB63 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Draw-driven corpse transition and Z changes, not update-time motion.
        ifne *-$1BB08
        fail "ROM start moved"
        endif

DrawDenpyderCorpseTransition:
; Draw-driven corpse transition and Z changes, not update-time motion.
        move.w       #$2, d0                                       ; $01BB08
        move.w       #$1, d2                                       ; $01BB0C
        subq.b       #$1, ActorStateCounter(a0)                    ; $01BB10
        jmp          DrawActorAnimation.l                          ; $01BB14

loc_01BB1A:
        move.w       #$1, d0                                       ; $01BB1A
        move.w       #$1, d2                                       ; $01BB1E
        subq.b       #$1, ActorStateCounter(a0)                    ; $01BB22
        move.w       #$10, ActorZ(a0)                              ; $01BB26
        jmp          DrawActorAnimation.l                          ; $01BB2C

loc_01BB32:
        move.w       #$1, d0                                       ; $01BB32
        move.w       #$2, d2                                       ; $01BB36
        subq.b       #$1, ActorStateCounter(a0)                    ; $01BB3A
        move.w       #$0, ActorZ(a0)                               ; $01BB3E
        jmp          DrawActorAnimation.l                          ; $01BB44

loc_01BB4A:
        move.w       #$1, d0                                       ; $01BB4A
        move.w       #$3, d2                                       ; $01BB4E
        subq.b       #$1, ActorStateCounter(a0)                    ; $01BB52
        move.w       #$ffe0, ActorZ(a0)                            ; $01BB56
        jmp          DrawActorAnimation.l                          ; $01BB5C

loc_01BB62:
        bra.b        loc_01BAE6                                    ; $01BB62
        ifne *-$1BB64
        fail "ROM end moved"
        endif
