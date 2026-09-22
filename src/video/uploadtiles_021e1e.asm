; $021E1E..$021E49 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Загрузка тайлов в VRAM: из D0 (адрес/тайл) формирует VRAM-команду записи (lsl#7, bset бит30) в $C00004, цикл D1*8 длинных слов из (A0)+ в порт данных — выгрузка графики тайлов
        ifne *-$21E1E
        fail "ROM start moved"
        endif

UploadTiles:
        andi.l       #$ffff, d0                                    ; $021E1E
        andi.l       #$ffff, d1                                    ; $021E24
        lsl.l        #$7, d0                                       ; $021E2A
        lsr.w        #$2, d0                                       ; $021E2C
        swap         d0                                            ; $021E2E
        bset.l       #$1e, d0                                      ; $021E30
        move.l       d0, VDP_CONTROL.l                             ; $021E34
        lsl.l        #$3, d1                                       ; $021E3A
        subq.w       #$1, d1                                       ; $021E3C

loc_021E3E:
        move.l       (a0)+, VDP_DATA.l                             ; $021E3E
        dbra         d1, loc_021E3E                                ; $021E44
        rts                                                        ; $021E48
        ifne *-$21E4A
        fail "ROM end moved"
        endif
