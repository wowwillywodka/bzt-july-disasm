; $01A3F6..$01A4C3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; ACTIVE attack-event dispatch reached from $1A3E0; preceding $1A3F2 is a separate retained branch.
        ifne *-$1A3F6
        fail "ROM start moved"
        endif

DispatchWhiteDummyAttackEvent:
; ACTIVE attack-event dispatch reached from $1A3E0; preceding $1A3F2 is a separate retained branch.
        cmpi.b       #$5, ActorStateCounter(a0)                    ; $01A3F6
        beq.b        WhiteDummyTryHitTarget                        ; $01A3FC
        cmpi.b       #$4, ActorStateCounter(a0)                    ; $01A3FE
        beq.b        loc_01A410                                    ; $01A404
        cmpi.b       #$3, ActorStateCounter(a0)                    ; $01A406
        beq.b        loc_01A410                                    ; $01A40C
        rts                                                        ; $01A40E

loc_01A410:
        move.w       #$5f, d0                                      ; $01A410
        jsr          SoundRoutine_00DF64.l                         ; $01A414
        move.w       #$83, d0                                      ; $01A41A
        jmp          SoundRoutine_00DF64.l                         ; $01A41E

WhiteDummyTryHitTarget:
        movea.l      ActorTarget(a0), a3                           ; $01A424
        move.w       ActorX(a3), d0                                ; $01A428
        move.w       ActorY(a3), d1                                ; $01A42C
        move.w       ActorX(a0), d3                                ; $01A430
        move.w       ActorY(a0), d4                                ; $01A434
        bsr.w        TraceFiveRayObstructionInActiveWindow         ; $01A438
        bne.w        ChooseWhiteDummyGoalOrDie                     ; $01A43C
        move.w       #$400, d3                                     ; $01A440
        tst.w        -$71d8(a6)                                    ; $01A444
        bpl.b        loc_01A45A                                    ; $01A448
        move.w       #$200, d3                                     ; $01A44A
        tst.w        rSceneColorMode(a6)                           ; $01A44E
        beq.b        loc_01A464                                    ; $01A452
        move.w       #$17b, d3                                     ; $01A454
        bra.b        loc_01A464                                    ; $01A458

loc_01A45A:
        tst.w        rSceneColorMode(a6)                           ; $01A45A
        beq.b        loc_01A474                                    ; $01A45E
        move.w       #$300, d3                                     ; $01A460

loc_01A464:
        jsr          NextRandom.l                                  ; $01A464
        asr.l        #$8, d2                                       ; $01A46A
        andi.w       #$3ff, d2                                     ; $01A46C
        cmp.w        d3, d2                                        ; $01A470
        bcc.b        loc_01A4AE                                    ; $01A472

loc_01A474:
        move.w       ActorX(a0), d0                                ; $01A474
        move.w       ActorY(a0), d1                                ; $01A478
        sub.w        ActorX(a3), d0                                ; $01A47C
        sub.w        ActorY(a3), d1                                ; $01A480
        move.w       d0, d3                                        ; $01A484
        move.w       d1, d4                                        ; $01A486
        jsr          OctagonalDistance.l                           ; $01A488
        cmpi.w       #$400, d0                                     ; $01A48E
        bcc.b        loc_01A4C2                                    ; $01A492
; Final RNG &3 gate clears D0.w: successful direct hit callback gets zero distance. No projectile allocation.
        jsr          NextRandom.w                                  ; $01A494
        asr.w        #$8, d2                                       ; $01A498
        andi.w       #$3, d2                                       ; $01A49A
        beq.w        loc_01A4C2                                    ; $01A49E
        move.l       a0, -(a7)                                     ; $01A4A2
        movea.l      a3, a0                                        ; $01A4A4
        movea.l      ActorHitCallback(a0), a1                      ; $01A4A6
        jsr          (a1)                                          ; $01A4AA
        movea.l      (a7)+, a0                                     ; $01A4AC

loc_01A4AE:
        move.w       #$5f, d0                                      ; $01A4AE
        jsr          SoundRoutine_00DF64.l                         ; $01A4B2
        move.w       #$83, d0                                      ; $01A4B8
        jsr          SoundRoutine_00DF64.l                         ; $01A4BC

loc_01A4C2:
        rts                                                        ; $01A4C2
        ifne *-$1A4C4
        fail "ROM end moved"
        endif
