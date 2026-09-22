; $0096D4..$0096FB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Вставка точки/блипа в список отрисовки карты: ищет 4-байт ключ D3 в таблице (-0x6e38,A6) по 6-байт записям; если нет — добавляет ключ+флаг D6 и инкрементит счётчик (-0x6e3a,A6)
        ifne *-$96D4
        fail "ROM start moved"
        endif

RendererRoutine_0096D4:
        movem.l      d6-d7/a3, -(a7)                               ; $0096D4
        clr.w        d6                                            ; $0096D8

loc_0096DA:
        lea.l        -$6e38(a6), a3                                ; $0096DA
        move.w       -$6e3a(a6), d7                                ; $0096DE
        beq.b        loc_0096EE                                    ; $0096E2

loc_0096E4:
        cmp.l        (a3), d3                                      ; $0096E4
        beq.b        loc_0096F6                                    ; $0096E6
        addq.w       #$6, a3                                       ; $0096E8
        subq.w       #$1, d7                                       ; $0096EA
        bne.b        loc_0096E4                                    ; $0096EC

loc_0096EE:
        move.l       d3, (a3)+                                     ; $0096EE
        move.w       d6, (a3)+                                     ; $0096F0
        addq.w       #$1, -$6e3a(a6)                               ; $0096F2

loc_0096F6:
        movem.l      (a7)+, d6-d7/a3                               ; $0096F6
        rts                                                        ; $0096FA
        ifne *-$96FC
        fail "ROM end moved"
        endif
