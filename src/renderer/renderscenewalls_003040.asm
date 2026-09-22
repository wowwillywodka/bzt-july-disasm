; $003040..$0033A1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Растеризатор 3D-стен (raycaster): по флагу (-0x214a,A6) выбирает яркий/затенённый проход, берёт указатель карты (-0x4262,A6) со смещением от позиции/угла игрока (-0x438e/-0x438c/-0x4384,A6 и камеры -0x2262/-0x2260,A6), для каждой из 16 колонок читает nibble клетки, через jsr 0xec66 индексирует таблицу столбцов-текстур (A3) и стримит 32×32 column-major пиксели парами move.w (A1)/(A2)→(A4) в $C00000
        ifne *-$3040
        fail "ROM start moved"
        endif

RenderSceneWalls:
        tst.w        -$214a(a6)                                    ; $003040
        bpl.w        loc_003256                                    ; $003044
        move.l       #$68200001, VDP_CONTROL.l                     ; $003048
        lea.l        rPackedCellRenderState(a6), a0                ; $003052
        move.w       rCurrentFloorMapOffset(a6), d0                ; $003056
        lsr.w        #$1, d0                                       ; $00305A
        adda.w       d0, a0                                        ; $00305C
        move.w       rMapWindowOriginX(a6), d0                     ; $00305E
        add.w        -$2262(a6), d0                                ; $003062
        bpl.b        loc_00306A                                    ; $003066
        clr.w        d0                                            ; $003068

loc_00306A:
        lsr.w        #$1, d0                                       ; $00306A
        adda.w       d0, a0                                        ; $00306C
        move.w       rMapWindowOriginY(a6), d0                     ; $00306E
        add.w        -$2260(a6), d0                                ; $003072
        mulu.w       rCurrentFloorWidth(a6), d0                    ; $003076
        lsr.w        #$1, d0                                       ; $00307A
        adda.w       d0, a0                                        ; $00307C
        lea.l        rCellTypeByIndex(a6), a5                      ; $00307E
        lea.l        CellTileGraphicsPointers(pc), a3              ; $003082
        movea.l      #VDP_DATA, a4                                 ; $003086
        move.w       #$f, d7                                       ; $00308C
        move.w       rCurrentFloorHeight(a6), d0                   ; $003090
        cmpi.w       #$20, d0                                      ; $003094
        bge.b        loc_0030A0                                    ; $003098
        lsr.w        #$1, d0                                       ; $00309A
        subq.w       #$1, d0                                       ; $00309C
        move.w       d0, d7                                        ; $00309E

loc_0030A0:
        move.l       a0, -(a7)                                     ; $0030A0
        move.w       #$f, d6                                       ; $0030A2
        move.w       #$2, d4                                       ; $0030A6

loc_0030AA:
        clr.w        d0                                            ; $0030AA
        clr.w        d3                                            ; $0030AC
        move.b       (a0), d3                                      ; $0030AE
        cmp.w        rCurrentFloorWidth(a6), d4                    ; $0030B0
        ble.b        loc_0030B8                                    ; $0030B4
        clr.w        d3                                            ; $0030B6

loc_0030B8:
        lsr.b        #$4, d3                                       ; $0030B8
        jsr          GetCellCollisionClass.l                       ; $0030BA
        lsl.w        #$2, d3                                       ; $0030C0
        movea.l      (a3, d3.w), a1                                ; $0030C2
        move.b       (a0), d3                                      ; $0030C6
        cmp.w        rCurrentFloorWidth(a6), d4                    ; $0030C8
        ble.b        loc_0030D0                                    ; $0030CC
        clr.w        d3                                            ; $0030CE

loc_0030D0:
        andi.w       #$f, d3                                       ; $0030D0
        jsr          GetCellCollisionClass.l                       ; $0030D4
        lsl.w        #$2, d3                                       ; $0030DA
        movea.l      (a3, d3.w), a2                                ; $0030DC
        move.w       (a1), (a4)                                    ; $0030E0
        move.w       (a2), (a4)                                    ; $0030E2
        addq.w       #$4, a1                                       ; $0030E4
        addq.w       #$4, a2                                       ; $0030E6
        move.w       (a1), (a4)                                    ; $0030E8
        move.w       (a2), (a4)                                    ; $0030EA
        addq.w       #$4, a1                                       ; $0030EC
        addq.w       #$4, a2                                       ; $0030EE
        move.w       (a1), (a4)                                    ; $0030F0
        move.w       (a2), (a4)                                    ; $0030F2
        addq.w       #$4, a1                                       ; $0030F4
        addq.w       #$4, a2                                       ; $0030F6
        move.w       (a1), (a4)                                    ; $0030F8
        move.w       (a2), (a4)                                    ; $0030FA
        clr.w        d3                                            ; $0030FC
        move.w       rCurrentFloorWidth(a6), d3                    ; $0030FE
        lsr.w        #$1, d3                                       ; $003102
        move.b       (a0, d3.w), d3                                ; $003104
        cmp.w        rCurrentFloorWidth(a6), d4                    ; $003108
        ble.b        loc_003110                                    ; $00310C
        clr.w        d3                                            ; $00310E

