; $0021A0..$0021A1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [внутри старой 0x2150] хвост той же VDP-трансфер-подпрограммы: внешний цикл dbra d7,$2114 и завершающий rts
        ifne *-$21A0
        fail "ROM start moved"
        endif

loc_0021A0:
        rts                                                        ; $0021A0
        ifne *-$21A2
        fail "ROM end moved"
        endif
