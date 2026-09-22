; $00CEA6..$00CEE9 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Отрисовка попавшей грани стены (диспетч по celltype 2/5): bsr setup 0xd122, выбор оси -0x6e44, столбец текстуры = 0xff8cea + (6,A2).word<<4, смещение D1/D0 на +0x100, проекция среза через 0xd1d6/0xd232, финал 0xd276
        ifne *-$CEA6
        fail "ROM start moved"
        endif

RendererRoutine_00CEA6:
        cmpi.b       #$2, d3                                       ; $00CEA6
        beq.w        RendererRoutine_00D016                        ; $00CEAA
        cmpi.b       #$5, d3                                       ; $00CEAE
        beq.w        RendererRoutine_00D082                        ; $00CEB2
        bsr.w        RendererRoutine_00D122                        ; $00CEB6
        move.w       -$6e44(a6), -$6e48(a6)                        ; $00CEBA
        movea.l      rCurrentCellTextureOrder(a6), a2              ; $00CEC0
        move.w       $6(a2), d4                                    ; $00CEC4
        lsl.w        #$4, d4                                       ; $00CEC8
        ext.l        d4                                            ; $00CECA
        addi.l       #$ff8cea, d4                                  ; $00CECC
        move.l       d4, rCurrentWallTilePair(a6)                  ; $00CED2
        addi.w       #$100, d1                                     ; $00CED6
        bsr.w        RendererRoutine_00D1D6                        ; $00CEDA
        addi.w       #$100, d0                                     ; $00CEDE
        bsr.w        RendererRoutine_00D232                        ; $00CEE2
        bra.w        ProjectAndDrawWallFace                        ; $00CEE6
        ifne *-$CEEA
        fail "ROM end moved"
        endif
