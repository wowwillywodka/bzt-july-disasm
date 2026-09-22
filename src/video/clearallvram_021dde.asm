; $021DDE..$021DF9 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Очистка VRAM: команда записи VRAM (0x40000000) в $C00004, цикл dbf #0x7fff, заливающий 32768 слов нулями в порт данных — полная очистка видеопамяти
        ifne *-$21DDE
        fail "ROM start moved"
        endif

ClearAllVram:
        move.l       #$40000000, VDP_CONTROL.l                     ; $021DDE
        move.w       #$7fff, d0                                    ; $021DE8

loc_021DEC:
        move.w       #$0, VDP_DATA.l                               ; $021DEC
        dbra         d0, loc_021DEC                                ; $021DF4
        rts                                                        ; $021DF8
        ifne *-$21DFA
        fail "ROM end moved"
        endif
