; $0185A4..$01864F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Set return9 and goal=SavedXY before melee. Target cell types2..5 halve octagonal distance; accept<$80 (original<$100 there). D0=$28A; direction=(SavedXY-targetXY)>>1. Local target doubles player motion; no LOS gate.
        ifne *-$185A4
        fail "ROM start moved"
        endif

FinishDogChargeAndTryHit:
; Set return9 and goal=SavedXY before melee. Target cell types2..5 halve octagonal distance; accept<$80 (original<$100 there). D0=$28A; direction=(SavedXY-targetXY)>>1. Local target doubles player motion; no LOS gate.
        move.b       #$9, ActorState(a0)                           ; $0185A4
        move.w       ActorSavedX(a0), ActorGoalX(a0)               ; $0185AA
        move.w       ActorSavedY(a0), ActorGoalY(a0)               ; $0185B0
        movea.l      ActorTarget(a0), a3                           ; $0185B6
        move.w       ActorX(a0), d0                                ; $0185BA
        move.w       ActorY(a0), d1                                ; $0185BE
        sub.w        ActorX(a3), d0                                ; $0185C2
        sub.w        ActorY(a3), d1                                ; $0185C6
        jsr          OctagonalDistance.l                           ; $0185CA
        move.l       a0, -(a7)                                     ; $0185D0
        movea.l      a3, a0                                        ; $0185D2
        bsr.w        GetVisibleMapBase                             ; $0185D4
        move.w       ActorX(a0), d1                                ; $0185D8
        asr.w        #$8, d1                                       ; $0185DC
        adda.w       d1, a1                                        ; $0185DE
        move.w       ActorY(a0), d1                                ; $0185E0
        clr.b        d1                                            ; $0185E4
        asr.w        #$3, d1                                       ; $0185E6
        adda.w       d1, a1                                        ; $0185E8
        movea.l      (a7)+, a0                                     ; $0185EA
        clr.w        d1                                            ; $0185EC
        move.b       (a1), d1                                      ; $0185EE
        lea.l        rCellTypeByIndex(a6), a1                      ; $0185F0
        move.b       (a1, d1.w), d1                                ; $0185F4
        cmpi.b       #$2, d1                                       ; $0185F8
        bcs.b        loc_018606                                    ; $0185FC
        cmpi.b       #$5, d1                                       ; $0185FE
        bhi.b        loc_018606                                    ; $018602
        asr.w        #$1, d0                                       ; $018604

loc_018606:
        cmpi.w       #$80, d0                                      ; $018606
        bcc.b        loc_01864E                                    ; $01860A
        move.w       ActorSavedX(a0), d3                           ; $01860C
        move.w       ActorSavedY(a0), d4                           ; $018610
        sub.w        ActorX(a3), d3                                ; $018614
        sub.w        ActorY(a3), d4                                ; $018618
        asr.w        #$1, d3                                       ; $01861C
        asr.w        #$1, d4                                       ; $01861E
        move.w       #$28a, d0                                     ; $018620
        move.l       a0, -(a7)                                     ; $018624
        movea.l      a3, a0                                        ; $018626
        movea.l      ActorHitCallback(a0), a1                      ; $018628
        move.l       a3, -(a7)                                     ; $01862C
        jsr          (a1)                                          ; $01862E
        movea.l      (a7)+, a3                                     ; $018630
        movea.l      (a7)+, a0                                     ; $018632
        cmpa.l       #ramPlayerActorProxy, a3                                  ; $018634
        bne.b        loc_018644                                    ; $01863A
        asl.w        rPlayerHitImpulseX(a6)                                    ; $01863C
        asl.w        rPlayerHitImpulseY(a6)                                    ; $018640

loc_018644:
        move.w       #$2a, d0                                      ; $018644
        jmp          RouteSoundEventByActorFloor.l                         ; $018648

loc_01864E:
        rts                                                        ; $01864E
        ifne *-$18650
        fail "ROM end moved"
        endif
