; $01F6A6..$01F723 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Command0D: ID/XY/MotionXY only, animation registers not serialized.
        ifne *-$1F6A6
        fail "ROM start moved"
        endif

SendBlueDummyState:
; Command0D: ID/XY/MotionXY only, animation registers not serialized.
        lea.l        -$6fdc(a6), a1                                ; $01F6A6
        move.b       #$d, (a1)+                                    ; $01F6AA
        move.b       ActorLinkId(a0), (a1)+                        ; $01F6AE
        move.w       ActorX(a0), (a1)+                             ; $01F6B2
        move.w       ActorY(a0), (a1)+                             ; $01F6B6
        move.w       ActorMotionX(a0), (a1)+                       ; $01F6BA
        move.w       ActorMotionY(a0), (a1)+                       ; $01F6BE
        move.b       ActorState(a0), d7                            ; $01F6C2
        cmpi.b       #$2, d7                                       ; $01F6C6
        beq.b        loc_01F6D4                                    ; $01F6CA
        cmpi.b       #$1, d7                                       ; $01F6CC
        beq.b        loc_01F6DE                                    ; $01F6D0
        bra.b        loc_01F736                                    ; $01F6D2

loc_01F6D4:
        tst.w        ActorHealth(a0)                               ; $01F6D4
        bmi.b        loc_01F6DC                                    ; $01F6D8
        bra.b        loc_01F736                                    ; $01F6DA

loc_01F6DC:
        bra.b        loc_01F736                                    ; $01F6DC

loc_01F6DE:
        move.b       ActorStateCounter(a0), d7                     ; $01F6DE
        cmpi.b       #$9, d7                                       ; $01F6E2
        beq.b        loc_01F71A                                    ; $01F6E6
        cmpi.b       #$8, d7                                       ; $01F6E8
        beq.b        loc_01F71A                                    ; $01F6EC
        cmpi.b       #$2, d7                                       ; $01F6EE
        beq.b        loc_01F71A                                    ; $01F6F2
        cmpi.b       #$1, d7                                       ; $01F6F4
        beq.b        loc_01F71A                                    ; $01F6F8
        cmpi.b       #$7, d7                                       ; $01F6FA
        beq.b        ActorsRoutine_01F724                          ; $01F6FE
        cmpi.b       #$6, d7                                       ; $01F700
        beq.b        ActorsRoutine_01F724                          ; $01F704
        cmpi.b       #$4, d7                                       ; $01F706
        beq.b        ActorsRoutine_01F724                          ; $01F70A
        cmpi.b       #$3, d7                                       ; $01F70C
        beq.b        ActorsRoutine_01F724                          ; $01F710
        cmpi.b       #$5, d7                                       ; $01F712
        beq.b        loc_01F72E                                    ; $01F716
        rts                                                        ; $01F718

loc_01F71A:
        move.w       #$1, d0                                       ; $01F71A
        move.w       #$1, d2                                       ; $01F71E
        bra.b        loc_01F736                                    ; $01F722
        ifne *-$1F724
        fail "ROM end moved"
        endif
