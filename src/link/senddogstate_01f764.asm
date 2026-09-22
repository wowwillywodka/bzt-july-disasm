; $01F764..$01F7E1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Command0D: copied state1 selector exists but normal local Dog never sets1; animation registers not serialized.
        ifne *-$1F764
        fail "ROM start moved"
        endif

SendDogState:
; Command0D: copied state1 selector exists but normal local Dog never sets1; animation registers not serialized.
        lea.l        -$6fdc(a6), a1                                ; $01F764
        move.b       #$d, (a1)+                                    ; $01F768
        move.b       ActorLinkId(a0), (a1)+                        ; $01F76C
        move.w       ActorX(a0), (a1)+                             ; $01F770
        move.w       ActorY(a0), (a1)+                             ; $01F774
        move.w       ActorMotionX(a0), (a1)+                       ; $01F778
        move.w       ActorMotionY(a0), (a1)+                       ; $01F77C
        move.b       ActorState(a0), d7                            ; $01F780
        cmpi.b       #$2, d7                                       ; $01F784
        beq.b        loc_01F792                                    ; $01F788
        cmpi.b       #$1, d7                                       ; $01F78A
        beq.b        loc_01F79C                                    ; $01F78E
        bra.b        loc_01F7F4                                    ; $01F790

loc_01F792:
        tst.w        ActorHealth(a0)                               ; $01F792
        bmi.b        loc_01F79A                                    ; $01F796
        bra.b        loc_01F7F4                                    ; $01F798

loc_01F79A:
        bra.b        loc_01F7F4                                    ; $01F79A

loc_01F79C:
        move.b       ActorStateCounter(a0), d7                     ; $01F79C
        cmpi.b       #$9, d7                                       ; $01F7A0
        beq.b        loc_01F7D8                                    ; $01F7A4
        cmpi.b       #$8, d7                                       ; $01F7A6
        beq.b        loc_01F7D8                                    ; $01F7AA
        cmpi.b       #$2, d7                                       ; $01F7AC
        beq.b        loc_01F7D8                                    ; $01F7B0
        cmpi.b       #$1, d7                                       ; $01F7B2
        beq.b        loc_01F7D8                                    ; $01F7B6
        cmpi.b       #$7, d7                                       ; $01F7B8
        beq.b        ActorsRoutine_01F7E2                          ; $01F7BC
        cmpi.b       #$6, d7                                       ; $01F7BE
        beq.b        ActorsRoutine_01F7E2                          ; $01F7C2
        cmpi.b       #$4, d7                                       ; $01F7C4
        beq.b        ActorsRoutine_01F7E2                          ; $01F7C8
        cmpi.b       #$3, d7                                       ; $01F7CA
        beq.b        ActorsRoutine_01F7E2                          ; $01F7CE
        cmpi.b       #$5, d7                                       ; $01F7D0
        beq.b        loc_01F7EC                                    ; $01F7D4
        rts                                                        ; $01F7D6

loc_01F7D8:
        move.w       #$1, d0                                       ; $01F7D8
        move.w       #$1, d2                                       ; $01F7DC
        bra.b        loc_01F7F4                                    ; $01F7E0
        ifne *-$1F7E2
        fail "ROM end moved"
        endif
