; $018102..$018167 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Active attack selector after retained state6 animation. Counter9..1 gives animation1 frames1,1,2,2,3,2,2,1,1.
        ifne *-$18102
        fail "ROM start moved"
        endif

DrawBlueDummyAttack:
; Active attack selector after retained state6 animation. Counter9..1 gives animation1 frames1,1,2,2,3,2,2,1,1.
        move.b       ActorStateCounter(a0), d7                     ; $018102
        cmpi.b       #$9, d7                                       ; $018106
        beq.b        loc_01813E                                    ; $01810A
        cmpi.b       #$8, d7                                       ; $01810C
        beq.b        loc_01813E                                    ; $018110
        cmpi.b       #$7, d7                                       ; $018112
        beq.b        loc_01814C                                    ; $018116
        cmpi.b       #$6, d7                                       ; $018118
        beq.b        loc_01814C                                    ; $01811C
        cmpi.b       #$5, d7                                       ; $01811E
        beq.b        loc_01815A                                    ; $018122
        cmpi.b       #$4, d7                                       ; $018124
        beq.b        loc_01814C                                    ; $018128
        cmpi.b       #$3, d7                                       ; $01812A
        beq.b        loc_01814C                                    ; $01812E
        cmpi.b       #$2, d7                                       ; $018130
        beq.b        loc_01813E                                    ; $018134
        cmpi.b       #$1, d7                                       ; $018136
        beq.b        loc_01813E                                    ; $01813A
        rts                                                        ; $01813C

loc_01813E:
        move.w       #$1, d0                                       ; $01813E
        move.w       #$1, d2                                       ; $018142
        jmp          DrawActorAnimation.l                          ; $018146

loc_01814C:
        move.w       #$1, d0                                       ; $01814C
        move.w       #$2, d2                                       ; $018150
        jmp          DrawActorAnimation.l                          ; $018154

loc_01815A:
        move.w       #$1, d0                                       ; $01815A
        move.w       #$3, d2                                       ; $01815E
        jmp          DrawActorAnimation.l                          ; $018162
        ifne *-$18168
        fail "ROM end moved"
        endif
