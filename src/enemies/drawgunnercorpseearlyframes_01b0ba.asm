; $01B0BA..$01B101 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Draw-driven transition frames: counters11/10 ->3/1; 9/8 ->3/2; 7/6 AND1 ->3/3; 5/4 ->3/4; 3/2 ->3/5. Counter1 does not select frame6.
        ifne *-$1B0BA
        fail "ROM start moved"
        endif

DrawGunnerCorpseEarlyFrames:
; Draw-driven transition frames: counters11/10 ->3/1; 9/8 ->3/2; 7/6 AND1 ->3/3; 5/4 ->3/4; 3/2 ->3/5. Counter1 does not select frame6.
        move.w       #$3, d0                                       ; $01B0BA
        move.w       #$1, d2                                       ; $01B0BE
        subq.b       #$1, ActorStateCounter(a0)                    ; $01B0C2
        jmp          DrawActorAnimation.l                          ; $01B0C6

loc_01B0CC:
        move.w       #$3, d0                                       ; $01B0CC
        move.w       #$2, d2                                       ; $01B0D0
        subq.b       #$1, ActorStateCounter(a0)                    ; $01B0D4
        jmp          DrawActorAnimation.l                          ; $01B0D8

loc_01B0DE:
        move.w       #$3, d0                                       ; $01B0DE
        move.w       #$3, d2                                       ; $01B0E2
        subq.b       #$1, ActorStateCounter(a0)                    ; $01B0E6
        jmp          DrawActorAnimation.l                          ; $01B0EA

loc_01B0F0:
        move.w       #$3, d0                                       ; $01B0F0
        move.w       #$4, d2                                       ; $01B0F4
        subq.b       #$1, ActorStateCounter(a0)                    ; $01B0F8
        jmp          DrawActorAnimation.l                          ; $01B0FC
        ifne *-$1B102
        fail "ROM end moved"
        endif