loc_003110:
        andi.w       #$ff, d3                                      ; $003110
        lsr.b        #$4, d3                                       ; $003114
        jsr          GetCellCollisionClass.l                       ; $003116
        lsl.w        #$2, d3                                       ; $00311C
        movea.l      (a3, d3.w), a1                                ; $00311E
        move.w       rCurrentFloorWidth(a6), d3                    ; $003122
        lsr.w        #$1, d3                                       ; $003126
        move.b       (a0, d3.w), d3                                ; $003128
        cmp.w        rCurrentFloorWidth(a6), d4                    ; $00312C
        ble.b        loc_003134                                    ; $003130
        clr.w        d3                                            ; $003132

loc_003134:
        andi.w       #$f, d3                                       ; $003134
        jsr          GetCellCollisionClass.l                       ; $003138
        lsl.w        #$2, d3                                       ; $00313E
        movea.l      (a3, d3.w), a2                                ; $003140
        move.w       (a1), (a4)                                    ; $003144
        move.w       (a2), (a4)                                    ; $003146
        addq.w       #$4, a1                                       ; $003148
        addq.w       #$4, a2                                       ; $00314A
        move.w       (a1), (a4)                                    ; $00314C
        move.w       (a2), (a4)                                    ; $00314E
        addq.w       #$4, a1                                       ; $003150
        addq.w       #$4, a2                                       ; $003152
        move.w       (a1), (a4)                                    ; $003154
        move.w       (a2), (a4)                                    ; $003156
        addq.w       #$4, a1                                       ; $003158
        addq.w       #$4, a2                                       ; $00315A
        move.w       (a1), (a4)                                    ; $00315C
        move.w       (a2), (a4)                                    ; $00315E
        addq.w       #$1, a0                                       ; $003160
        addq.w       #$2, d4                                       ; $003162
        dbra         d6, loc_0030AA                                ; $003164
        movea.l      (a7)+, a0                                     ; $003168
        adda.w       rCurrentFloorWidth(a6), a0                    ; $00316A
        dbra         d7, loc_0030A0                                ; $00316E
        move.w       rCurrentFloorHeight(a6), d0                   ; $003172
        andi.w       #$1, d0                                       ; $003176
        beq.w        loc_003254                                    ; $00317A
        move.w       #$f, d6                                       ; $00317E
        move.w       #$2, d4                                       ; $003182

loc_003186:
        clr.w        d0                                            ; $003186
        clr.w        d3                                            ; $003188
        move.b       (a0), d3                                      ; $00318A
        cmp.w        rCurrentFloorWidth(a6), d4                    ; $00318C
        ble.b        loc_003194                                    ; $003190
        clr.w        d3                                            ; $003192

loc_003194:
        lsr.b        #$4, d3                                       ; $003194
        jsr          GetCellCollisionClass.l                       ; $003196
        lsl.w        #$2, d3                                       ; $00319C
        movea.l      (a3, d3.w), a1                                ; $00319E
        move.b       (a0), d3                                      ; $0031A2
        cmp.w        rCurrentFloorWidth(a6), d4                    ; $0031A4
        ble.b        loc_0031AC                                    ; $0031A8
        clr.w        d3                                            ; $0031AA

loc_0031AC:
        andi.w       #$f, d3                                       ; $0031AC
        jsr          GetCellCollisionClass.l                       ; $0031B0
        lsl.w        #$2, d3                                       ; $0031B6
        movea.l      (a3, d3.w), a2                                ; $0031B8
        move.w       (a1), (a4)                                    ; $0031BC
        move.w       (a2), (a4)                                    ; $0031BE
        addq.w       #$4, a1                                       ; $0031C0
        addq.w       #$4, a2                                       ; $0031C2
        move.w       (a1), (a4)                                    ; $0031C4
        move.w       (a2), (a4)                                    ; $0031C6
        addq.w       #$4, a1                                       ; $0031C8
        addq.w       #$4, a2                                       ; $0031CA
        move.w       (a1), (a4)                                    ; $0031CC
        move.w       (a2), (a4)                                    ; $0031CE
        addq.w       #$4, a1                                       ; $0031D0
        addq.w       #$4, a2                                       ; $0031D2
        move.w       (a1), (a4)                                    ; $0031D4
        move.w       (a2), (a4)                                    ; $0031D6
        clr.w        d3                                            ; $0031D8
        move.w       rCurrentFloorWidth(a6), d3                    ; $0031DA
        lsr.w        #$1, d3                                       ; $0031DE
        move.b       (a0, d3.w), d3                                ; $0031E0
        cmp.w        rCurrentFloorWidth(a6), d4                    ; $0031E4
        ble.b        loc_0031EC                                    ; $0031E8
        clr.w        d3                                            ; $0031EA

