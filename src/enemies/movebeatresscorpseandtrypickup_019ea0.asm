; $019EA0..$019FAD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Corpse motion/pickup: distance<$60, local item0C and amount2/3 with BULIGUN message; remote command13 item08. C8/C9 bypass pickup.
        ifne *-$19EA0
        fail "ROM start moved"
        endif

MoveBeatressCorpseAndTryPickup:
; Corpse motion/pickup: distance<$60, local item0C and amount2/3 with BULIGUN message; remote command13 item08. C8/C9 bypass pickup.
        move.w       ActorMotionX(a0), d0                          ; $019EA0
        bmi.b        loc_019EAA                                    ; $019EA4
        asr.w        #$1, d0                                       ; $019EA6
        bra.b        loc_019EB0                                    ; $019EA8

loc_019EAA:
        neg.w        d0                                            ; $019EAA
        asr.w        #$1, d0                                       ; $019EAC
        neg.w        d0                                            ; $019EAE

loc_019EB0:
        move.w       d0, ActorMotionX(a0)                          ; $019EB0
        move.w       ActorMotionY(a0), d1                          ; $019EB4
        bmi.b        loc_019EBE                                    ; $019EB8
        asr.w        #$1, d1                                       ; $019EBA
        bra.b        loc_019EC4                                    ; $019EBC

loc_019EBE:
        neg.w        d1                                            ; $019EBE
        asr.w        #$1, d1                                       ; $019EC0
        neg.w        d1                                            ; $019EC2

loc_019EC4:
        move.w       d1, ActorMotionY(a0)                          ; $019EC4
        move.w       d0, d2                                        ; $019EC8
        or.w         d1, d2                                        ; $019ECA
        beq.b        loc_019EDA                                    ; $019ECC
        move.w       d0, ActorMotionX(a0)                          ; $019ECE
        move.w       d1, ActorMotionY(a0)                          ; $019ED2
        bsr.w        MoveActorWithWallMargin32                     ; $019ED6

loc_019EDA:
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $019EDA
        beq.b        loc_019EEC                                    ; $019EE0
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $019EE2
        beq.b        loc_019EEC                                    ; $019EE8
        bra.b        loc_019EF0                                    ; $019EEA

loc_019EEC:
        bra.w        SteerEnemyMotionAtNearbyWall                         ; $019EEC

loc_019EF0:
        movea.l      ActorTarget(a0), a3                           ; $019EF0
        move.w       ActorX(a0), d0                                ; $019EF4
        sub.w        ActorX(a3), d0                                ; $019EF8
        move.w       ActorY(a0), d1                                ; $019EFC
        sub.w        ActorY(a3), d1                                ; $019F00
        move.w       d0, d3                                        ; $019F04
        move.w       d1, d4                                        ; $019F06
        jsr          OctagonalDistance.l                           ; $019F08
        cmpi.w       #$60, d0                                      ; $019F0E
        bcs.b        loc_019F18                                    ; $019F12
        bra.w        SteerEnemyMotionAtNearbyWall                         ; $019F14

loc_019F18:
        tst.b        ActorMarkerTracked(a0)                        ; $019F18
        beq.b        loc_019F28                                    ; $019F1C
        move.w       #$1, rWallOpeningPermit(a6)                   ; $019F1E
        clr.b        ActorMarkerTracked(a0)                        ; $019F24

loc_019F28:
        cmpi.b       #$3, ActorState(a0)                           ; $019F28
        bne.b        loc_019FAC                                    ; $019F2E
        cmpa.l       #ramPlayerActorProxy, a3                                  ; $019F30
        bne.b        loc_019F80                                    ; $019F36
        jsr          NextRandom.l                                  ; $019F38
        asr.w        #$8, d2                                       ; $019F3E
        andi.w       #$1, d2                                       ; $019F40
        addq.w       #$2, d2                                       ; $019F44
        lsl.w        #$8, d2                                       ; $019F46
        move.w       d2, rItemGrantAmountOverride(a6)                                ; $019F48
        move.w       #$c, d0                                       ; $019F4C
        move.l       a0, -(a7)                                     ; $019F50
        jsr          GrantInventoryItem.l                            ; $019F52
        movea.l      (a7)+, a0                                     ; $019F58
        clr.w        rItemGrantAmountOverride(a6)                                    ; $019F5A
        cmpi.w       #$ffff, d7                                    ; $019F5E
        beq.b        loc_019FAC                                    ; $019F62
        move.b       #$4, ActorState(a0)                           ; $019F64
        move.w       #$60, d0                                      ; $019F6A
        jsr          RouteSoundEventByActorFloor.l                         ; $019F6E
        movea.l      #StatusMessageBuligunCollected, a0            ; $019F74
        jmp          QueueStatusMessage.l                          ; $019F7A

loc_019F80:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $019F80
        move.b       #$4, ActorState(a0)                           ; $019F84
        move.b       #$13, (a1)+                                   ; $019F8A
        move.b       #$8, (a1)+                                    ; $019F8E
        jsr          NextRandom.l                                  ; $019F92
        asr.w        #$8, d2                                       ; $019F98
        andi.w       #$1, d2                                       ; $019F9A
        addq.w       #$2, d2                                       ; $019F9E
        move.b       d2, (a1)+                                     ; $019FA0
        lea.l        rSharedScratchBuffer(a6), a0                                ; $019FA2
        jmp          QueueLinkCommand.l                            ; $019FA6

loc_019FAC:
        rts                                                        ; $019FAC
        ifne *-$19FAE
        fail "ROM end moved"
        endif
