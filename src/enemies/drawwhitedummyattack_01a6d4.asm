; $01A6D4..$01A739 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Active attack1 frame selection, counters9..1. Reached from $1A5B6.
        ifne *-$1A6D4
        fail "ROM start moved"
        endif

DrawWhiteDummyAttack:
; Active attack1 frame selection, counters9..1. Reached from $1A5B6.
        move.b       ActorStateCounter(a0), d7                     ; $01A6D4
        cmpi.b       #$9, d7                                       ; $01A6D8
        beq.b        loc_01A710                                    ; $01A6DC
        cmpi.b       #$8, d7                                       ; $01A6DE
        beq.b        loc_01A710                                    ; $01A6E2
        cmpi.b       #$7, d7                                       ; $01A6E4
        beq.b        loc_01A71E                                    ; $01A6E8
        cmpi.b       #$6, d7                                       ; $01A6EA
        beq.b        loc_01A71E                                    ; $01A6EE
        cmpi.b       #$5, d7                                       ; $01A6F0
        beq.b        loc_01A72C                                    ; $01A6F4
        cmpi.b       #$4, d7                                       ; $01A6F6
        beq.b        loc_01A71E                                    ; $01A6FA
        cmpi.b       #$3, d7                                       ; $01A6FC
        beq.b        loc_01A71E                                    ; $01A700
        cmpi.b       #$2, d7                                       ; $01A702
        beq.b        loc_01A710                                    ; $01A706
        cmpi.b       #$1, d7                                       ; $01A708
        beq.b        loc_01A710                                    ; $01A70C
        rts                                                        ; $01A70E

loc_01A710:
        move.w       #$1, d0                                       ; $01A710
        move.w       #$1, d2                                       ; $01A714
        jmp          DrawActorAnimation.l                          ; $01A718

loc_01A71E:
        move.w       #$1, d0                                       ; $01A71E
        move.w       #$2, d2                                       ; $01A722
        jmp          DrawActorAnimation.l                          ; $01A726

loc_01A72C:
        move.w       #$1, d0                                       ; $01A72C
        move.w       #$3, d2                                       ; $01A730
        jmp          DrawActorAnimation.l                          ; $01A734
        ifne *-$1A73A
        fail "ROM end moved"
        endif
