; $00FC18..$00FC55 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Компактный блиттер колонки с прозрачностью: move.b (A1)+,D1; индекс через шейдинг-LUT (A3,D1.w); пропуск нулевых (прозрачных) пикселей, запись в фреймбуфер (A0) со страйдом, цикл dbf D6
        ifne *-$FC18
        fail "ROM start moved"
        endif

DrawLargeSpriteColumn:
        movem.l      d6/a1, -(a7)                                  ; $00FC18
        move.w       rLargeSpriteColumnLastRow(a6), d6                                ; $00FC1C
        move.w       rLargeSpriteVerticalSourcePhase(a6), d0                                ; $00FC20
        move.b       (a1)+, d1                                     ; $00FC24
        beq.b        loc_00FC2C                                    ; $00FC26
        move.b       (a3, d1.w), d1                                ; $00FC28

loc_00FC2C:
        addq.w       #$4, a0                                       ; $00FC2C
        add.w        d2, d0                                        ; $00FC2E
        bcc.b        loc_00FC46                                    ; $00FC30
        move.b       (a1)+, d1                                     ; $00FC32
        beq.b        loc_00FC3C                                    ; $00FC34
        move.b       (a3, d1.w), d1                                ; $00FC36
        move.b       d1, (a0)                                      ; $00FC3A

loc_00FC3C:
        dbra         d6, loc_00FC2C                                ; $00FC3C
        movem.l      (a7)+, d6/a1                                  ; $00FC40
        rts                                                        ; $00FC44

loc_00FC46:
        tst.b        d1                                            ; $00FC46
        beq.b        loc_00FC3C                                    ; $00FC48
        move.b       d1, (a0)                                      ; $00FC4A
        dbra         d6, loc_00FC2C                                ; $00FC4C
        movem.l      (a7)+, d6/a1                                  ; $00FC50
        rts                                                        ; $00FC54
        ifne *-$FC56
        fail "ROM end moved"
        endif
