; $021E6E..$021EA3 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Запись одного слова в VRAM по адресу из таблицы $00BC00: разбивает базовый адрес на VRAM-команду записи и пишет D0 в порт данных — обновление ячейки спрайт-таблицы/нейм-таблицы
        ifne *-$21E6E
        fail "ROM start moved"
        endif

WriteMenuTile:
        movem.l      d1-d3, -(a7)                                  ; $021E6E
        move.l       #$40000000, d1                                ; $021E72

loc_021E78:
        move.l       Data_00BC00.l, d2                             ; $021E78
        move.l       d2, d3                                        ; $021E7E
        andi.w       #$3fff, d2                                    ; $021E80
        andi.w       #$c000, d3                                    ; $021E84
        swap         d2                                            ; $021E88
        add.l        d2, d1                                        ; $021E8A
        moveq        #$e, d2                                       ; $021E8C
        asr.l        d2, d3                                        ; $021E8E
        add.l        d3, d1                                        ; $021E90
        move.l       d1, VDP_CONTROL.l                             ; $021E92
        move.w       d0, VDP_DATA.l                                ; $021E98
        movem.l      (a7)+, d1-d3                                  ; $021E9E
        rts                                                        ; $021EA2
        ifne *-$21EA4
        fail "ROM end moved"
        endif
