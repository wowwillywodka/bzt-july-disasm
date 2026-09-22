; $021EB0..$021EBB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Вычисление адреса в тайлмапе: A1 = D0*2 + (D1 * (D2*2)) — формула смещения (столбец + строка*ширина)*2 байта для ячейки плоскости VDP
        ifne *-$21EB0
        fail "ROM start moved"
        endif

CalculateTilemapAddress:
        asl.l        #$1, d0                                       ; $021EB0
        asl.l        #$1, d2                                       ; $021EB2
        mulu.w       d1, d2                                        ; $021EB4
        add.l        d0, d2                                        ; $021EB6
        movea.l      d2, a1                                        ; $021EB8
        rts                                                        ; $021EBA
        ifne *-$21EBC
        fail "ROM end moved"
        endif
