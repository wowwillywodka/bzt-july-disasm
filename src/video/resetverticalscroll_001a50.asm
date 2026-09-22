; $001A50..$001A77 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Хвост FUN_001a50 (запрет прерываний #$2700): два move.l #0,$C00000 обнуляют 8 байт VRAM по адресу $B800 (команда $78000002 = VRAM-write addr $B800), затем restore SR; это очистка области VRAM, НЕ палитры
        ifne *-$1A50
        fail "ROM start moved"
        endif

ResetVerticalScroll:
        move.w       sr, -(a7)                                     ; $001A50
        move.w       #$2700, sr                                    ; $001A52
        move.l       #$78000002, VDP_CONTROL.l                     ; $001A56
        move.l       #$0, VDP_DATA.l                               ; $001A60
        move.l       #$0, VDP_DATA.l                               ; $001A6A
        move.w       (a7)+, sr                                     ; $001A74
        rts                                                        ; $001A76
        ifne *-$1A78
        fail "ROM end moved"
        endif
