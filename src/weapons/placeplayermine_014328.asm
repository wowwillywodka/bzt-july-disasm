; $014328..$014427 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Mine action blocked only by lowering; consume one item BEFORE allocation. Probe up to8 forward/16 steps, place at last clear XY. No refund on allocation failure.
        ifne *-$14328
        fail "ROM start moved"
        endif

PlacePlayerMine:
; Mine action blocked only by lowering; consume one item BEFORE allocation. Probe up to8 forward/16 steps, place at last clear XY. No refund on allocation failure.
        tst.w        rWeaponLoweringOffset(a6)                     ; $014328
        bne.w        loc_014426                                    ; $01432C
        move.w       #$63, d0                                      ; $014330
        jsr          PlaySoundEventAndMaybeSendLink.l                         ; $014334
        bsr.w        ConsumeSelectedItemAndUpdateHud               ; $01433A
        bsr.w        AllocateActor                                 ; $01433E
        beq.w        loc_014426                                    ; $014342
; This initial 31-visit delay is conditional: the branch at $0143C8 clears it.
        move.b       #$1e, ActorUpdateDelay(a0)                                 ; $014346
        clr.b        $22(a0)                                       ; $01434C
        move.l       #UpdatePlayerProximityMine, ActorUpdateCallback(a0) ; $014350
        move.l       #DrawProximityMineTile, ActorDrawCallback(a0)            ; $014358
        move.l       #ExplodeProjectileOnNearHit, ActorHitCallback(a0) ; $014360
        ori.w        #$8, $4(a0)                                   ; $014368
        move.w       rPlayerFacingVectorX(a6), d5                                ; $01436E
        asr.w        #$4, d5                                       ; $014372
        move.w       rPlayerFacingVectorY(a6), d6                                ; $014374
        asr.w        #$4, d6                                       ; $014378
        move.w       rPlayerX(a6), d3                              ; $01437A
        move.w       rPlayerY(a6), d4                              ; $01437E
        move.w       #$7, d7                                       ; $014382

loc_014386:
        move.w       d3, d0                                        ; $014386
        move.w       d4, d1                                        ; $014388
        add.w        d5, d0                                        ; $01438A
        add.w        d6, d1                                        ; $01438C
        movem.w      d3-d7, -(a7)                                  ; $01438E
        jsr          TestProjectilePointInVisibleMap.l             ; $014392
        bne.b        loc_0143A8                                    ; $014398
        movem.w      (a7)+, d3-d7                                  ; $01439A
        add.w        d5, d3                                        ; $01439E
        add.w        d6, d4                                        ; $0143A0
        dbra         d7, loc_014386                                ; $0143A2
        bra.b        loc_0143AC                                    ; $0143A6

loc_0143A8:
        movem.w      (a7)+, d3-d7                                  ; $0143A8

loc_0143AC:
        move.w       d3, $24(a0)                                   ; $0143AC
        move.w       d4, $26(a0)                                   ; $0143B0
        move.w       #$ffe0, d0                                    ; $0143B4
        sub.w        rTransitHeightOffset(a6), d0                                ; $0143B8
        move.w       d0, $28(a0)                                   ; $0143BC
        jsr          ClassifyPlayerCellForWeapon.l                       ; $0143C0
        beq.b        loc_0143D4                                    ; $0143C6
        clr.b        ActorUpdateDelay(a0)                                       ; $0143C8
        move.l       #ResolveSpecialCellProjectileImpact, ActorUpdateCallback(a0) ; $0143CC

loc_0143D4:
        tst.w        rLinkRole(a6)                                 ; $0143D4
        beq.b        loc_014426                                    ; $0143D8
        move.l       #RemoveActorAndSendLink, ActorExitCallback(a0) ; $0143DA
        move.l       #ActorLinkNoOp, ActorLinkCallback(a0)                ; $0143E2
        lea.l        rSharedScratchBuffer(a6), a1                                ; $0143EA
        move.b       #$4, (a1)+                                    ; $0143EE
        move.b       $42(a0), (a1)+                                ; $0143F2
        move.w       $24(a0), (a1)+                                ; $0143F6
        move.w       $26(a0), (a1)+                                ; $0143FA
        move.b       $29(a0), (a1)+                                ; $0143FE
        move.b       $5(a0), d0                                    ; $014402
        ori.w        #$20, d0                                      ; $014406
        move.b       d0, (a1)+                                     ; $01440A
        move.b       $36(a0), (a1)+                                ; $01440C
        move.b       #$2, (a1)+                                    ; $014410
        move.w       $2e(a0), (a1)+                                ; $014414
        move.w       $30(a0), (a1)+                                ; $014418
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01441C
        jsr          QueueLinkCommand.l                            ; $014420

loc_014426:
        rts                                                        ; $014426
        ifne *-$14428
        fail "ROM end moved"
        endif
