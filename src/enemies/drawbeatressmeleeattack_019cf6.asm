; $019CF6..$019D65 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Active melee animation1: counters6/5 frame1,4 frame2,3 frame3,2 frame4,1 frame5.
        ifne *-$19CF6
        fail "ROM start moved"
        endif

DrawBeatressMeleeAttack:
; Active melee animation1: counters6/5 frame1,4 frame2,3 frame3,2 frame4,1 frame5.
        move.b       ActorStateCounter(a0), d7                     ; $019CF6
        cmpi.b       #$6, d7                                       ; $019CFA
        beq.b        loc_019D20                                    ; $019CFE
        cmpi.b       #$5, d7                                       ; $019D00
        beq.b        loc_019D20                                    ; $019D04
        cmpi.b       #$4, d7                                       ; $019D06
        beq.b        loc_019D2E                                    ; $019D0A
        cmpi.b       #$3, d7                                       ; $019D0C
        beq.b        loc_019D3C                                    ; $019D10
        cmpi.b       #$2, d7                                       ; $019D12
        beq.b        loc_019D4A                                    ; $019D16
        cmpi.b       #$1, d7                                       ; $019D18
        beq.b        loc_019D58                                    ; $019D1C
        rts                                                        ; $019D1E

loc_019D20:
        move.w       #$1, d0                                       ; $019D20
        move.w       #$1, d2                                       ; $019D24
        jmp          DrawActorAnimation.l                          ; $019D28

loc_019D2E:
        move.w       #$1, d0                                       ; $019D2E
        move.w       #$2, d2                                       ; $019D32
        jmp          DrawActorAnimation.l                          ; $019D36

loc_019D3C:
        move.w       #$1, d0                                       ; $019D3C
        move.w       #$3, d2                                       ; $019D40
        jmp          DrawActorAnimation.l                          ; $019D44

loc_019D4A:
        move.w       #$1, d0                                       ; $019D4A
        move.w       #$4, d2                                       ; $019D4E
        jmp          DrawActorAnimation.l                          ; $019D52

loc_019D58:
        move.w       #$1, d0                                       ; $019D58
        move.w       #$5, d2                                       ; $019D5C
        jmp          DrawActorAnimation.l                          ; $019D60
        ifne *-$19D66
        fail "ROM end moved"
        endif
