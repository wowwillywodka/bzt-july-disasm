; $00D016..$00D081 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Отрисовка грани стены (ориентация B): bsr d122, ptr вершин word(0x6,A2)<<4+0xFF8CEA, проекция d1d6 затем d232 с +0x100 (обратный порядок относительно cfac), прыжок в растеризатор d276
        ifne *-$D016
        fail "ROM start moved"
        endif

RendererRoutine_00D016:
        bsr.w        RendererRoutine_00D122                        ; $00D016
        movea.l      rCurrentCellTextureOrder(a6), a2              ; $00D01A
        move.w       $6(a2), d4                                    ; $00D01E
        lsl.w        #$4, d4                                       ; $00D022
        ext.l        d4                                            ; $00D024
        addi.l       #$ff8cea, d4                                  ; $00D026
        move.l       d4, rCurrentWallTilePair(a6)                  ; $00D02C
        bsr.w        RendererRoutine_00D1D6                        ; $00D030
        addi.w       #$100, d0                                     ; $00D034
        addi.w       #$100, d1                                     ; $00D038
        bsr.w        RendererRoutine_00D232                        ; $00D03C
        bra.w        ProjectAndDrawWallFace                        ; $00D040

loc_00D044:
        cmpa.l       -$715e(a6), a0                                ; $00D044
        beq.b        loc_00D080                                    ; $00D048
        move.l       a0, -$715e(a6)                                ; $00D04A
        clr.w        d4                                            ; $00D04E
        move.b       (a0), d4                                      ; $00D050
        lsl.w        #$3, d4                                       ; $00D052
        lea.l        rTextureOrder(a6), a2                         ; $00D054
        adda.w       d4, a2                                        ; $00D058
        move.l       a2, rCurrentCellTextureOrder(a6)              ; $00D05A
        add.w        rPlayerCellX(a6), d0                          ; $00D05E
        lsl.w        #$8, d0                                       ; $00D062
        add.w        rPlayerCellY(a6), d1                          ; $00D064
        lsl.w        #$8, d1                                       ; $00D068
        move.w       #$ffff, -$7160(a6)                            ; $00D06A
        bsr.b        RendererRoutine_00D082                        ; $00D070
        move.w       -$7160(a6), d0                                ; $00D072
        cmp.w        -$7162(a6), d0                                ; $00D076
        ble.b        loc_00D080                                    ; $00D07A
        move.w       d0, -$7162(a6)                                ; $00D07C

loc_00D080:
        rts                                                        ; $00D080
        ifne *-$D082
        fail "ROM end moved"
        endif
