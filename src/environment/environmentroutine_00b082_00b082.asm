; $00B082..$00B3FF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; спец-хендлер ct 0x8E: клетка → -0x42A2 + D122, реестр видимых -0x7008 (хвост -0x7118), подавление -0x715A (семейство обломков; варианты B1D6=ct 0x8D, B280=ct 0x8F, реестр -0x7030/-0x711C)
        ifne *-$B082
        fail "ROM start moved"
        endif

EnvironmentRoutine_00B082:
        move.l       a0, -$42a2(a6)                                ; $00B082
        bsr.w        RendererRoutine_00D122                        ; $00B086
        st.b         -$715a(a6)                                    ; $00B08A
        lea.l        -$7008(a6), a3                                ; $00B08E
        cmpa.l       -$7118(a6), a3                                ; $00B092
        beq.b        loc_00B0A4                                    ; $00B096

loc_00B098:
        cmpa.l       (a3)+, a0                                     ; $00B098
        beq.w        loc_00B0F8                                    ; $00B09A
        cmpa.l       -$7118(a6), a3                                ; $00B09E
        bne.b        loc_00B098                                    ; $00B0A2

loc_00B0A4:
        move.l       a0, (a3)+                                     ; $00B0A4
        move.l       a3, -$7118(a6)                                ; $00B0A6
        clr.l        -$6e46(a6)                                    ; $00B0AA
        clr.l        -$6e42(a6)                                    ; $00B0AE
        clr.w        -$6e48(a6)                                    ; $00B0B2
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00B0B6
        tst.w        d0                                            ; $00B0BA
        bmi.b        loc_00B0CC                                    ; $00B0BC
        bne.w        loc_00B0FC                                    ; $00B0BE
        cmpi.w       #$80, -$71e4(a6)                              ; $00B0C2
        bcs.w        loc_00B0FC                                    ; $00B0C8

loc_00B0CC:
        add.w        rPlayerCellX(a6), d0                          ; $00B0CC
        lsl.w        #$8, d0                                       ; $00B0D0
        add.w        rPlayerCellY(a6), d1                          ; $00B0D2
        lsl.w        #$8, d1                                       ; $00B0D6
        addi.w       #$80, d0                                      ; $00B0D8
        bsr.w        RendererRoutine_00D232                        ; $00B0DC
        addi.w       #$100, d1                                     ; $00B0E0
        bsr.w        RendererRoutine_00D1D6                        ; $00B0E4
        move.l       #$ff8f2a, rCurrentWallTilePair(a6)            ; $00B0E8
        bsr.w        ProjectAndDrawWallFace                        ; $00B0F0
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B0F4

loc_00B0F8:
        clr.w        d3                                            ; $00B0F8
        rts                                                        ; $00B0FA

loc_00B0FC:
        add.w        rPlayerCellX(a6), d0                          ; $00B0FC
        lsl.w        #$8, d0                                       ; $00B100
        add.w        rPlayerCellY(a6), d1                          ; $00B102
        lsl.w        #$8, d1                                       ; $00B106
        addi.w       #$80, d0                                      ; $00B108
        bsr.w        RendererRoutine_00D1D6                        ; $00B10C
        addi.w       #$100, d1                                     ; $00B110
        bsr.w        RendererRoutine_00D232                        ; $00B114
        move.l       #$ff8eba, rCurrentWallTilePair(a6)            ; $00B118
        bsr.w        ProjectAndDrawWallFace                        ; $00B120
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B124
        clr.w        d3                                            ; $00B128
        rts                                                        ; $00B12A

loc_00B12C:
        move.l       a0, -$42a2(a6)                                ; $00B12C
        bsr.w        RendererRoutine_00D122                        ; $00B130
        st.b         -$715a(a6)                                    ; $00B134
        lea.l        -$7008(a6), a3                                ; $00B138
        cmpa.l       -$7118(a6), a3                                ; $00B13C
        beq.b        loc_00B14E                                    ; $00B140

loc_00B142:
        cmpa.l       (a3)+, a0                                     ; $00B142
        beq.w        loc_00B1A2                                    ; $00B144
        cmpa.l       -$7118(a6), a3                                ; $00B148
        bne.b        loc_00B142                                    ; $00B14C

