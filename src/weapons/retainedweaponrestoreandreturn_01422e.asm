; $01422E..$0142D3 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1422E
        fail "ROM start moved"
        endif

RetainedWeaponRestoreAndReturn:
        move.l       (a7)+, d3                                     ; $01422E
        rts                                                        ; $014230

SpawnMissedShotImpact:
        move.l       (a7)+, d3                                     ; $014232
        bsr.w        AllocateActor                                 ; $014234
        beq.b        loc_01422C                                    ; $014238
        asr.l        #$3, d3                                       ; $01423A
        asr.l        #$3, d4                                       ; $01423C
        move.w       d3, $24(a0)                                   ; $01423E
        move.w       d4, $26(a0)                                   ; $014242
        move.w       rPlayerViewOffsetZ(a6), d0                                ; $014246
        sub.w        rTransitHeightOffset(a6), d0                                ; $01424A
        move.w       d0, $28(a0)                                   ; $01424E
        clr.b        ActorUpdateDelay(a0)                                       ; $014252
; Impact initialized with state 3; update $01DC20 decrements it and removes on negative. Do not assume every draw starts at state 2.
        move.b       #$3, $38(a0)                                  ; $014256
        move.l       #UpdateMissedShotImpact, ActorUpdateCallback(a0)              ; $01425C
        move.l       #DrawImpactObjectTile, ActorDrawCallback(a0)  ; $014264
        move.l       d0, -(a7)                                     ; $01426C
        move.w       #$1, d0                                       ; $01426E
        move.w       $24(a0), d1                                   ; $014272
        move.w       $26(a0), d2                                   ; $014276
        bsr.w        ActivateEpisode1WallStages                    ; $01427A
        move.l       (a7)+, d0                                     ; $01427E
        tst.w        rLinkRole(a6)                                 ; $014280
        beq.b        loc_01422C                                    ; $014284
        move.l       #RemoveActorAndSendLink, ActorExitCallback(a0) ; $014286
        move.l       #QueueActorLinkCommand10Variants, ActorLinkCallback(a0)  ; $01428E
        lea.l        rSharedScratchBuffer(a6), a1                                ; $014296
        move.b       #$4, (a1)+                                    ; $01429A
        move.b       $42(a0), (a1)+                                ; $01429E
        move.w       $24(a0), (a1)+                                ; $0142A2
        move.w       $26(a0), (a1)+                                ; $0142A6
        move.b       $29(a0), (a1)+                                ; $0142AA
        move.b       $5(a0), d0                                    ; $0142AE
        ori.w        #$20, d0                                      ; $0142B2
        move.b       d0, (a1)+                                     ; $0142B6
        move.b       $36(a0), (a1)+                                ; $0142B8
        move.b       #$c, (a1)+                                    ; $0142BC
        move.w       $2e(a0), (a1)+                                ; $0142C0
        move.w       $30(a0), (a1)+                                ; $0142C4
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0142C8
        jsr          QueueLinkCommand.l                            ; $0142CC
        rts                                                        ; $0142D2
        ifne *-$142D4
        fail "ROM end moved"
        endif
