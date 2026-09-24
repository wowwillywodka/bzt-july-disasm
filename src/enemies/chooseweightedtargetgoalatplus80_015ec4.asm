; $015EC4..$015F41 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Grey Dummy helper: targetXY + 2*vector[(playerAngle+$80)&511] + (targetMotionXY ASR1)*unsigned Byte51. Sets Byte50=1; decrements Byte51 unless exactly1 (zero wraps to255). RNG result overwritten.
        ifne *-$15EC4
        fail "ROM start moved"
        endif

ChooseWeightedTargetGoalAtPlus80:
; Grey Dummy helper: targetXY + 2*vector[(playerAngle+$80)&511] + (targetMotionXY ASR1)*unsigned Byte51. Sets Byte50=1; decrements Byte51 unless exactly1 (zero wraps to255). RNG result overwritten.
        move.b       #$0, ActorState(a0)                           ; $015EC4
        jsr          NextRandom.l                                  ; $015ECA
        asr.l        #$4, d2                                       ; $015ED0
        move.w       d2, d0                                        ; $015ED2
        andi.w       #$1ff, d0                                     ; $015ED4
        subi.w       #$100, d0                                     ; $015ED8
        lea.l        AngleVectorPairs.w, a4                        ; $015EDC
        move.w       rPlayerFacingAngle(a6), d0                                ; $015EE0
        addi.w       #$80, d0                                      ; $015EE4
        andi.w       #$1ff, d0                                     ; $015EE8
        lsl.w        #$2, d0                                       ; $015EEC
        move.w       $2(a4, d0.w), d1                              ; $015EEE
        move.w       (a4, d0.w), d0                                ; $015EF2
        asl.w        #$1, d0                                       ; $015EF6
        asl.w        #$1, d1                                       ; $015EF8
        add.w        ActorX(a3), d0                                ; $015EFA
        move.w       ActorMotionX(a3), d2                          ; $015EFE
        asr.w        #$1, d2                                       ; $015F02
        clr.l        d3                                            ; $015F04
        move.b       ActorBehaviorByte51(a0), d3                   ; $015F06
        muls.w       d3, d2                                        ; $015F0A
        add.w        d2, d0                                        ; $015F0C
        move.w       d0, ActorGoalX(a0)                            ; $015F0E
        clr.w        d0                                            ; $015F12
        move.w       d1, d0                                        ; $015F14
        add.w        ActorY(a3), d0                                ; $015F16
        move.w       ActorMotionY(a3), d2                          ; $015F1A
        asr.w        #$1, d2                                       ; $015F1E
        clr.l        d3                                            ; $015F20
        move.b       ActorBehaviorByte51(a0), d3                   ; $015F22
        muls.w       d3, d2                                        ; $015F26
        add.w        d2, d0                                        ; $015F28
        move.w       d0, ActorGoalY(a0)                            ; $015F2A
        move.b       #$1, ActorBehaviorByte50(a0)                  ; $015F2E
        cmpi.b       #$1, ActorBehaviorByte51(a0)                  ; $015F34
        beq.b        loc_015F40                                    ; $015F3A
        subq.b       #$1, ActorBehaviorByte51(a0)                  ; $015F3C

loc_015F40:
        rts                                                        ; $015F40
        ifne *-$15F42
        fail "ROM end moved"
        endif
