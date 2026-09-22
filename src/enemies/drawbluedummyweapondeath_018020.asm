; $018020..$018097 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; State5 counters7/6 ->6/1;5/4 ->4/1;3,2,1 ->4/2,3,4. All exist. State6 animation4/1..5 sequence is skipped by early RTS.
        ifne *-$18020
        fail "ROM start moved"
        endif

DrawBlueDummyWeaponDeath:
; State5 counters7/6 ->6/1;5/4 ->4/1;3,2,1 ->4/2,3,4. All exist. State6 animation4/1..5 sequence is skipped by early RTS.
        move.b       ActorStateCounter(a0), d7                     ; $018020
        cmpi.b       #$7, d7                                       ; $018024
        beq.b        loc_018050                                    ; $018028
        cmpi.b       #$6, d7                                       ; $01802A
        beq.b        loc_018050                                    ; $01802E
        cmpi.b       #$5, d7                                       ; $018030
        beq.b        loc_01805E                                    ; $018034
        cmpi.b       #$4, d7                                       ; $018036
        beq.b        loc_01805E                                    ; $01803A
        cmpi.b       #$3, d7                                       ; $01803C
        beq.b        loc_01806C                                    ; $018040
        cmpi.b       #$2, d7                                       ; $018042
        beq.b        loc_01807A                                    ; $018046
        cmpi.b       #$1, d7                                       ; $018048
        beq.b        loc_018088                                    ; $01804C
        rts                                                        ; $01804E

loc_018050:
        move.w       #$6, d0                                       ; $018050
        move.w       #$1, d2                                       ; $018054
        jmp          DrawActorAnimation.l                          ; $018058

loc_01805E:
        move.w       #$4, d0                                       ; $01805E
        move.w       #$1, d2                                       ; $018062
        jmp          DrawActorAnimation.l                          ; $018066

loc_01806C:
        move.w       #$4, d0                                       ; $01806C
        move.w       #$2, d2                                       ; $018070
        jmp          DrawActorAnimation.l                          ; $018074

loc_01807A:
        move.w       #$4, d0                                       ; $01807A
        move.w       #$3, d2                                       ; $01807E
        jmp          DrawActorAnimation.l                          ; $018082

loc_018088:
        move.w       #$4, d0                                       ; $018088
        move.w       #$4, d2                                       ; $01808C
        jmp          DrawActorAnimation.l                          ; $018090

BlueDummySkipStateSixDrawing:
        rts                                                        ; $018096
        ifne *-$18098
        fail "ROM end moved"
        endif
