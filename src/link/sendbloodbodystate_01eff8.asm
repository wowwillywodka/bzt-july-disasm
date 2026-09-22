; $01EFF8..$01F06B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Command $0D sends ID, XY and MotionXY. Animation choices in D0/D2 are not written to this packet before the shared send tail. Full link behavior remains separate.
        ifne *-$1EFF8
        fail "ROM start moved"
        endif

SendBloodBodyState:
; Command $0D sends ID, XY and MotionXY. Animation choices in D0/D2 are not written to this packet before the shared send tail. Full link behavior remains separate.
        lea.l        -$6fdc(a6), a1                                ; $01EFF8
        move.b       #$d, (a1)+                                    ; $01EFFC
        move.b       ActorLinkId(a0), (a1)+                        ; $01F000
        move.w       ActorX(a0), (a1)+                             ; $01F004
        move.w       ActorY(a0), (a1)+                             ; $01F008
        move.w       ActorMotionX(a0), (a1)+                       ; $01F00C
        move.w       ActorMotionY(a0), (a1)+                       ; $01F010
        move.b       ActorState(a0), d7                            ; $01F014
        cmpi.b       #$2, d7                                       ; $01F018
        beq.b        loc_01F026                                    ; $01F01C
        cmpi.b       #$1, d7                                       ; $01F01E
        beq.b        loc_01F030                                    ; $01F022
        bra.b        loc_01F088                                    ; $01F024

loc_01F026:
        tst.w        ActorHealth(a0)                               ; $01F026
        bmi.b        loc_01F02E                                    ; $01F02A
        bra.b        loc_01F088                                    ; $01F02C

loc_01F02E:
        bra.b        loc_01F088                                    ; $01F02E

loc_01F030:
        move.b       ActorStateCounter(a0), d7                     ; $01F030
        cmpi.b       #$9, d7                                       ; $01F034
        beq.b        ActorsRoutine_01F06C                          ; $01F038
        cmpi.b       #$8, d7                                       ; $01F03A
        beq.b        ActorsRoutine_01F06C                          ; $01F03E
        cmpi.b       #$2, d7                                       ; $01F040
        beq.b        ActorsRoutine_01F06C                          ; $01F044
        cmpi.b       #$1, d7                                       ; $01F046
        beq.b        ActorsRoutine_01F06C                          ; $01F04A
        cmpi.b       #$7, d7                                       ; $01F04C
        beq.b        loc_01F076                                    ; $01F050
        cmpi.b       #$6, d7                                       ; $01F052
        beq.b        loc_01F076                                    ; $01F056
        cmpi.b       #$4, d7                                       ; $01F058
        beq.b        loc_01F076                                    ; $01F05C
        cmpi.b       #$3, d7                                       ; $01F05E
        beq.b        loc_01F076                                    ; $01F062
        cmpi.b       #$5, d7                                       ; $01F064
        beq.b        ActorsRoutine_01F080                          ; $01F068
        rts                                                        ; $01F06A
        ifne *-$1F06C
        fail "ROM end moved"
        endif