loc_0031EC:
        andi.w       #$ff, d3                                      ; $0031EC
        lsr.b        #$4, d3                                       ; $0031F0
        jsr          GetCellCollisionClass.l                       ; $0031F2
        lsl.w        #$2, d3                                       ; $0031F8
        movea.l      (a3, d3.w), a1                                ; $0031FA
        move.w       rCurrentFloorWidth(a6), d3                    ; $0031FE
        lsr.w        #$1, d3                                       ; $003202
        move.b       (a0, d3.w), d3                                ; $003204
        cmp.w        rCurrentFloorWidth(a6), d4                    ; $003208
        ble.b        loc_003210                                    ; $00320C
        clr.w        d3                                            ; $00320E

loc_003210:
        andi.w       #$f, d3                                       ; $003210
        jsr          GetCellCollisionClass.l                       ; $003214
        lsl.w        #$2, d3                                       ; $00321A
        movea.l      (a3, d3.w), a2                                ; $00321C
        move.w       #$0, (a4)                                     ; $003220
        move.w       #$0, (a4)                                     ; $003224
        addq.w       #$4, a1                                       ; $003228
        addq.w       #$4, a2                                       ; $00322A
        move.w       #$0, (a4)                                     ; $00322C
        move.w       #$0, (a4)                                     ; $003230
        addq.w       #$4, a1                                       ; $003234
        addq.w       #$4, a2                                       ; $003236
        move.w       #$0, (a4)                                     ; $003238
        move.w       #$0, (a4)                                     ; $00323C
        addq.w       #$4, a1                                       ; $003240
        addq.w       #$4, a2                                       ; $003242
        move.w       #$0, (a4)                                     ; $003244
        move.w       #$0, (a4)                                     ; $003248
        addq.w       #$1, a0                                       ; $00324C
        addq.w       #$2, d4                                       ; $00324E
        dbra         d6, loc_003186                                ; $003250

loc_003254:
        rts                                                        ; $003254

loc_003256:
        move.l       #$68200001, VDP_CONTROL.l                     ; $003256
        lea.l        rPackedCellRenderState(a6), a0                ; $003260
        move.w       rCurrentFloorMapOffset(a6), d0                ; $003264
        lsr.w        #$1, d0                                       ; $003268
        adda.w       d0, a0                                        ; $00326A
        move.w       rMapWindowOriginX(a6), d0                     ; $00326C
        add.w        -$2262(a6), d0                                ; $003270
        bpl.b        loc_003278                                    ; $003274
        clr.w        d0                                            ; $003276

loc_003278:
        lsr.w        #$1, d0                                       ; $003278
        adda.w       d0, a0                                        ; $00327A
        move.w       rMapWindowOriginY(a6), d0                     ; $00327C
        add.w        -$2260(a6), d0                                ; $003280
        mulu.w       rCurrentFloorWidth(a6), d0                    ; $003284
        lsr.w        #$1, d0                                       ; $003288
        adda.w       d0, a0                                        ; $00328A
        lea.l        rCellTypeByIndex(a6), a5                      ; $00328C
        lea.l        CellTileGraphicsPointers(pc), a3              ; $003290
        movea.l      #VDP_DATA, a4                                 ; $003294
        move.w       #$f, d7                                       ; $00329A
        move.w       rCurrentFloorHeight(a6), d0                   ; $00329E
        cmpi.w       #$20, d0                                      ; $0032A2
        bge.b        loc_0032AE                                    ; $0032A6
        lsr.w        #$1, d0                                       ; $0032A8
        subq.w       #$1, d0                                       ; $0032AA
        move.w       d0, d7                                        ; $0032AC

loc_0032AE:
        move.l       a0, -(a7)                                     ; $0032AE
        move.w       #$f, d6                                       ; $0032B0
        move.w       #$2, d4                                       ; $0032B4

