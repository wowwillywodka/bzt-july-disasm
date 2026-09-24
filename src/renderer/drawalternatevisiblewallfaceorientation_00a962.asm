; $00A962..$00A991 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Зеркальный путь 3D-отрисовки сегмента стены: проекция вершин с обратным порядком $d1d6/$d232 (другая ориентация грани), затем растеризация через $d276
        ifne *-$A962
        fail "ROM start moved"
        endif

DrawAlternateVisibleWallFaceOrientation:
        add.w        rPlayerCellX(a6), d0                          ; $00A962
        lsl.w        #$8, d0                                       ; $00A966
        add.w        rPlayerCellY(a6), d1                          ; $00A968
        lsl.w        #$8, d1                                       ; $00A96C
        addi.w       #$80, d0                                      ; $00A96E
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00A972
        addi.w       #$100, d1                                     ; $00A976
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00A97A
        move.l       #$ff8e0a, rCurrentWallTilePair(a6)            ; $00A97E
        bsr.w        ProjectAndDrawWallFace                        ; $00A986
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00A98A
        clr.w        d3                                            ; $00A98E
        rts                                                        ; $00A990
        ifne *-$A992
        fail "ROM end moved"
        endif
