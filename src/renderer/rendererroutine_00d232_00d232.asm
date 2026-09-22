; $00D232..$00D267 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Проекция вершины 1 мир→камера: кэширует экранные X/Y в (-0x718a/-0x7188), вычитает камеру (-0x7206/-0x7204), поворот sin/cos (-0x71f2/-0x71f0), пишет камера-координаты (глубину/боковое) в (-0x7186)/(-0x7182) для последующего перспект.деления
        ifne *-$D232
        fail "ROM start moved"
        endif

RendererRoutine_00D232:
        move.w       d0, -$718a(a6)                                ; $00D232
        move.w       d1, -$7188(a6)                                ; $00D236
        move.w       d0, d4                                        ; $00D23A
        sub.w        rPlayerX(a6), d4                              ; $00D23C
        move.w       d4, d5                                        ; $00D240
        muls.w       -$71f2(a6), d4                                ; $00D242
        move.w       d1, d3                                        ; $00D246
        sub.w        rPlayerY(a6), d3                              ; $00D248
        move.w       d3, d6                                        ; $00D24C
        muls.w       -$71f0(a6), d3                                ; $00D24E
        add.l        d3, d4                                        ; $00D252
        move.l       d4, -$7186(a6)                                ; $00D254
        muls.w       -$71f2(a6), d6                                ; $00D258
        muls.w       -$71f0(a6), d5                                ; $00D25C
        sub.l        d5, d6                                        ; $00D260
        move.l       d6, -$7182(a6)                                ; $00D262
        rts                                                        ; $00D266
        ifne *-$D268
        fail "ROM end moved"
        endif
