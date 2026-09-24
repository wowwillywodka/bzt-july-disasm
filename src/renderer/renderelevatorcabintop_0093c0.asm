; $0093C0..$0093FF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [внутри старой 0x9290] [⇐June 90F0] профиль лифта/площадок ct 0x12-0x14/0x30-0x34/0x3C-0x5B (семейство)
        ifne *-$93C0
        fail "ROM start moved"
        endif

RenderElevatorCabinTop:
        tst.w        d1                                            ; $0093C0
        ble.b        loc_0093D8                                    ; $0093C2
        move.b       d0, d3                                        ; $0093C4
        addq.b       #$1, d3                                       ; $0093C6
        lsl.w        #$8, d3                                       ; $0093C8
        move.b       d1, d3                                        ; $0093CA
        swap         d3                                            ; $0093CC
        move.b       d0, d3                                        ; $0093CE
        lsl.w        #$8, d3                                       ; $0093D0
        move.b       d1, d3                                        ; $0093D2
        bsr.w        QueueUniqueWallMarker                        ; $0093D4

loc_0093D8:
        clr.w        d3                                            ; $0093D8
        rts                                                        ; $0093DA

loc_0093DC:
        tst.w        d1                                            ; $0093DC
        ble.b        loc_0093F4                                    ; $0093DE
        move.b       d0, d3                                        ; $0093E0
        addq.b       #$1, d3                                       ; $0093E2
        lsl.w        #$8, d3                                       ; $0093E4
        move.b       d1, d3                                        ; $0093E6
        swap         d3                                            ; $0093E8
        move.b       d0, d3                                        ; $0093EA
        lsl.w        #$8, d3                                       ; $0093EC
        move.b       d1, d3                                        ; $0093EE
        bsr.w        QueueBackgroundFilledWallMarker                         ; $0093F0

loc_0093F4:
        clr.w        d3                                            ; $0093F4
        rts                                                        ; $0093F6

loc_0093F8:
        tst.w        d1                                            ; $0093F8
        bpl.b        loc_009414                                    ; $0093FA
        move.b       d0, d3                                        ; $0093FC
        lsl.w        #$8, d3                                       ; $0093FE
        ifne *-$9400
        fail "ROM end moved"
        endif
