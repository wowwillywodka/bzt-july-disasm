; $015F42..$015FBD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Grey Dummy counterpart at playerAngle+$180; same weighting, but clears Byte50. These produce movement goals, not firing aim.
        ifne *-$15F42
        fail "ROM start moved"
        endif

ChooseWeightedTargetGoalAtPlus180:
; Grey Dummy counterpart at playerAngle+$180; same weighting, but clears Byte50. These produce movement goals, not firing aim.
        move.b       #$0, ActorState(a0)                           ; $015F42
        jsr          NextRandom.l                                  ; $015F48
        asr.l        #$4, d2                                       ; $015F4E
        move.w       d2, d0                                        ; $015F50
        andi.w       #$1ff, d0                                     ; $015F52
        subi.w       #$100, d0                                     ; $015F56
        lea.l        AngleVectorPairs.w, a4                        ; $015F5A
        move.w       -$71ee(a6), d0                                ; $015F5E
        addi.w       #$180, d0                                     ; $015F62
        andi.w       #$1ff, d0                                     ; $015F66
        lsl.w        #$2, d0                                       ; $015F6A
        move.w       $2(a4, d0.w), d1                              ; $015F6C
        move.w       (a4, d0.w), d0                                ; $015F70
        asl.w        #$1, d0                                       ; $015F74
        asl.w        #$1, d1                                       ; $015F76
        add.w        ActorX(a3), d0                                ; $015F78
        move.w       ActorMotionX(a3), d2                          ; $015F7C
        asr.w        #$1, d2                                       ; $015F80
        clr.l        d3                                            ; $015F82
        move.b       ActorBehaviorByte51(a0), d3                   ; $015F84
        muls.w       d3, d2                                        ; $015F88
        add.w        d2, d0                                        ; $015F8A
        move.w       d0, ActorGoalX(a0)                            ; $015F8C
        clr.w        d0                                            ; $015F90
        move.w       d1, d0                                        ; $015F92
        add.w        ActorY(a3), d0                                ; $015F94
        move.w       ActorMotionY(a3), d2                          ; $015F98
        asr.w        #$1, d2                                       ; $015F9C
        clr.l        d3                                            ; $015F9E
        move.b       ActorBehaviorByte51(a0), d3                   ; $015FA0
        muls.w       d3, d2                                        ; $015FA4
        add.w        d2, d0                                        ; $015FA6
        move.w       d0, ActorGoalY(a0)                            ; $015FA8
        clr.b        ActorBehaviorByte50(a0)                       ; $015FAC
        cmpi.b       #$1, ActorBehaviorByte51(a0)                  ; $015FB0
        beq.b        loc_015FBC                                    ; $015FB6
        subq.b       #$1, ActorBehaviorByte51(a0)                  ; $015FB8

loc_015FBC:
        rts                                                        ; $015FBC
        ifne *-$15FBE
        fail "ROM end moved"
        endif
