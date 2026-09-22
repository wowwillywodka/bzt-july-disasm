; $0022EE..$0023F9 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$22EE
        fail "ROM start moved"
        endif

RetainedPanoramaSpriteRenderer:
        tst.b        -$6f56(a6)                                    ; $0022EE
        beq.b        loc_002302                                    ; $0022F2
        bsr.w        AdvanceRetainedPanoramaEffect                 ; $0022F4
        tst.b        -$6f51(a6)                                    ; $0022F8
        beq.b        loc_002302                                    ; $0022FC
        bsr.w        UiRoutine_0025C4                              ; $0022FE

loc_002302:
        tst.b        -$6f4d(a6)                                    ; $002302
        beq.b        loc_00230C                                    ; $002306
        bsr.w        TrackRetainedPanoramaEffectPosition           ; $002308

loc_00230C:
        move.w       -$71ee(a6), d2                                ; $00230C
        neg.w        d2                                            ; $002310
        lsl.w        #$1, d2                                       ; $002312
        addi.w       #$210, d2                                     ; $002314
        move.w       rPlayerY(a6), d0                              ; $002318
        asr.w        #$6, d0                                       ; $00231C
        sub.w        d0, d2                                        ; $00231E
        andi.w       #$3ff, d2                                     ; $002320
        beq.b        loc_00232C                                    ; $002324
        cmpi.w       #$1a0, d2                                     ; $002326
        bcs.b        loc_00232E                                    ; $00232A

loc_00232C:
        rts                                                        ; $00232C

loc_00232E:
        clr.w        -$6f50(a6)                                    ; $00232E
        tst.b        -$6f56(a6)                                    ; $002332
        beq.b        loc_00236E                                    ; $002336
        move.w       #$c9, (a2)+                                   ; $002338
        lea.l        RetainedPanoramaAnimationTiles(pc), a0        ; $00233C
        clr.w        d4                                            ; $002340
        move.b       -$6f52(a6), d4                                ; $002342
        bclr.l       #$0, d4                                       ; $002346
        move.w       -$7fbe(a6), d5                                ; $00234A
        ori.w        #$0, d5                                       ; $00234E
        move.w       d5, (a2)+                                     ; $002352
        addq.w       #$1, -$7fbe(a6)                               ; $002354
        move.w       (a0, d4.w), (a2)+                             ; $002358
        clr.w        d4                                            ; $00235C
        move.b       -$6f55(a6), d4                                ; $00235E
        addi.w       #$10, d4                                      ; $002362
        add.w        d2, d4                                        ; $002366
        move.w       d4, (a2)+                                     ; $002368
        move.w       d4, -$6f50(a6)                                ; $00236A

loc_00236E:
        move.w       #$13, d3                                      ; $00236E
        cmpi.w       #$a0, d2                                      ; $002372
        bcc.b        loc_002386                                    ; $002376
        move.w       d2, d3                                        ; $002378
        asr.w        #$3, d3                                       ; $00237A
        andi.w       #$7, d2                                       ; $00237C
        addi.w       #$98, d2                                      ; $002380
        bra.b        loc_002394                                    ; $002384

loc_002386:
        cmpi.w       #$100, d2                                     ; $002386
        bls.b        loc_002394                                    ; $00238A
        move.w       #$1a0, d3                                     ; $00238C
        sub.w        d2, d3                                        ; $002390
        asr.w        #$3, d3                                       ; $002392

loc_002394:
        lea.l        RetainedPanoramaSpriteRows(pc), a0            ; $002394
        lsl.w        #$2, d3                                       ; $002398
        adda.w       d3, a0                                        ; $00239A
        lsl.w        #$1, d3                                       ; $00239C
        adda.w       d3, a0                                        ; $00239E
        move.w       -$7fbe(a6), d1                                ; $0023A0
        move.w       rCurrentFloor(a6), d5                         ; $0023A4
        lsl.w        #$3, d5                                       ; $0023A8
        move.w       -$6e4c(a6), d0                                ; $0023AA
        asr.w        #$4, d0                                       ; $0023AE
        add.w        d0, d5                                        ; $0023B0
        neg.w        d5                                            ; $0023B2
        addi.w       #$cf, d5                                      ; $0023B4
        lea.l        RetainedPanoramaTileSequence(pc), a1          ; $0023B8
        cmpi.w       #$98, d5                                      ; $0023BC
        bgt.b        loc_0023CE                                    ; $0023C0

loc_0023C2:
        addi.w       #$10, d5                                      ; $0023C2
        addq.w       #$2, a1                                       ; $0023C6
        cmpi.w       #$98, d5                                      ; $0023C8
        ble.b        loc_0023C2                                    ; $0023CC

loc_0023CE:
        move.w       (a1)+, d6                                     ; $0023CE
        movea.l      a0, a3                                        ; $0023D0
        move.w       d2, d7                                        ; $0023D2

loc_0023D4:
        move.w       (a3)+, d0                                     ; $0023D4
        bmi.b        loc_0023EA                                    ; $0023D6
        move.w       d5, (a2)+                                     ; $0023D8
        or.w         d1, d0                                        ; $0023DA
        addq.w       #$1, d1                                       ; $0023DC
        move.w       d0, (a2)+                                     ; $0023DE
        move.w       d6, (a2)+                                     ; $0023E0
        move.w       d7, (a2)+                                     ; $0023E2
        addi.w       #$20, d7                                      ; $0023E4
        bra.b        loc_0023D4                                    ; $0023E8

loc_0023EA:
        addi.w       #$10, d5                                      ; $0023EA
        cmpi.w       #$f8, d5                                      ; $0023EE
        blt.b        loc_0023CE                                    ; $0023F2
        move.w       d1, -$7fbe(a6)                                ; $0023F4
        rts                                                        ; $0023F8
        ifne *-$23FA
        fail "ROM end moved"
        endif
