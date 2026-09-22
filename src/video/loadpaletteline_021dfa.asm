; $021DFA..$021E1D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Загрузка одной 16-цветной палитры: из D0 (номер линии CRAM 0-3) собирает команду записи CRAM (lsl#5, ori 0xC000, swap), цикл 16 раз пишет слова цвета (A0)+ в порт данных
        ifne *-$21DFA
        fail "ROM start moved"
        endif

LoadPaletteLine:
        andi.l       #$3, d0                                       ; $021DFA
        lsl.l        #$5, d0                                       ; $021E00
        ori.w        #$c000, d0                                    ; $021E02
        swap         d0                                            ; $021E06
        move.l       d0, VDP_CONTROL.l                             ; $021E08
        move.w       #$f, d0                                       ; $021E0E

loc_021E12:
        move.w       (a0)+, VDP_DATA.l                             ; $021E12
        dbra         d0, loc_021E12                                ; $021E18
        rts                                                        ; $021E1C
        ifne *-$21E1E
        fail "ROM end moved"
        endif
