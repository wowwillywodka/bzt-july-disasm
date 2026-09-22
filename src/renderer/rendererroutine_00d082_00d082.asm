; $00D082..$00D0F1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Отрисовка грани стены (ориентация C): bsr d122, ptr вершин word(0x6,A2)<<4+0xFF8CEA, проекция d1d6 (+0x100 по Y) и d232 (+0x100 по X) — боковая грань, прыжок в d276
        ifne *-$D082
        fail "ROM start moved"
        endif

RendererRoutine_00D082:
        bsr.w        RendererRoutine_00D122                        ; $00D082
        movea.l      rCurrentCellTextureOrder(a6), a2              ; $00D086
        move.w       $6(a2), d4                                    ; $00D08A
        lsl.w        #$4, d4                                       ; $00D08E
        ext.l        d4                                            ; $00D090
        addi.l       #$ff8cea, d4                                  ; $00D092
        move.l       d4, rCurrentWallTilePair(a6)                  ; $00D098
        addi.w       #$100, d1                                     ; $00D09C
        bsr.w        RendererRoutine_00D1D6                        ; $00D0A0
        subi.w       #$100, d1                                     ; $00D0A4
        addi.w       #$100, d0                                     ; $00D0A8
        bsr.w        RendererRoutine_00D232                        ; $00D0AC
        bra.w        ProjectAndDrawWallFace                        ; $00D0B0

loc_00D0B4:
        cmpa.l       -$715e(a6), a0                                ; $00D0B4
        beq.b        loc_00D0F0                                    ; $00D0B8
        move.l       a0, -$715e(a6)                                ; $00D0BA
        clr.w        d4                                            ; $00D0BE
        move.b       (a0), d4                                      ; $00D0C0
        lsl.w        #$3, d4                                       ; $00D0C2
        lea.l        rTextureOrder(a6), a2                         ; $00D0C4
        adda.w       d4, a2                                        ; $00D0C8
        move.l       a2, rCurrentCellTextureOrder(a6)              ; $00D0CA
        add.w        rPlayerCellX(a6), d0                          ; $00D0CE
        lsl.w        #$8, d0                                       ; $00D0D2
        add.w        rPlayerCellY(a6), d1                          ; $00D0D4
        lsl.w        #$8, d1                                       ; $00D0D8
        move.w       #$ffff, -$7160(a6)                            ; $00D0DA
        bsr.b        RendererRoutine_00D0F2                        ; $00D0E0
        move.w       -$7160(a6), d0                                ; $00D0E2
        cmp.w        -$7162(a6), d0                                ; $00D0E6
        ble.b        loc_00D0F0                                    ; $00D0EA
        move.w       d0, -$7162(a6)                                ; $00D0EC

loc_00D0F0:
        rts                                                        ; $00D0F0
        ifne *-$D0F2
        fail "ROM end moved"
        endif
