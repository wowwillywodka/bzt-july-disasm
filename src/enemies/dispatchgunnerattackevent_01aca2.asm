; $01ACA2..$01AD61 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; ACTIVE attack-event dispatch reached from $1AC8C, separate from retained exit branch at $1AC9E.
        ifne *-$1ACA2
        fail "ROM start moved"
        endif

DispatchGunnerAttackEvent:
; ACTIVE attack-event dispatch reached from $1AC8C, separate from retained exit branch at $1AC9E.
        cmpi.b       #$5, ActorStateCounter(a0)                    ; $01ACA2
        beq.b        GunnerTryHitTarget                            ; $01ACA8
        cmpi.b       #$4, ActorStateCounter(a0)                    ; $01ACAA
        beq.b        loc_01ACBC                                    ; $01ACB0
        cmpi.b       #$3, ActorStateCounter(a0)                    ; $01ACB2
        beq.b        loc_01ACBC                                    ; $01ACB8
        rts                                                        ; $01ACBA

loc_01ACBC:
        move.w       #$5f, d0                                      ; $01ACBC
        jsr          SoundRoutine_00DF64.l                         ; $01ACC0
        move.w       #$83, d0                                      ; $01ACC6
        jmp          SoundRoutine_00DF64.l                         ; $01ACCA

GunnerTryHitTarget:
        movea.l      ActorTarget(a0), a3                           ; $01ACD0
        move.w       ActorX(a3), d0                                ; $01ACD4
        move.w       ActorY(a3), d1                                ; $01ACD8
        move.w       ActorX(a0), d3                                ; $01ACDC
        move.w       ActorY(a0), d4                                ; $01ACE0
        bsr.w        TraceFiveRayObstructionInActiveWindow         ; $01ACE4
        bne.w        ChooseGunnerGoalOrDie                         ; $01ACE8
        move.w       #$400, d3                                     ; $01ACEC
        tst.w        -$71d8(a6)                                    ; $01ACF0
        bpl.b        loc_01AD06                                    ; $01ACF4
        move.w       #$200, d3                                     ; $01ACF6
        tst.w        rSceneColorMode(a6)                           ; $01ACFA
        beq.b        loc_01AD10                                    ; $01ACFE
        move.w       #$17b, d3                                     ; $01AD00
        bra.b        loc_01AD10                                    ; $01AD04

loc_01AD06:
        tst.w        rSceneColorMode(a6)                           ; $01AD06
        beq.b        loc_01AD20                                    ; $01AD0A
        move.w       #$300, d3                                     ; $01AD0C

loc_01AD10:
        jsr          NextRandom.l                                  ; $01AD10
        asr.l        #$8, d2                                       ; $01AD16
        andi.w       #$3ff, d2                                     ; $01AD18
        cmp.w        d3, d2                                        ; $01AD1C
        bcc.b        loc_01AD4C                                    ; $01AD1E

loc_01AD20:
        move.w       ActorX(a0), d0                                ; $01AD20
        move.w       ActorY(a0), d1                                ; $01AD24
        sub.w        ActorX(a3), d0                                ; $01AD28
        sub.w        ActorY(a3), d1                                ; $01AD2C
        move.w       d0, d3                                        ; $01AD30
        move.w       d1, d4                                        ; $01AD32
        jsr          OctagonalDistance.l                           ; $01AD34
        cmpi.w       #$400, d0                                     ; $01AD3A
        bcc.b        loc_01AD60                                    ; $01AD3E
; No final RNG &3 miss gate: direct target hit callback receives the ACTUAL octagonal distance<$400 in D0.w, unlike White Dummy. No projectile allocated.
        move.l       a0, -(a7)                                     ; $01AD40
        movea.l      a3, a0                                        ; $01AD42
        movea.l      ActorHitCallback(a0), a1                      ; $01AD44
        jsr          (a1)                                          ; $01AD48
        movea.l      (a7)+, a0                                     ; $01AD4A

loc_01AD4C:
        move.w       #$5f, d0                                      ; $01AD4C
        jsr          SoundRoutine_00DF64.l                         ; $01AD50
        move.w       #$83, d0                                      ; $01AD56
        jsr          SoundRoutine_00DF64.l                         ; $01AD5A

loc_01AD60:
        rts                                                        ; $01AD60
        ifne *-$1AD62
        fail "ROM end moved"
        endif
