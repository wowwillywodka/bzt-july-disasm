; $021DC2..$021DDD | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Очистка палитры: команда записи CRAM (0xC0000000) в $C00004, цикл dbf #0x3f, заливающий 64 слова нулями в порт данных $C00000 — обнуление всех палитр
        ifne *-$21DC2
        fail "ROM start moved"
        endif

ClearCram:
        move.l       #$c0000000, VDP_CONTROL.l                     ; $021DC2
        move.w       #$3f, d0                                      ; $021DCC

loc_021DD0:
        move.w       #$0, VDP_DATA.l                               ; $021DD0
        dbra         d0, loc_021DD0                                ; $021DD8
        rts                                                        ; $021DDC
        ifne *-$21DDE
        fail "ROM end moved"
        endif
