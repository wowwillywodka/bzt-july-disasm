; $016AE2..$016BE1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Attack counter: hit attempt5, sounds4/3, resume at0 with counter5. Obstruction resumes movement at counter5. Neither route changes Byte50.
        ifne *-$16AE2
        fail "ROM start moved"
        endif

TickGreyDummyAttack:
; Attack counter: hit attempt5, sounds4/3, resume at0 with counter5. Obstruction resumes movement at counter5. Neither route changes Byte50.
        cmpi.b       #$1, ActorState(a0)                           ; $016AE2
        beq.b        GreyDummyTickAttackCounter                    ; $016AE8
        subq.b       #$1, ActorStateCounter(a0)                    ; $016AEA
        beq.b        loc_016AF2                                    ; $016AEE
        rts                                                        ; $016AF0

loc_016AF2:
        move.b       #$1, ActorState(a0)                           ; $016AF2
        move.b       #$a, ActorStateCounter(a0)                    ; $016AF8
        rts                                                        ; $016AFE

GreyDummyTickAttackCounter:
        subq.b       #$1, ActorStateCounter(a0)                    ; $016B00
        bne.b        loc_016B16                                    ; $016B04
        move.b       #$5, ActorStateCounter(a0)                    ; $016B06

loc_016B0C:
        move.b       #$0, ActorState(a0)                           ; $016B0C
        bra.w        RefreshEnemyTargetOrExit                      ; $016B12

loc_016B16:
        cmpi.b       #$5, ActorStateCounter(a0)                    ; $016B16
        beq.b        GreyDummyTryHitTarget                         ; $016B1C
        cmpi.b       #$4, ActorStateCounter(a0)                    ; $016B1E
        beq.b        loc_016B30                                    ; $016B24
        cmpi.b       #$3, ActorStateCounter(a0)                    ; $016B26
        beq.b        loc_016B30                                    ; $016B2C
        rts                                                        ; $016B2E

loc_016B30:
        move.w       #$5f, d0                                      ; $016B30
        jsr          SoundRoutine_00DF64.l                         ; $016B34
        move.w       #$83, d0                                      ; $016B3A
        jmp          SoundRoutine_00DF64.l                         ; $016B3E

GreyDummyTryHitTarget:
        movea.l      ActorTarget(a0), a3                           ; $016B44
        move.w       ActorX(a3), d0                                ; $016B48
        move.w       ActorY(a3), d1                                ; $016B4C
        move.w       ActorX(a0), d3                                ; $016B50
        move.w       ActorY(a0), d4                                ; $016B54
        bsr.w        TraceFiveRayObstructionInActiveWindow         ; $016B58
        bne.b        loc_016B0C                                    ; $016B5C
        move.w       #$400, d3                                     ; $016B5E
        tst.w        -$71d8(a6)                                    ; $016B62
        bpl.b        loc_016B78                                    ; $016B66
        move.w       #$200, d3                                     ; $016B68
        tst.w        rSceneColorMode(a6)                           ; $016B6C
        beq.b        loc_016B82                                    ; $016B70
        move.w       #$17b, d3                                     ; $016B72
        bra.b        loc_016B82                                    ; $016B76

loc_016B78:
        tst.w        rSceneColorMode(a6)                           ; $016B78
        beq.b        loc_016B92                                    ; $016B7C
        move.w       #$300, d3                                     ; $016B7E

loc_016B82:
        jsr          NextRandom.l                                  ; $016B82
        asr.l        #$8, d2                                       ; $016B88
        andi.w       #$3ff, d2                                     ; $016B8A
        cmp.w        d3, d2                                        ; $016B8E
        bcc.b        loc_016BCC                                    ; $016B90

loc_016B92:
        move.w       ActorX(a0), d0                                ; $016B92
        move.w       ActorY(a0), d1                                ; $016B96
        sub.w        ActorX(a3), d0                                ; $016B9A
        sub.w        ActorY(a3), d1                                ; $016B9E
        move.w       d0, d3                                        ; $016BA2
        move.w       d1, d4                                        ; $016BA4
        jsr          OctagonalDistance.l                           ; $016BA6
        cmpi.w       #$400, d0                                     ; $016BAC
        bcc.b        loc_016BE0                                    ; $016BB0
; NextRandom has cleared D0.w; target hit callback receives zero distance. This is a direct callback, not a spawned projectile.
        jsr          NextRandom.w                                  ; $016BB2
        asr.w        #$8, d2                                       ; $016BB6
        andi.w       #$3, d2                                       ; $016BB8
        beq.w        loc_016BE0                                    ; $016BBC
        move.l       a0, -(a7)                                     ; $016BC0
        movea.l      a3, a0                                        ; $016BC2
        movea.l      ActorHitCallback(a0), a1                      ; $016BC4
        jsr          (a1)                                          ; $016BC8
        movea.l      (a7)+, a0                                     ; $016BCA

loc_016BCC:
        move.w       #$5f, d0                                      ; $016BCC
        jsr          SoundRoutine_00DF64.l                         ; $016BD0
        move.w       #$83, d0                                      ; $016BD6
        jsr          SoundRoutine_00DF64.l                         ; $016BDA

loc_016BE0:
        rts                                                        ; $016BE0
        ifne *-$16BE2
        fail "ROM end moved"
        endif
