; $00CF2A..$00CFAB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Отрисовка попавшей грани стены (диспетч по celltype 5/4): bsr setup 0xd122, ось -0x6e42, столбец текстуры = 0xff8cea + (4,A2).word<<4, смещение D0/D1 на +0x100, проекция среза стены через 0xd232/0xd1d6, финал 0xd276
        ifne *-$CF2A
        fail "ROM start moved"
        endif

RendererRoutine_00CF2A:
        cmpi.b       #$5, d3                                       ; $00CF2A
        beq.w        RendererRoutine_00D082                        ; $00CF2E
        cmpi.b       #$4, d3                                       ; $00CF32
        beq.w        RendererRoutine_00CFAC                        ; $00CF36
        bsr.w        RendererRoutine_00D122                        ; $00CF3A
        move.w       -$6e42(a6), -$6e48(a6)                        ; $00CF3E
        movea.l      rCurrentCellTextureOrder(a6), a2              ; $00CF44
        move.w       $4(a2), d4                                    ; $00CF48
        lsl.w        #$4, d4                                       ; $00CF4C
        ext.l        d4                                            ; $00CF4E
        addi.l       #$ff8cea, d4                                  ; $00CF50
        move.l       d4, rCurrentWallTilePair(a6)                  ; $00CF56
        addi.w       #$100, d0                                     ; $00CF5A
        bsr.w        RendererRoutine_00D232                        ; $00CF5E
        addi.w       #$100, d1                                     ; $00CF62
        bsr.w        RendererRoutine_00D1D6                        ; $00CF66
        bra.w        ProjectAndDrawWallFace                        ; $00CF6A

loc_00CF6E:
        cmpa.l       -$715e(a6), a0                                ; $00CF6E
        beq.b        loc_00CFAA                                    ; $00CF72
        move.l       a0, -$715e(a6)                                ; $00CF74
        clr.w        d4                                            ; $00CF78
        move.b       (a0), d4                                      ; $00CF7A
        lsl.w        #$3, d4                                       ; $00CF7C
        lea.l        rTextureOrder(a6), a2                         ; $00CF7E
        adda.w       d4, a2                                        ; $00CF82
        move.l       a2, rCurrentCellTextureOrder(a6)              ; $00CF84
        add.w        rPlayerCellX(a6), d0                          ; $00CF88
        lsl.w        #$8, d0                                       ; $00CF8C
        add.w        rPlayerCellY(a6), d1                          ; $00CF8E
        lsl.w        #$8, d1                                       ; $00CF92
        move.w       #$ffff, -$7160(a6)                            ; $00CF94
        bsr.b        RendererRoutine_00CFAC                        ; $00CF9A
        move.w       -$7160(a6), d0                                ; $00CF9C
        cmp.w        -$7162(a6), d0                                ; $00CFA0
        ble.b        loc_00CFAA                                    ; $00CFA4
        move.w       d0, -$7162(a6)                                ; $00CFA6

loc_00CFAA:
        rts                                                        ; $00CFAA
        ifne *-$CFAC
        fail "ROM end moved"
        endif
