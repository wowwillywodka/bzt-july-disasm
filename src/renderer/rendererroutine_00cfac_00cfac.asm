; $00CFAC..$00D015 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Отрисовка грани стены (ориентация A): bsr d122 (флаг видимости грани), берёт ptr вершин/текстуры word(A2)<<4+0xFF8CEA в (-0x7166,a6), проецирует две вершины d232/d1d6 со смещением +0x100, прыжок в растеризатор d276
        ifne *-$CFAC
        fail "ROM start moved"
        endif

RendererRoutine_00CFAC:
        bsr.w        RendererRoutine_00D122                        ; $00CFAC
        movea.l      rCurrentCellTextureOrder(a6), a2              ; $00CFB0
        move.w       (a2), d4                                      ; $00CFB4
        lsl.w        #$4, d4                                       ; $00CFB6
        ext.l        d4                                            ; $00CFB8
        addi.l       #$ff8cea, d4                                  ; $00CFBA
        move.l       d4, rCurrentWallTilePair(a6)                  ; $00CFC0
        bsr.w        RendererRoutine_00D232                        ; $00CFC4
        addi.w       #$100, d0                                     ; $00CFC8
        addi.w       #$100, d1                                     ; $00CFCC
        bsr.w        RendererRoutine_00D1D6                        ; $00CFD0
        bra.w        ProjectAndDrawWallFace                        ; $00CFD4

loc_00CFD8:
        cmpa.l       -$715e(a6), a0                                ; $00CFD8
        beq.b        loc_00D014                                    ; $00CFDC
        move.l       a0, -$715e(a6)                                ; $00CFDE
        clr.w        d4                                            ; $00CFE2
        move.b       (a0), d4                                      ; $00CFE4
        lsl.w        #$3, d4                                       ; $00CFE6
        lea.l        rTextureOrder(a6), a2                         ; $00CFE8
        adda.w       d4, a2                                        ; $00CFEC
        move.l       a2, rCurrentCellTextureOrder(a6)              ; $00CFEE
        add.w        rPlayerCellX(a6), d0                          ; $00CFF2
        lsl.w        #$8, d0                                       ; $00CFF6
        add.w        rPlayerCellY(a6), d1                          ; $00CFF8
        lsl.w        #$8, d1                                       ; $00CFFC
        move.w       #$ffff, -$7160(a6)                            ; $00CFFE
        bsr.b        RendererRoutine_00D016                        ; $00D004
        move.w       -$7160(a6), d0                                ; $00D006
        cmp.w        -$7162(a6), d0                                ; $00D00A
        ble.b        loc_00D014                                    ; $00D00E
        move.w       d0, -$7162(a6)                                ; $00D010

loc_00D014:
        rts                                                        ; $00D014
        ifne *-$D016
        fail "ROM end moved"
        endif
