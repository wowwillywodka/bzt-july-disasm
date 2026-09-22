; $0096FC..$00974D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Отрисовка накопленных сегментов карты/радара: по счётчику (-0x6e3a) для каждой записи берёт байт-координаты, прибавляет смещение камеры (-0x71ec/-0x71ea), проецирует точки (0xd1d6/0xd232) и рисует линию Брезенхэма (0xd268)
        ifne *-$96FC
        fail "ROM start moved"
        endif

RendererRoutine_0096FC:
        lea.l        -$6e38(a6), a3                                ; $0096FC

loc_009700:
        tst.w        -$6e3a(a6)                                    ; $009700
        beq.b        loc_00974C                                    ; $009704
        move.b       (a3)+, d0                                     ; $009706
        ext.w        d0                                            ; $009708
        move.b       (a3)+, d1                                     ; $00970A
        ext.w        d1                                            ; $00970C
        add.w        rPlayerCellX(a6), d0                          ; $00970E
        lsl.w        #$8, d0                                       ; $009712
        add.w        rPlayerCellY(a6), d1                          ; $009714
        lsl.w        #$8, d1                                       ; $009718
        move.l       a3, -(a7)                                     ; $00971A
        bsr.w        RendererRoutine_00D1D6                        ; $00971C
        movea.l      (a7)+, a3                                     ; $009720
        move.b       (a3)+, d0                                     ; $009722
        ext.w        d0                                            ; $009724
        move.b       (a3)+, d1                                     ; $009726
        ext.w        d1                                            ; $009728
        add.w        rPlayerCellX(a6), d0                          ; $00972A
        lsl.w        #$8, d0                                       ; $00972E
        add.w        rPlayerCellY(a6), d1                          ; $009730
        lsl.w        #$8, d1                                       ; $009734
        move.w       (a3)+, -$6e20(a6)                             ; $009736
        move.l       a3, -(a7)                                     ; $00973A
        bsr.w        RendererRoutine_00D232                        ; $00973C
        bsr.w        ProjectAndDrawWallMarker                      ; $009740
        movea.l      (a7)+, a3                                     ; $009744
        subq.w       #$1, -$6e3a(a6)                               ; $009746
        bra.b        loc_009700                                    ; $00974A

loc_00974C:
        rts                                                        ; $00974C
        ifne *-$974E
        fail "ROM end moved"
        endif
