; $018BA2..$018C53 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Normal contact<$60 frees marker, then state3/local-player path computes random quantity and RETURNS before item grant/state change. Remote pickup tail remains active.
        ifne *-$18BA2
        fail "ROM start moved"
        endif

MoveDogCorpseAndCheckContact:
; Normal contact<$60 frees marker, then state3/local-player path computes random quantity and RETURNS before item grant/state change. Remote pickup tail remains active.
        move.w       ActorMotionX(a0), d0                          ; $018BA2
        bmi.b        loc_018BAC                                    ; $018BA6
        asr.w        #$1, d0                                       ; $018BA8
        bra.b        loc_018BB2                                    ; $018BAA

loc_018BAC:
        neg.w        d0                                            ; $018BAC
        asr.w        #$1, d0                                       ; $018BAE
        neg.w        d0                                            ; $018BB0

loc_018BB2:
        move.w       d0, ActorMotionX(a0)                          ; $018BB2
        move.w       ActorMotionY(a0), d1                          ; $018BB6
        bmi.b        loc_018BC0                                    ; $018BBA
        asr.w        #$1, d1                                       ; $018BBC
        bra.b        loc_018BC6                                    ; $018BBE

loc_018BC0:
        neg.w        d1                                            ; $018BC0
        asr.w        #$1, d1                                       ; $018BC2
        neg.w        d1                                            ; $018BC4

loc_018BC6:
        move.w       d1, ActorMotionY(a0)                          ; $018BC6
        move.w       d0, d2                                        ; $018BCA
        or.w         d1, d2                                        ; $018BCC
        beq.b        loc_018BDC                                    ; $018BCE
        move.w       d0, ActorMotionX(a0)                          ; $018BD0
        move.w       d1, ActorMotionY(a0)                          ; $018BD4
        bsr.w        MoveActorWithWallMargin32                     ; $018BD8

loc_018BDC:
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $018BDC
        beq.b        loc_018BF6                                    ; $018BE2
        cmpi.b       #$ce, ActorDeathMode(a0)                      ; $018BE4
        beq.b        loc_018BF6                                    ; $018BEA
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $018BEC
        beq.b        loc_018BF6                                    ; $018BF2
        bra.b        loc_018BFA                                    ; $018BF4

loc_018BF6:
        bra.w        EnemiesRoutine_01E25A                         ; $018BF6

loc_018BFA:
        movea.l      ActorTarget(a0), a3                           ; $018BFA
        move.w       ActorX(a0), d0                                ; $018BFE
        sub.w        ActorX(a3), d0                                ; $018C02
        move.w       ActorY(a0), d1                                ; $018C06
        sub.w        ActorY(a3), d1                                ; $018C0A
        move.w       d0, d3                                        ; $018C0E
        move.w       d1, d4                                        ; $018C10
        jsr          OctagonalDistance.l                           ; $018C12
        cmpi.w       #$60, d0                                      ; $018C18
        bcs.b        loc_018C22                                    ; $018C1C
        bra.w        EnemiesRoutine_01E25A                         ; $018C1E

loc_018C22:
        tst.b        ActorMarkerTracked(a0)                        ; $018C22
        beq.b        loc_018C32                                    ; $018C26
        move.w       #$1, rWallOpeningPermit(a6)                   ; $018C28
        clr.b        ActorMarkerTracked(a0)                        ; $018C2E

loc_018C32:
        cmpi.b       #$3, ActorState(a0)                           ; $018C32
        bne.b        loc_018C9C                                    ; $018C38
        cmpa.l       #$ff11e2, a3                                  ; $018C3A
        bne.b        SendDogCorpsePickup                           ; $018C40
        jsr          NextRandom.l                                  ; $018C42
        asr.w        #$8, d2                                       ; $018C48
        andi.w       #$1, d2                                       ; $018C4A
        addq.w       #$2, d2                                       ; $018C4E
        lsl.w        #$8, d2                                       ; $018C50
        rts                                                        ; $018C52
        ifne *-$18C54
        fail "ROM end moved"
        endif