loc_00B14E:
        move.l       a0, (a3)+                                     ; $00B14E
        move.l       a3, -$7118(a6)                                ; $00B150
        clr.l        -$6e46(a6)                                    ; $00B154
        clr.l        -$6e42(a6)                                    ; $00B158
        clr.w        -$6e48(a6)                                    ; $00B15C
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00B160
        tst.w        d0                                            ; $00B164
        bmi.b        loc_00B176                                    ; $00B166
        bne.w        loc_00B1A6                                    ; $00B168
        cmpi.w       #$80, -$71e4(a6)                              ; $00B16C
        bcs.w        loc_00B1A6                                    ; $00B172

loc_00B176:
        add.w        rPlayerCellX(a6), d0                          ; $00B176
        lsl.w        #$8, d0                                       ; $00B17A
        add.w        rPlayerCellY(a6), d1                          ; $00B17C
        lsl.w        #$8, d1                                       ; $00B180
        addi.w       #$80, d0                                      ; $00B182
        bsr.w        RendererRoutine_00D232                        ; $00B186
        addi.w       #$100, d1                                     ; $00B18A
        bsr.w        RendererRoutine_00D1D6                        ; $00B18E
        move.l       #$ff8eba, rCurrentWallTilePair(a6)            ; $00B192
        bsr.w        ProjectAndDrawWallFace                        ; $00B19A
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B19E

loc_00B1A2:
        clr.w        d3                                            ; $00B1A2
        rts                                                        ; $00B1A4

loc_00B1A6:
        add.w        rPlayerCellX(a6), d0                          ; $00B1A6
        lsl.w        #$8, d0                                       ; $00B1AA
        add.w        rPlayerCellY(a6), d1                          ; $00B1AC
        lsl.w        #$8, d1                                       ; $00B1B0
        addi.w       #$80, d0                                      ; $00B1B2
        bsr.w        RendererRoutine_00D1D6                        ; $00B1B6
        addi.w       #$100, d1                                     ; $00B1BA
        bsr.w        RendererRoutine_00D232                        ; $00B1BE
        move.l       #$ff8f2a, rCurrentWallTilePair(a6)            ; $00B1C2
        bsr.w        ProjectAndDrawWallFace                        ; $00B1CA
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B1CE
        clr.w        d3                                            ; $00B1D2
        rts                                                        ; $00B1D4

loc_00B1D6:
        move.l       a0, -$42a2(a6)                                ; $00B1D6
        bsr.w        RendererRoutine_00D122                        ; $00B1DA
        st.b         -$715a(a6)                                    ; $00B1DE
        lea.l        -$7030(a6), a3                                ; $00B1E2
        cmpa.l       -$711c(a6), a3                                ; $00B1E6
        beq.b        loc_00B1F8                                    ; $00B1EA

loc_00B1EC:
        cmpa.l       (a3)+, a0                                     ; $00B1EC
        beq.w        loc_00B24C                                    ; $00B1EE
        cmpa.l       -$711c(a6), a3                                ; $00B1F2
        bne.b        loc_00B1EC                                    ; $00B1F6

loc_00B1F8:
        move.l       a0, (a3)+                                     ; $00B1F8
        move.l       a3, -$711c(a6)                                ; $00B1FA
        clr.l        -$6e46(a6)                                    ; $00B1FE
        clr.l        -$6e42(a6)                                    ; $00B202
        clr.w        -$6e48(a6)                                    ; $00B206
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00B20A
        tst.w        d1                                            ; $00B20E
        bmi.b        loc_00B220                                    ; $00B210
        bne.w        loc_00B250                                    ; $00B212
        cmpi.w       #$80, -$71e2(a6)                              ; $00B216
        bcs.w        loc_00B250                                    ; $00B21C

loc_00B220:
        add.w        rPlayerCellX(a6), d0                          ; $00B220
        lsl.w        #$8, d0                                       ; $00B224
        add.w        rPlayerCellY(a6), d1                          ; $00B226
        lsl.w        #$8, d1                                       ; $00B22A
        addi.w       #$80, d1                                      ; $00B22C
        bsr.w        RendererRoutine_00D1D6                        ; $00B230
        addi.w       #$100, d0                                     ; $00B234
        bsr.w        RendererRoutine_00D232                        ; $00B238
        move.l       #$ff8f2a, rCurrentWallTilePair(a6)            ; $00B23C
        bsr.w        ProjectAndDrawWallFace                        ; $00B244
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B248

