; $01E6EC..$01E6FD | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Загрузка БАЗОВОГО указателя сетки карты: A1 = (0x25fa,A6) = $FFA5FA; D0 сохраняется. Сдвиг <<10 — мёртвый код: D0 обнуляется (clr.w D0) ПЕРЕД lsl, поэтому индекс этажа/строки не применяется
        ifne *-$1E6EC
        fail "ROM start moved"
        endif

GetVisibleMapBase:
        move.w       d0, -(a7)                                     ; $01E6EC
        lea.l        rVisibleMapWindow(a6), a1                     ; $01E6EE
        clr.w        d0                                            ; $01E6F2
        lsl.w        #$8, d0                                       ; $01E6F4
        lsl.w        #$2, d0                                       ; $01E6F6
        adda.w       d0, a1                                        ; $01E6F8
        move.w       (a7)+, d0                                     ; $01E6FA
        rts                                                        ; $01E6FC
        ifne *-$1E6FE
        fail "ROM end moved"
        endif
