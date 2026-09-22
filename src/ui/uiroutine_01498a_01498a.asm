; $01498A..$0149EF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Тик обновления иконок HUD по глобальному таймеру (-0x7120,A6)&0x7f: на фазах 0/0x10/0x30 вызывает апдейтеры иконок 0x118cc/0x119ba/0x11a5e, строит указатель в таблицу $FF8ABA
        ifne *-$1498A
        fail "ROM start moved"
        endif

UiRoutine_01498A:
        move.w       rGameTick(a6), d0                             ; $01498A
        andi.w       #$7f, d0                                      ; $01498E
        bne.b        loc_01499E                                    ; $014992
        tst.w        -$6f6c(a6)                                    ; $014994
        bmi.b        loc_01499E                                    ; $014998
        bsr.w        UiRoutine_0118CC                              ; $01499A

loc_01499E:
        tst.w        -$6f6c(a6)                                    ; $01499E
        bpl.b        loc_0149D6                                    ; $0149A2
        tst.w        -$6f6a(a6)                                    ; $0149A4
        bmi.b        loc_0149D6                                    ; $0149A8
        move.l       #$ff8aba, d1                                  ; $0149AA
        move.w       -$71b0(a6), d2                                ; $0149B0
        lsl.w        #$2, d2                                       ; $0149B4
        ext.l        d2                                            ; $0149B6
        add.l        d2, d1                                        ; $0149B8
        move.l       d1, -$6f60(a6)                                ; $0149BA
        addi.l       #$20, d1                                      ; $0149BE
        move.l       d1, -$6f5c(a6)                                ; $0149C4
        addi.w       #$10, d0                                      ; $0149C8
        andi.w       #$7f, d0                                      ; $0149CC
        bne.b        loc_0149D6                                    ; $0149D0
        bsr.w        UiRoutine_0119BA                              ; $0149D2

loc_0149D6:
        move.w       rGameTick(a6), d0                             ; $0149D6
        addi.w       #$30, d0                                      ; $0149DA
        andi.w       #$7f, d0                                      ; $0149DE
        bne.b        loc_0149EE                                    ; $0149E2
        tst.w        -$6f68(a6)                                    ; $0149E4
        bmi.b        loc_0149EE                                    ; $0149E8
        bsr.w        UiRoutine_011A5E                              ; $0149EA

loc_0149EE:
        rts                                                        ; $0149EE
        ifne *-$149F0
        fail "ROM end moved"
        endif
