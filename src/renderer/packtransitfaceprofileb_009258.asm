; $009258..$009273 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 90B8] упаковщик пары значений профиля (d0,d1 → swap d3) для граней ct 0x3C/0x3E (семейство 90B8/90D4/90F0)
        ifne *-$9258
        fail "ROM start moved"
        endif

PackTransitFaceProfileB:
        tst.w        d1                                            ; $009258
        ble.b        loc_009270                                    ; $00925A
        move.b       d0, d3                                        ; $00925C
        addq.b       #$1, d3                                       ; $00925E
        lsl.w        #$8, d3                                       ; $009260
        move.b       d1, d3                                        ; $009262
        swap         d3                                            ; $009264
        move.b       d0, d3                                        ; $009266
        lsl.w        #$8, d3                                       ; $009268
        move.b       d1, d3                                        ; $00926A
        bsr.w        EnemiesRoutine_0096CC                         ; $00926C

loc_009270:
        clr.w        d3                                            ; $009270
        rts                                                        ; $009272
        ifne *-$9274
        fail "ROM end moved"
        endif
