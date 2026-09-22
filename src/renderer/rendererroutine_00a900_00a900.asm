; $00A900..$00A961 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Регистрация и 3D-отрисовка сегмента стены: дедуп-вставка A0 в список видимых [-$7118(a6)], сброс счётчиков -$6e46/-$6e42/-$6e48, расчёт экранных координат из -$71ec/-$71ea (lsl #8) через $d232/$d1d6 (проекция вершин), отрисовка $d276 (растеризатор)
        ifne *-$A900
        fail "ROM start moved"
        endif

RendererRoutine_00A900:
        beq.w        loc_00A95E                                    ; $00A900
        cmpa.l       -$7118(a6), a3                                ; $00A904
        bne.b        loc_00A8FE                                    ; $00A908

loc_00A90A:
        move.l       a0, (a3)+                                     ; $00A90A
        move.l       a3, -$7118(a6)                                ; $00A90C
        clr.l        -$6e46(a6)                                    ; $00A910
        clr.l        -$6e42(a6)                                    ; $00A914
        clr.w        -$6e48(a6)                                    ; $00A918
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00A91C
        tst.w        d0                                            ; $00A920
        bmi.b        loc_00A932                                    ; $00A922
        bne.w        RendererRoutine_00A962                        ; $00A924
        cmpi.w       #$80, -$71e4(a6)                              ; $00A928
        bcs.w        RendererRoutine_00A962                        ; $00A92E

loc_00A932:
        add.w        rPlayerCellX(a6), d0                          ; $00A932
        lsl.w        #$8, d0                                       ; $00A936
        add.w        rPlayerCellY(a6), d1                          ; $00A938
        lsl.w        #$8, d1                                       ; $00A93C
        addi.w       #$80, d0                                      ; $00A93E
        bsr.w        RendererRoutine_00D232                        ; $00A942
        addi.w       #$100, d1                                     ; $00A946
        bsr.w        RendererRoutine_00D1D6                        ; $00A94A
        move.l       #$ff8e0a, rCurrentWallTilePair(a6)            ; $00A94E
        bsr.w        ProjectAndDrawWallFace                        ; $00A956
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00A95A

loc_00A95E:
        clr.w        d3                                            ; $00A95E
        rts                                                        ; $00A960
        ifne *-$A962
        fail "ROM end moved"
        endif
