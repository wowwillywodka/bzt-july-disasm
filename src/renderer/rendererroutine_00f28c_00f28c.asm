; $00F28C..$00F359 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Сборка спрайтов игрока/тени в дисплей-лист (A2): экранные X/Y из мировых координат, эмиссия слов спрайта, доп. смещения вспышки/тени по вектору направления (-0x71f0/-0x71f2)
        ifne *-$F28C
        fail "ROM start moved"
        endif

RendererRoutine_00F28C:
        move.w       rPlayerY(a6), d0                              ; $00F28C
        move.w       -$7208(a6), d3                                ; $00F290
        clr.b        d3                                            ; $00F294
        sub.w        d3, d0                                        ; $00F296
        asr.w        #$5, d0                                       ; $00F298
        addi.w       #$12e, d0                                     ; $00F29A
        move.w       d0, (a2)+                                     ; $00F29E
        move.w       -$7fbe(a6), d1                                ; $00F2A0
        ori.w        #$0, d1                                       ; $00F2A4
        move.w       d1, (a2)+                                     ; $00F2A8
        addq.w       #$1, -$7fbe(a6)                               ; $00F2AA
        move.w       d5, (a2)+                                     ; $00F2AE
        move.w       rPlayerX(a6), d2                              ; $00F2B0
        move.w       -$720a(a6), d3                                ; $00F2B4
        clr.b        d3                                            ; $00F2B8
        sub.w        d3, d2                                        ; $00F2BA
        asr.w        #$5, d2                                       ; $00F2BC
        addi.w       #$10e, d2                                     ; $00F2BE
        move.w       d2, (a2)+                                     ; $00F2C2
        btst.b       #$0, -$711f(a6)                               ; $00F2C4
        beq.w        loc_00F358                                    ; $00F2CA
        movem.w      d0/d2, -(a7)                                  ; $00F2CE
        move.w       -$71f0(a6), d3                                ; $00F2D2
        asr.w        #$6, d3                                       ; $00F2D6
        add.w        d3, d0                                        ; $00F2D8
        move.w       d0, (a2)+                                     ; $00F2DA
        move.w       -$7fbe(a6), d1                                ; $00F2DC
        ori.w        #$0, d1                                       ; $00F2E0
        move.w       d1, (a2)+                                     ; $00F2E4
        addq.w       #$1, -$7fbe(a6)                               ; $00F2E6
        move.w       #$e2f2, (a2)+                                 ; $00F2EA
        move.w       -$71f2(a6), d3                                ; $00F2EE
        asr.w        #$6, d3                                       ; $00F2F2
        add.w        d3, d2                                        ; $00F2F4
        move.w       d2, (a2)+                                     ; $00F2F6
        movem.w      (a7)+, d0/d2                                  ; $00F2F8
        movem.w      d0/d2, -(a7)                                  ; $00F2FC
        move.w       -$71f0(a6), d3                                ; $00F300
        asr.w        #$5, d3                                       ; $00F304
        add.w        d3, d0                                        ; $00F306
        move.w       d0, (a2)+                                     ; $00F308
        move.w       -$7fbe(a6), d1                                ; $00F30A
        ori.w        #$0, d1                                       ; $00F30E
        move.w       d1, (a2)+                                     ; $00F312
        addq.w       #$1, -$7fbe(a6)                               ; $00F314
        move.w       #$e2f2, (a2)+                                 ; $00F318
        move.w       -$71f2(a6), d3                                ; $00F31C
        asr.w        #$5, d3                                       ; $00F320
        add.w        d3, d2                                        ; $00F322
        move.w       d2, (a2)+                                     ; $00F324
        movem.w      (a7)+, d0/d2                                  ; $00F326
        move.w       -$71f0(a6), d3                                ; $00F32A
        asr.w        #$5, d3                                       ; $00F32E
        add.w        d3, d0                                        ; $00F330
        asr.w        #$1, d3                                       ; $00F332
        add.w        d3, d0                                        ; $00F334
        move.w       d0, (a2)+                                     ; $00F336
        move.w       -$7fbe(a6), d1                                ; $00F338
        ori.w        #$0, d1                                       ; $00F33C
        move.w       d1, (a2)+                                     ; $00F340
        addq.w       #$1, -$7fbe(a6)                               ; $00F342
        move.w       #$e2f2, (a2)+                                 ; $00F346
        move.w       -$71f2(a6), d3                                ; $00F34A
        asr.w        #$5, d3                                       ; $00F34E
        add.w        d3, d2                                        ; $00F350
        asr.w        #$1, d3                                       ; $00F352
        add.w        d3, d2                                        ; $00F354
        move.w       d2, (a2)+                                     ; $00F356

loc_00F358:
        rts                                                        ; $00F358
        ifne *-$F35A
        fail "ROM end moved"
        endif
