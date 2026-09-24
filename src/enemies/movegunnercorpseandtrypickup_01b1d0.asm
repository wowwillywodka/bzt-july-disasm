; $01B1D0..$01B2DD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Same local/remote pickup mismatch as White Dummy. Normally skipped while Byte52 exit delay is active; actual opportunity depends on draw/update order.
        ifne *-$1B1D0
        fail "ROM start moved"
        endif

MoveGunnerCorpseAndTryPickup:
; Same local/remote pickup mismatch as White Dummy. Normally skipped while Byte52 exit delay is active; actual opportunity depends on draw/update order.
        move.w       ActorMotionX(a0), d0                          ; $01B1D0
        bmi.b        loc_01B1DA                                    ; $01B1D4
        asr.w        #$1, d0                                       ; $01B1D6
        bra.b        loc_01B1E0                                    ; $01B1D8

loc_01B1DA:
        neg.w        d0                                            ; $01B1DA
        asr.w        #$1, d0                                       ; $01B1DC
        neg.w        d0                                            ; $01B1DE

loc_01B1E0:
        move.w       d0, ActorMotionX(a0)                          ; $01B1E0
        move.w       ActorMotionY(a0), d1                          ; $01B1E4
        bmi.b        loc_01B1EE                                    ; $01B1E8
        asr.w        #$1, d1                                       ; $01B1EA
        bra.b        loc_01B1F4                                    ; $01B1EC

loc_01B1EE:
        neg.w        d1                                            ; $01B1EE
        asr.w        #$1, d1                                       ; $01B1F0
        neg.w        d1                                            ; $01B1F2

loc_01B1F4:
        move.w       d1, ActorMotionY(a0)                          ; $01B1F4
        move.w       d0, d2                                        ; $01B1F8
        or.w         d1, d2                                        ; $01B1FA
        beq.b        loc_01B20A                                    ; $01B1FC
        move.w       d0, ActorMotionX(a0)                          ; $01B1FE
        move.w       d1, ActorMotionY(a0)                          ; $01B202
        bsr.w        MoveActorWithWallMargin32                     ; $01B206

loc_01B20A:
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $01B20A
        beq.b        loc_01B21C                                    ; $01B210
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $01B212
        beq.b        loc_01B21C                                    ; $01B218
        bra.b        loc_01B220                                    ; $01B21A

loc_01B21C:
        bra.w        SteerEnemyMotionAtNearbyWall                         ; $01B21C

loc_01B220:
        movea.l      ActorTarget(a0), a3                           ; $01B220
        move.w       ActorX(a0), d0                                ; $01B224
        sub.w        ActorX(a3), d0                                ; $01B228
        move.w       ActorY(a0), d1                                ; $01B22C
        sub.w        ActorY(a3), d1                                ; $01B230
        move.w       d0, d3                                        ; $01B234
        move.w       d1, d4                                        ; $01B236
        jsr          OctagonalDistance.l                           ; $01B238
        cmpi.w       #$60, d0                                      ; $01B23E
        bcs.b        loc_01B248                                    ; $01B242
        bra.w        SteerEnemyMotionAtNearbyWall                         ; $01B244

loc_01B248:
        tst.b        ActorMarkerTracked(a0)                        ; $01B248
        beq.b        loc_01B258                                    ; $01B24C
        move.w       #$1, rWallOpeningPermit(a6)                   ; $01B24E
        clr.b        ActorMarkerTracked(a0)                        ; $01B254

loc_01B258:
        cmpi.b       #$3, ActorState(a0)                           ; $01B258
        bne.b        loc_01B2DC                                    ; $01B25E
        cmpa.l       #ramPlayerActorProxy, a3                                  ; $01B260
        bne.b        loc_01B2B0                                    ; $01B266
        jsr          NextRandom.l                                  ; $01B268
        asr.w        #$8, d2                                       ; $01B26E
        andi.w       #$1, d2                                       ; $01B270
        addq.w       #$2, d2                                       ; $01B274
        lsl.w        #$8, d2                                       ; $01B276
        move.w       d2, rItemGrantAmountOverride(a6)                                ; $01B278
        move.w       #$c, d0                                       ; $01B27C
        move.l       a0, -(a7)                                     ; $01B280
        jsr          GrantInventoryItem.l                            ; $01B282
        movea.l      (a7)+, a0                                     ; $01B288
        clr.w        rItemGrantAmountOverride(a6)                                    ; $01B28A
        cmpi.w       #$ffff, d7                                    ; $01B28E
        beq.b        loc_01B2DC                                    ; $01B292
        move.b       #$4, ActorState(a0)                           ; $01B294
        move.w       #$60, d0                                      ; $01B29A
        jsr          RouteSoundEventByActorFloor.l                         ; $01B29E
        movea.l      #StatusMessageBuligunCollected, a0            ; $01B2A4
        jmp          QueueStatusMessage.l                          ; $01B2AA

loc_01B2B0:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01B2B0
        move.b       #$4, ActorState(a0)                           ; $01B2B4
        move.b       #$13, (a1)+                                   ; $01B2BA
        move.b       #$8, (a1)+                                    ; $01B2BE
        jsr          NextRandom.l                                  ; $01B2C2
        asr.w        #$8, d2                                       ; $01B2C8
        andi.w       #$1, d2                                       ; $01B2CA
        addq.w       #$2, d2                                       ; $01B2CE
        move.b       d2, (a1)+                                     ; $01B2D0
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01B2D2
        jmp          QueueLinkCommand.l                            ; $01B2D6

loc_01B2DC:
        rts                                                        ; $01B2DC
        ifne *-$1B2DE
        fail "ROM end moved"
        endif
