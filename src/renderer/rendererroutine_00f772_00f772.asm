; $00F772..$00F7F5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Аккумулятор движения игрока в курс (-0x71b2,A6): суммирует дельты (-0x7154/-0x7150,A6), зовёт f736 (звук шагов), по порогу считает покачивание камеры/оружия через синус-таблицу (-0x7d90,PC) в (-0x71ee/-0x71f2/-0x71f0,A6)
        ifne *-$F772
        fail "ROM start moved"
        endif

RendererRoutine_00F772:
        move.w       -$7154(a6), d0                                ; $00F772
        bpl.b        loc_00F77A                                    ; $00F776
        neg.w        d0                                            ; $00F778

loc_00F77A:
        move.w       -$7150(a6), d1                                ; $00F77A
        bpl.b        loc_00F782                                    ; $00F77E
        neg.w        d1                                            ; $00F780

loc_00F782:
        add.w        d1, d0                                        ; $00F782
        add.w        d0, -$71b2(a6)                                ; $00F784
        bsr.b        SoundRoutine_00F736                           ; $00F788
        cmpi.w       #$28, d0                                      ; $00F78A
        bcs.b        loc_00F7F0                                    ; $00F78E
        move.w       -$71b2(a6), d0                                ; $00F790
        lea.l        ViewDirectionSteps(pc), a0                    ; $00F794
        asr.w        #$4, d0                                       ; $00F798
        andi.w       #$1c, d0                                      ; $00F79A
        move.w       (a0, d0.w), d1                                ; $00F79E
        move.w       $2(a0, d0.w), d2                              ; $00F7A2
        bne.b        loc_00F7AC                                    ; $00F7A6
        tst.w        d1                                            ; $00F7A8
        beq.b        loc_00F7F0                                    ; $00F7AA

loc_00F7AC:
        move.w       d1, -$71ae(a6)                                ; $00F7AC
        move.w       d2, -$71b0(a6)                                ; $00F7B0
        move.w       -$71ee(a6), -$71ac(a6)                        ; $00F7B4
        move.w       -$71f2(a6), -$71aa(a6)                        ; $00F7BA
        move.w       -$71f0(a6), -$71a8(a6)                        ; $00F7C0
        move.w       -$71d8(a6), -$71a6(a6)                        ; $00F7C6
        add.w        d1, -$71d8(a6)                                ; $00F7CC
        add.w        -$71ee(a6), d2                                ; $00F7D0
        andi.w       #$1ff, d2                                     ; $00F7D4
        move.w       d2, -$71ee(a6)                                ; $00F7D8
        lea.l        AngleVectorPairs(pc), a0                      ; $00F7DC
        lsl.w        #$2, d2                                       ; $00F7E0
        adda.w       d2, a0                                        ; $00F7E2
        move.w       (a0), -$71f2(a6)                              ; $00F7E4
        move.w       $2(a0), -$71f0(a6)                            ; $00F7E8
        rts                                                        ; $00F7EE

loc_00F7F0:
        clr.l        -$71b0(a6)                                    ; $00F7F0
        rts                                                        ; $00F7F4
        ifne *-$F7F6
        fail "ROM end moved"
        endif
