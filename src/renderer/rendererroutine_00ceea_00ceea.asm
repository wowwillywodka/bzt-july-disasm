; $00CEEA..$00CF29 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Отрисовка попавшей грани стены (диспетч по celltype 2/3): bsr setup 0xd122, ось -0x6e40, столбец текстуры = 0xff8cea + (2,A2).word<<4, проекция вертикального среза стены через 0xd1d6/0xd232 с +0x100 по D1, финал 0xd276
        ifne *-$CEEA
        fail "ROM start moved"
        endif

RendererRoutine_00CEEA:
        cmpi.b       #$2, d3                                       ; $00CEEA
        beq.w        RendererRoutine_00D016                        ; $00CEEE
        cmpi.b       #$3, d3                                       ; $00CEF2
        beq.w        RendererRoutine_00D0F2                        ; $00CEF6
        bsr.w        RendererRoutine_00D122                        ; $00CEFA
        move.w       -$6e40(a6), -$6e48(a6)                        ; $00CEFE
        movea.l      rCurrentCellTextureOrder(a6), a2              ; $00CF04
; Face slot +2 selects a 16-byte texture definition; other face paths use +4 and +6.
        move.w       $2(a2), d4                                    ; $00CF08
        lsl.w        #$4, d4                                       ; $00CF0C
        ext.l        d4                                            ; $00CF0E
        addi.l       #$ff8cea, d4                                  ; $00CF10
        move.l       d4, rCurrentWallTilePair(a6)                  ; $00CF16
        bsr.w        RendererRoutine_00D1D6                        ; $00CF1A
        addi.w       #$100, d1                                     ; $00CF1E
        bsr.w        RendererRoutine_00D232                        ; $00CF22
        bra.w        ProjectAndDrawWallFace                        ; $00CF26
        ifne *-$CF2A
        fail "ROM end moved"
        endif
