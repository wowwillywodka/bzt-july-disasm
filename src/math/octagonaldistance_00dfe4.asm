; $00DFE4..$00DFFF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Быстрое приближение длины 2D-вектора: abs(D0), abs(D1), берёт max в D2 и возвращает (|D0|+|D1|+max)>>1 — октагональная аппроксимация расстояния
        ifne *-$DFE4
        fail "ROM start moved"
        endif

OctagonalDistance:
        tst.w        d0                                            ; $00DFE4
        bpl.b        loc_00DFEA                                    ; $00DFE6
        neg.w        d0                                            ; $00DFE8

loc_00DFEA:
        tst.w        d1                                            ; $00DFEA
        bpl.b        loc_00DFF0                                    ; $00DFEC
        neg.w        d1                                            ; $00DFEE

loc_00DFF0:
        move.w       d0, d2                                        ; $00DFF0
        cmp.w        d1, d2                                        ; $00DFF2
        bcc.b        loc_00DFF8                                    ; $00DFF4
        move.w       d1, d2                                        ; $00DFF6

loc_00DFF8:
        add.w        d1, d0                                        ; $00DFF8
        add.w        d2, d0                                        ; $00DFFA
        asr.w        #$1, d0                                       ; $00DFFC
        rts                                                        ; $00DFFE
        ifne *-$E000
        fail "ROM end moved"
        endif
