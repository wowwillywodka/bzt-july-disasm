; $01F174..$01F1E7 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Command0D writes ID, XY and MotionXY. Selected animation D0/D2 are not serialized by tail $1F204; receiver behavior is a separate contract.
        ifne *-$1F174
        fail "ROM start moved"
        endif

SendGunnerState:
; Command0D writes ID, XY and MotionXY. Selected animation D0/D2 are not serialized by tail $1F204; receiver behavior is a separate contract.
        lea.l        -$6fdc(a6), a1                                ; $01F174
        move.b       #$d, (a1)+                                    ; $01F178
        move.b       ActorLinkId(a0), (a1)+                        ; $01F17C
        move.w       ActorX(a0), (a1)+                             ; $01F180
        move.w       ActorY(a0), (a1)+                             ; $01F184
        move.w       ActorMotionX(a0), (a1)+                       ; $01F188
        move.w       ActorMotionY(a0), (a1)+                       ; $01F18C
        move.b       ActorState(a0), d7                            ; $01F190
        cmpi.b       #$2, d7                                       ; $01F194
        beq.b        loc_01F1A2                                    ; $01F198
        cmpi.b       #$1, d7                                       ; $01F19A
        beq.b        loc_01F1AC                                    ; $01F19E
        bra.b        loc_01F204                                    ; $01F1A0

loc_01F1A2:
        tst.w        ActorHealth(a0)                               ; $01F1A2
        bmi.b        loc_01F1AA                                    ; $01F1A6
        bra.b        loc_01F204                                    ; $01F1A8

loc_01F1AA:
        bra.b        loc_01F204                                    ; $01F1AA

loc_01F1AC:
        move.b       ActorStateCounter(a0), d7                     ; $01F1AC
        cmpi.b       #$9, d7                                       ; $01F1B0
        beq.b        ActorsRoutine_01F1E8                          ; $01F1B4
        cmpi.b       #$8, d7                                       ; $01F1B6
        beq.b        ActorsRoutine_01F1E8                          ; $01F1BA
        cmpi.b       #$2, d7                                       ; $01F1BC
        beq.b        ActorsRoutine_01F1E8                          ; $01F1C0
        cmpi.b       #$1, d7                                       ; $01F1C2
        beq.b        ActorsRoutine_01F1E8                          ; $01F1C6
        cmpi.b       #$7, d7                                       ; $01F1C8
        beq.b        ActorsRoutine_01F1F2                          ; $01F1CC
        cmpi.b       #$6, d7                                       ; $01F1CE
        beq.b        ActorsRoutine_01F1F2                          ; $01F1D2
        cmpi.b       #$4, d7                                       ; $01F1D4
        beq.b        ActorsRoutine_01F1F2                          ; $01F1D8
        cmpi.b       #$3, d7                                       ; $01F1DA
        beq.b        ActorsRoutine_01F1F2                          ; $01F1DE
        cmpi.b       #$5, d7                                       ; $01F1E0
        beq.b        loc_01F1FC                                    ; $01F1E4
        rts                                                        ; $01F1E6
        ifne *-$1F1E8
        fail "ROM end moved"
        endif
