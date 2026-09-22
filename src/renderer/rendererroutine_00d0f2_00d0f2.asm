; $00D0F2..$00D121 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Отрисовка грани стены (ориентация D): bsr d122, ptr вершин word(A2)<<4+0xFF8CEA, проекция d232 (+0x100 по Y) и d1d6 (+0x100 по X) — зеркальная боковая грань, прыжок в d276
        ifne *-$D0F2
        fail "ROM start moved"
        endif

RendererRoutine_00D0F2:
        bsr.w        RendererRoutine_00D122                        ; $00D0F2
        movea.l      rCurrentCellTextureOrder(a6), a2              ; $00D0F6
        move.w       (a2), d4                                      ; $00D0FA
        lsl.w        #$4, d4                                       ; $00D0FC
        ext.l        d4                                            ; $00D0FE
        addi.l       #$ff8cea, d4                                  ; $00D100
        move.l       d4, rCurrentWallTilePair(a6)                  ; $00D106
        addi.w       #$100, d1                                     ; $00D10A
        bsr.w        RendererRoutine_00D232                        ; $00D10E
        subi.w       #$100, d1                                     ; $00D112
        addi.w       #$100, d0                                     ; $00D116
        bsr.w        RendererRoutine_00D1D6                        ; $00D11A
        bra.w        ProjectAndDrawWallFace                        ; $00D11E
        ifne *-$D122
        fail "ROM end moved"
        endif
