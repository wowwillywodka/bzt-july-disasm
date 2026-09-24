; $01BBDA..$01BCE7 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Corpse damping uses $1D306, unlike living Denpyder. Marker release can occur at distance<$60 even in state4; item grant requires3 and is not enabled by ordinary local death.
        ifne *-$1BBDA
        fail "ROM start moved"
        endif

MoveDenpyderCorpseAndTryPickup:
; Corpse damping uses $1D306, unlike living Denpyder. Marker release can occur at distance<$60 even in state4; item grant requires3 and is not enabled by ordinary local death.
        move.w       ActorMotionX(a0), d0                          ; $01BBDA
        bmi.b        loc_01BBE4                                    ; $01BBDE
        asr.w        #$1, d0                                       ; $01BBE0
        bra.b        loc_01BBEA                                    ; $01BBE2

loc_01BBE4:
        neg.w        d0                                            ; $01BBE4
        asr.w        #$1, d0                                       ; $01BBE6
        neg.w        d0                                            ; $01BBE8

loc_01BBEA:
        move.w       d0, ActorMotionX(a0)                          ; $01BBEA
        move.w       ActorMotionY(a0), d1                          ; $01BBEE
        bmi.b        loc_01BBF8                                    ; $01BBF2
        asr.w        #$1, d1                                       ; $01BBF4
        bra.b        loc_01BBFE                                    ; $01BBF6

loc_01BBF8:
        neg.w        d1                                            ; $01BBF8
        asr.w        #$1, d1                                       ; $01BBFA
        neg.w        d1                                            ; $01BBFC

loc_01BBFE:
        move.w       d1, ActorMotionY(a0)                          ; $01BBFE
        move.w       d0, d2                                        ; $01BC02
        or.w         d1, d2                                        ; $01BC04
        beq.b        loc_01BC14                                    ; $01BC06
        move.w       d0, ActorMotionX(a0)                          ; $01BC08
        move.w       d1, ActorMotionY(a0)                          ; $01BC0C
        bsr.w        MoveActorWithWallMargin32                     ; $01BC10

loc_01BC14:
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $01BC14
        beq.b        loc_01BC26                                    ; $01BC1A
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $01BC1C
        beq.b        loc_01BC26                                    ; $01BC22
        bra.b        loc_01BC2A                                    ; $01BC24

loc_01BC26:
        bra.w        SteerEnemyMotionAtNearbyWall                         ; $01BC26

loc_01BC2A:
        movea.l      ActorTarget(a0), a3                           ; $01BC2A
        move.w       ActorX(a0), d0                                ; $01BC2E
        sub.w        ActorX(a3), d0                                ; $01BC32
        move.w       ActorY(a0), d1                                ; $01BC36
        sub.w        ActorY(a3), d1                                ; $01BC3A
        move.w       d0, d3                                        ; $01BC3E
        move.w       d1, d4                                        ; $01BC40
        jsr          OctagonalDistance.l                           ; $01BC42
        cmpi.w       #$60, d0                                      ; $01BC48
        bcs.b        loc_01BC52                                    ; $01BC4C
        bra.w        SteerEnemyMotionAtNearbyWall                         ; $01BC4E

loc_01BC52:
        tst.b        ActorMarkerTracked(a0)                        ; $01BC52
        beq.b        loc_01BC62                                    ; $01BC56
        move.w       #$1, rWallOpeningPermit(a6)                   ; $01BC58
        clr.b        ActorMarkerTracked(a0)                        ; $01BC5E

loc_01BC62:
        cmpi.b       #$3, ActorState(a0)                           ; $01BC62
        bne.b        loc_01BCE6                                    ; $01BC68
        cmpa.l       #ramPlayerActorProxy, a3                                  ; $01BC6A
        bne.b        loc_01BCBA                                    ; $01BC70
        jsr          NextRandom.l                                  ; $01BC72
        asr.w        #$8, d2                                       ; $01BC78
        andi.w       #$1, d2                                       ; $01BC7A
        addq.w       #$2, d2                                       ; $01BC7E
        lsl.w        #$8, d2                                       ; $01BC80
        move.w       d2, rItemGrantAmountOverride(a6)                                ; $01BC82
        move.w       #$c, d0                                       ; $01BC86
        move.l       a0, -(a7)                                     ; $01BC8A
        jsr          GrantInventoryItem.l                            ; $01BC8C
        movea.l      (a7)+, a0                                     ; $01BC92
        clr.w        rItemGrantAmountOverride(a6)                                    ; $01BC94
        cmpi.w       #$ffff, d7                                    ; $01BC98
        beq.b        loc_01BCE6                                    ; $01BC9C
        move.b       #$4, ActorState(a0)                           ; $01BC9E
        move.w       #$60, d0                                      ; $01BCA4
        jsr          RouteSoundEventByActorFloor.l                         ; $01BCA8
        movea.l      #StatusMessageBuligunCollected, a0            ; $01BCAE
        jmp          QueueStatusMessage.l                          ; $01BCB4

loc_01BCBA:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01BCBA
        move.b       #$4, ActorState(a0)                           ; $01BCBE
        move.b       #$13, (a1)+                                   ; $01BCC4
        move.b       #$8, (a1)+                                    ; $01BCC8
        jsr          NextRandom.l                                  ; $01BCCC
        asr.w        #$8, d2                                       ; $01BCD2
        andi.w       #$1, d2                                       ; $01BCD4
        addq.w       #$2, d2                                       ; $01BCD8
        move.b       d2, (a1)+                                     ; $01BCDA
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01BCDC
        jmp          QueueLinkCommand.l                            ; $01BCE0

loc_01BCE6:
        rts                                                        ; $01BCE6
        ifne *-$1BCE8
        fail "ROM end moved"
        endif
