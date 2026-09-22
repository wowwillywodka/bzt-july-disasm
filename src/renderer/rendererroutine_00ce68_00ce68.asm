; $00CE68..$00CEA5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Отрисовка попавшей грани стены (диспетч по celltype 3/4): bsr setup 0xd122, выбор Y-текстуры (-0x6e46,A6), адрес столбца текстуры = 0xff8cea + cell.word(A2)<<4 в -0x7166,A6, проекция вертикального среза стены через 0xd232/0xd1d6, финал 0xd276
        ifne *-$CE68
        fail "ROM start moved"
        endif

RendererRoutine_00CE68:
        cmpi.b       #$3, d3                                       ; $00CE68
        beq.w        RendererRoutine_00D0F2                        ; $00CE6C
        cmpi.b       #$4, d3                                       ; $00CE70
        beq.w        RendererRoutine_00CFAC                        ; $00CE74
        bsr.w        RendererRoutine_00D122                        ; $00CE78
        move.w       -$6e46(a6), -$6e48(a6)                        ; $00CE7C
        movea.l      rCurrentCellTextureOrder(a6), a2              ; $00CE82
; Face slot +0: texture ID * 16 selects four pairs of upper/lower tile indices in RAM TextureDefinitions.
        move.w       (a2), d4                                      ; $00CE86
        lsl.w        #$4, d4                                       ; $00CE88
        ext.l        d4                                            ; $00CE8A
        addi.l       #$ff8cea, d4                                  ; $00CE8C
        move.l       d4, rCurrentWallTilePair(a6)                  ; $00CE92
        bsr.w        RendererRoutine_00D232                        ; $00CE96
        addi.w       #$100, d0                                     ; $00CE9A
        bsr.w        RendererRoutine_00D1D6                        ; $00CE9E
        bra.w        ProjectAndDrawWallFace                        ; $00CEA2
        ifne *-$CEA6
        fail "ROM end moved"
        endif