loc_00B24C:
        clr.w        d3                                            ; $00B24C
        rts                                                        ; $00B24E

loc_00B250:
        add.w        rPlayerCellX(a6), d0                          ; $00B250
        lsl.w        #$8, d0                                       ; $00B254
        add.w        rPlayerCellY(a6), d1                          ; $00B256
        lsl.w        #$8, d1                                       ; $00B25A
        addi.w       #$80, d1                                      ; $00B25C
        bsr.w        RendererRoutine_00D232                        ; $00B260
        addi.w       #$100, d0                                     ; $00B264
        bsr.w        RendererRoutine_00D1D6                        ; $00B268
        move.l       #$ff8eba, rCurrentWallTilePair(a6)            ; $00B26C
        bsr.w        ProjectAndDrawWallFace                        ; $00B274
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B278
        clr.w        d3                                            ; $00B27C
        rts                                                        ; $00B27E

loc_00B280:
        move.l       a0, -$42a2(a6)                                ; $00B280
        bsr.w        RendererRoutine_00D122                        ; $00B284
        st.b         -$715a(a6)                                    ; $00B288
        lea.l        -$7030(a6), a3                                ; $00B28C
        cmpa.l       -$711c(a6), a3                                ; $00B290
        beq.b        loc_00B2A2                                    ; $00B294

loc_00B296:
        cmpa.l       (a3)+, a0                                     ; $00B296
        beq.w        loc_00B2F6                                    ; $00B298
        cmpa.l       -$711c(a6), a3                                ; $00B29C
        bne.b        loc_00B296                                    ; $00B2A0

loc_00B2A2:
        move.l       a0, (a3)+                                     ; $00B2A2
        move.l       a3, -$711c(a6)                                ; $00B2A4
        clr.l        -$6e46(a6)                                    ; $00B2A8
        clr.l        -$6e42(a6)                                    ; $00B2AC
        clr.w        -$6e48(a6)                                    ; $00B2B0
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00B2B4
        tst.w        d1                                            ; $00B2B8
        bmi.b        loc_00B2CA                                    ; $00B2BA
        bne.w        loc_00B2FA                                    ; $00B2BC
        cmpi.w       #$80, -$71e2(a6)                              ; $00B2C0
        bcs.w        loc_00B2FA                                    ; $00B2C6

loc_00B2CA:
        add.w        rPlayerCellX(a6), d0                          ; $00B2CA
        lsl.w        #$8, d0                                       ; $00B2CE
        add.w        rPlayerCellY(a6), d1                          ; $00B2D0
        lsl.w        #$8, d1                                       ; $00B2D4
        addi.w       #$80, d1                                      ; $00B2D6
        bsr.w        RendererRoutine_00D1D6                        ; $00B2DA
        addi.w       #$100, d0                                     ; $00B2DE
        bsr.w        RendererRoutine_00D232                        ; $00B2E2
        move.l       #$ff8eba, rCurrentWallTilePair(a6)            ; $00B2E6
        bsr.w        ProjectAndDrawWallFace                        ; $00B2EE
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B2F2

loc_00B2F6:
        clr.w        d3                                            ; $00B2F6
        rts                                                        ; $00B2F8

loc_00B2FA:
        add.w        rPlayerCellX(a6), d0                          ; $00B2FA
        lsl.w        #$8, d0                                       ; $00B2FE
        add.w        rPlayerCellY(a6), d1                          ; $00B300
        lsl.w        #$8, d1                                       ; $00B304
        addi.w       #$80, d1                                      ; $00B306
        bsr.w        RendererRoutine_00D232                        ; $00B30A
        addi.w       #$100, d0                                     ; $00B30E
        bsr.w        RendererRoutine_00D1D6                        ; $00B312
        move.l       #$ff8f2a, rCurrentWallTilePair(a6)            ; $00B316
        bsr.w        ProjectAndDrawWallFace                        ; $00B31E
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B322
        clr.w        d3                                            ; $00B326
        rts                                                        ; $00B328

