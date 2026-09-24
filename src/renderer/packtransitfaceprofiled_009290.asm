; $009290..$00930B | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 90F0] профиль лифта/площадок ct 0x12-0x14/0x30-0x34/0x3C-0x5B (семейство)
        ifne *-$9290
        fail "ROM start moved"
        endif

PackTransitFaceProfileD:
        tst.w        d0                                            ; $009290
        bpl.b        loc_0092AC                                    ; $009292
        move.b       d0, d3                                        ; $009294
        addq.b       #$1, d3                                       ; $009296
        lsl.w        #$8, d3                                       ; $009298
        move.b       d1, d3                                        ; $00929A
        addq.b       #$1, d3                                       ; $00929C
        swap         d3                                            ; $00929E
        move.b       d0, d3                                        ; $0092A0
        addq.b       #$1, d3                                       ; $0092A2
        lsl.w        #$8, d3                                       ; $0092A4
        move.b       d1, d3                                        ; $0092A6
        bsr.w        QueueBackgroundFilledWallMarker                         ; $0092A8

loc_0092AC:
        clr.w        d3                                            ; $0092AC
        rts                                                        ; $0092AE

loc_0092B0:
        tst.w        d1                                            ; $0092B0
        ble.b        loc_0092C8                                    ; $0092B2
        move.b       d0, d3                                        ; $0092B4
        addq.b       #$1, d3                                       ; $0092B6
        lsl.w        #$8, d3                                       ; $0092B8
        move.b       d1, d3                                        ; $0092BA
        swap         d3                                            ; $0092BC
        move.b       d0, d3                                        ; $0092BE
        lsl.w        #$8, d3                                       ; $0092C0
        move.b       d1, d3                                        ; $0092C2
        bsr.w        QueueUniqueWallMarker                        ; $0092C4

loc_0092C8:
        clr.w        d3                                            ; $0092C8
        rts                                                        ; $0092CA

loc_0092CC:
        tst.w        d1                                            ; $0092CC
        bpl.b        loc_0092E8                                    ; $0092CE
        move.b       d0, d3                                        ; $0092D0
        lsl.w        #$8, d3                                       ; $0092D2
        move.b       d1, d3                                        ; $0092D4
        addq.b       #$1, d3                                       ; $0092D6
        swap         d3                                            ; $0092D8
        move.b       d0, d3                                        ; $0092DA
        addq.b       #$1, d3                                       ; $0092DC
        lsl.w        #$8, d3                                       ; $0092DE
        move.b       d1, d3                                        ; $0092E0
        addq.b       #$1, d3                                       ; $0092E2
        bsr.w        QueueUniqueWallMarker                        ; $0092E4

loc_0092E8:
        clr.w        d3                                            ; $0092E8
        rts                                                        ; $0092EA

loc_0092EC:
        tst.w        d0                                            ; $0092EC
        bpl.b        loc_009308                                    ; $0092EE
        move.b       d0, d3                                        ; $0092F0
        addq.b       #$1, d3                                       ; $0092F2
        lsl.w        #$8, d3                                       ; $0092F4
        move.b       d1, d3                                        ; $0092F6
        addq.b       #$1, d3                                       ; $0092F8
        swap         d3                                            ; $0092FA
        move.b       d0, d3                                        ; $0092FC
        addq.b       #$1, d3                                       ; $0092FE
        lsl.w        #$8, d3                                       ; $009300
        move.b       d1, d3                                        ; $009302
        bsr.w        QueueUniqueWallMarker                        ; $009304

loc_009308:
        clr.w        d3                                            ; $009308
        rts                                                        ; $00930A
        ifne *-$930C
        fail "ROM end moved"
        endif
