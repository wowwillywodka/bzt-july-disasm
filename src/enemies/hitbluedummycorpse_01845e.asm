; $01845E..$0184A5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Corpse impulse and counter++; no HP/state change. Increasing Blue Dummy CC counter above1 suppresses CC drawing but not its state-based completion.
        ifne *-$1845E
        fail "ROM start moved"
        endif

HitBlueDummyCorpse:
; Corpse impulse and counter++; no HP/state change. Increasing Blue Dummy CC counter above1 suppresses CC drawing but not its state-based completion.
        clr.w        ActorMotionX(a0)                              ; $01845E
        clr.w        ActorMotionY(a0)                              ; $018462
        neg.w        d3                                            ; $018466
        neg.w        d4                                            ; $018468
        move.w       d0, -(a7)                                     ; $01846A
        move.w       d3, d0                                        ; $01846C
        move.w       d4, d1                                        ; $01846E
        jsr          OctagonalDistance.l                           ; $018470
        ext.l        d3                                            ; $018476
        ext.l        d4                                            ; $018478
        lsl.l        #$8, d3                                       ; $01847A
        lsl.l        #$8, d4                                       ; $01847C
        addq.w       #$1, d0                                       ; $01847E
        beq.b        loc_018486                                    ; $018480
        divs.w       d0, d3                                        ; $018482
        divs.w       d0, d4                                        ; $018484

loc_018486:
        move.w       #$400, d0                                     ; $018486
        sub.w        (a7)+, d0                                     ; $01848A
        bmi.b        loc_0184A4                                    ; $01848C
        asr.w        #$4, d0                                       ; $01848E
        muls.w       d0, d3                                        ; $018490
        muls.w       d0, d4                                        ; $018492
        asr.l        #$8, d3                                       ; $018494
        asr.l        #$8, d4                                       ; $018496
        move.w       d3, ActorMotionX(a0)                          ; $018498
        move.w       d4, ActorMotionY(a0)                          ; $01849C
        addq.b       #$1, ActorStateCounter(a0)                    ; $0184A0

loc_0184A4:
        rts                                                        ; $0184A4
        ifne *-$184A6
        fail "ROM end moved"
        endif