loc_00B32A:
        lea.l        -$7008(a6), a3                                ; $00B32A
        cmpa.l       -$7118(a6), a3                                ; $00B32E
        beq.b        loc_00B340                                    ; $00B332

loc_00B334:
        cmpa.l       (a3)+, a0                                     ; $00B334
        beq.w        loc_00B3E4                                    ; $00B336
        cmpa.l       -$7118(a6), a3                                ; $00B33A
        bne.b        loc_00B334                                    ; $00B33E

loc_00B340:
        move.l       a0, (a3)+                                     ; $00B340
        move.l       a3, -$7118(a6)                                ; $00B342
        bsr.w        FindTransientWallOpeningAmount                ; $00B346
        cmpi.w       #$80, d3                                      ; $00B34A
        bne.b        loc_00B354                                    ; $00B34E
        clr.w        d3                                            ; $00B350
        rts                                                        ; $00B352

loc_00B354:
        clr.l        -$6e46(a6)                                    ; $00B354
        clr.l        -$6e42(a6)                                    ; $00B358
        clr.w        -$6e48(a6)                                    ; $00B35C
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00B360
        tst.w        d0                                            ; $00B364
        bmi.b        loc_00B376                                    ; $00B366
        bne.w        loc_00B3E8                                    ; $00B368
        cmpi.w       #$80, -$71e4(a6)                              ; $00B36C
        bcs.w        loc_00B3E8                                    ; $00B372

loc_00B376:
        add.w        rPlayerCellX(a6), d0                          ; $00B376
        lsl.w        #$8, d0                                       ; $00B37A
        add.w        rPlayerCellY(a6), d1                          ; $00B37C
        lsl.w        #$8, d1                                       ; $00B380
        sub.w        d3, d1                                        ; $00B382
        addi.w       #$80, d0                                      ; $00B384
        move.w       d3, -(a7)                                     ; $00B388
        bsr.w        RendererRoutine_00D232                        ; $00B38A
        addi.w       #$80, d1                                      ; $00B38E
        bsr.w        RendererRoutine_00D1D6                        ; $00B392
        movem.w      d0-d1, -(a7)                                  ; $00B396
        move.l       #$ff8f32, rCurrentWallTilePair(a6)            ; $00B39A
        bsr.w        ProjectWallFaceOnly                           ; $00B3A2
        asr.w        -$717a(a6)                                    ; $00B3A6
        asr.w        -$7178(a6)                                    ; $00B3AA
        bsr.w        DrawWallTextureSpan                           ; $00B3AE
        movem.w      (a7)+, d0-d1                                  ; $00B3B2
        move.w       (a7)+, d3                                     ; $00B3B6
        add.w        d3, d1                                        ; $00B3B8
        add.w        d3, d1                                        ; $00B3BA
        bsr.w        RendererRoutine_00D232                        ; $00B3BC
        addi.w       #$80, d1                                      ; $00B3C0
        bsr.w        RendererRoutine_00D1D6                        ; $00B3C4
        move.l       #$ff8f2a, rCurrentWallTilePair(a6)            ; $00B3C8
        bsr.w        ProjectWallFaceOnly                           ; $00B3D0
        asr.w        -$717a(a6)                                    ; $00B3D4
        asr.w        -$7178(a6)                                    ; $00B3D8
        bsr.w        DrawWallTextureSpan                           ; $00B3DC
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B3E0

loc_00B3E4:
        clr.w        d3                                            ; $00B3E4
        rts                                                        ; $00B3E6

loc_00B3E8:
        add.w        rPlayerCellX(a6), d0                          ; $00B3E8
        lsl.w        #$8, d0                                       ; $00B3EC
        add.w        rPlayerCellY(a6), d1                          ; $00B3EE
        lsl.w        #$8, d1                                       ; $00B3F2
        sub.w        d3, d1                                        ; $00B3F4
        addi.w       #$80, d0                                      ; $00B3F6
        move.w       d3, -(a7)                                     ; $00B3FA
        bsr.w        RendererRoutine_00D1D6                        ; $00B3FC
        ifne *-$B400
        fail "ROM end moved"
        endif