loc_0032B8:
        clr.w        d0                                            ; $0032B8
        clr.w        d3                                            ; $0032BA
        move.b       (a0), d3                                      ; $0032BC
        cmp.w        rCurrentFloorWidth(a6), d4                    ; $0032BE
        ble.b        loc_0032C6                                    ; $0032C2
        clr.w        d3                                            ; $0032C4

loc_0032C6:
        lsr.b        #$4, d3                                       ; $0032C6
        jsr          GetCellCollisionClass.l                       ; $0032C8
        lsl.w        #$2, d3                                       ; $0032CE
        movea.l      (a3, d3.w), a1                                ; $0032D0
        move.b       (a0), d3                                      ; $0032D4
        cmp.w        rCurrentFloorWidth(a6), d4                    ; $0032D6
        ble.b        loc_0032DE                                    ; $0032DA
        clr.w        d3                                            ; $0032DC

loc_0032DE:
        andi.w       #$f, d3                                       ; $0032DE
        jsr          GetCellCollisionClass.l                       ; $0032E2
        lsl.w        #$2, d3                                       ; $0032E8
        movea.l      (a3, d3.w), a2                                ; $0032EA
        move.w       #$0, (a4)                                     ; $0032EE
        move.w       #$0, (a4)                                     ; $0032F2
        addq.w       #$4, a1                                       ; $0032F6
        addq.w       #$4, a2                                       ; $0032F8
        move.w       #$0, (a4)                                     ; $0032FA
        move.w       #$0, (a4)                                     ; $0032FE
        addq.w       #$4, a1                                       ; $003302
        addq.w       #$4, a2                                       ; $003304
        move.w       #$0, (a4)                                     ; $003306
        move.w       #$0, (a4)                                     ; $00330A
        addq.w       #$4, a1                                       ; $00330E
        addq.w       #$4, a2                                       ; $003310
        move.w       #$0, (a4)                                     ; $003312
        move.w       #$0, (a4)                                     ; $003316
        clr.w        d3                                            ; $00331A
        move.w       rCurrentFloorWidth(a6), d3                    ; $00331C
        lsr.w        #$1, d3                                       ; $003320
        move.b       (a0, d3.w), d3                                ; $003322
        cmp.w        rCurrentFloorWidth(a6), d4                    ; $003326
        ble.b        loc_00332E                                    ; $00332A
        clr.w        d3                                            ; $00332C

loc_00332E:
        andi.w       #$ff, d3                                      ; $00332E
        lsr.b        #$4, d3                                       ; $003332
        jsr          GetCellCollisionClass.l                       ; $003334
        lsl.w        #$2, d3                                       ; $00333A
        movea.l      (a3, d3.w), a1                                ; $00333C
        move.w       rCurrentFloorWidth(a6), d3                    ; $003340
        lsr.w        #$1, d3                                       ; $003344
        move.b       (a0, d3.w), d3                                ; $003346
        cmp.w        rCurrentFloorWidth(a6), d4                    ; $00334A
        ble.b        loc_003352                                    ; $00334E
        clr.w        d3                                            ; $003350

loc_003352:
        andi.w       #$f, d3                                       ; $003352
        jsr          GetCellCollisionClass.l                       ; $003356
        lsl.w        #$2, d3                                       ; $00335C
        movea.l      (a3, d3.w), a2                                ; $00335E
        move.w       #$0, (a4)                                     ; $003362
        move.w       #$0, (a4)                                     ; $003366
        addq.w       #$4, a1                                       ; $00336A
        addq.w       #$4, a2                                       ; $00336C
        move.w       #$0, (a4)                                     ; $00336E
        move.w       #$0, (a4)                                     ; $003372
        addq.w       #$4, a1                                       ; $003376
        addq.w       #$4, a2                                       ; $003378
        move.w       #$0, (a4)                                     ; $00337A
        move.w       #$0, (a4)                                     ; $00337E
        addq.w       #$4, a1                                       ; $003382
        addq.w       #$4, a2                                       ; $003384
        move.w       #$0, (a4)                                     ; $003386
        move.w       #$0, (a4)                                     ; $00338A
        addq.w       #$1, a0                                       ; $00338E
        addq.w       #$2, d4                                       ; $003390
        dbra         d6, loc_0032B8                                ; $003392
        movea.l      (a7)+, a0                                     ; $003396
        adda.w       rCurrentFloorWidth(a6), a0                    ; $003398
        dbra         d7, loc_0032AE                                ; $00339C
        rts                                                        ; $0033A0
        ifne *-$33A2
        fail "ROM end moved"
        endif
