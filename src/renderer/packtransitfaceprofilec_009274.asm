; $009274..$00928F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 90D4] профиль лифта/площадок ct 0x12-0x14/0x30-0x34/0x3C-0x5B (семейство)
        ifne *-$9274
        fail "ROM start moved"
        endif

PackTransitFaceProfileC:
        tst.w        d0                                            ; $009274
        ble.b        loc_00928C                                    ; $009276
        move.b       d0, d3                                        ; $009278
        lsl.w        #$8, d3                                       ; $00927A
        move.b       d1, d3                                        ; $00927C
        swap         d3                                            ; $00927E
        move.b       d0, d3                                        ; $009280
        lsl.w        #$8, d3                                       ; $009282
        move.b       d1, d3                                        ; $009284
        addq.b       #$1, d3                                       ; $009286
        bsr.w        EnemiesRoutine_0096CC                         ; $009288

loc_00928C:
        clr.w        d3                                            ; $00928C
        rts                                                        ; $00928E
        ifne *-$9290
        fail "ROM end moved"
        endif
