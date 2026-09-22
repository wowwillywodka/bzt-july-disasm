; $00CD28..$00CD3F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Шаг DDA-луча влево/вверх по A0: subq A0/D0, add (A4),D2 в 8.8-аккумулятор X; при переносе извлекает целую часть (and 0xFF/lsr 8), правит D1 и адрес карты A0 на D3*0x20 (строка); элементарное продвижение трассировки
        ifne *-$CD28
        fail "ROM start moved"
        endif

RayStepQuadrantFourX:
        subq.w       #$1, a0                                       ; $00CD28
        subq.w       #$1, d0                                       ; $00CD2A
        add.w        (a4), d2                                      ; $00CD2C
        cmp.w        d7, d2                                        ; $00CD2E
        bls.b        loc_00CD3E                                    ; $00CD30
        move.w       d2, d3                                        ; $00CD32
        and.w        d7, d2                                        ; $00CD34
        lsr.w        #$8, d3                                       ; $00CD36
        add.w        d3, d1                                        ; $00CD38
        lsl.w        #$5, d3                                       ; $00CD3A
        adda.w       d3, a0                                        ; $00CD3C

loc_00CD3E:
        rts                                                        ; $00CD3E
        ifne *-$CD40
        fail "ROM end moved"
        endif
