; $0238E8..$023915 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Печать двух центрированных строк в плейн VRAM: VDP-команда записи из D0 (andi $3fff/ori $4000/swap, lsr#8/#6), заливка 0x80 тайлов #$8000, центрирование по длине ASCIIZ из (A0), глифы (символ-0x20, lsl#2 → пара слов в шрифт-таблице по lea -0x19c(PC) = $2377C, +2 на 2-ю строку) в порт данных $C00000
        ifne *-$238E8
        fail "ROM start moved"
        endif

PrintHudString:
        movea.l      #VDP_DATA, a4                                 ; $0238E8
        move.w       d0, -(a7)                                     ; $0238EE
        move.w       d0, d1                                        ; $0238F0
        andi.w       #$3fff, d1                                    ; $0238F2
        ori.w        #$4000, d1                                    ; $0238F6
        swap         d1                                            ; $0238FA
        lsr.w        #$8, d0                                       ; $0238FC
        lsr.w        #$6, d0                                       ; $0238FE
        move.w       d0, d1                                        ; $023900
        move.l       d1, VDP_CONTROL.l                             ; $023902
        move.w       (a7)+, d0                                     ; $023908
        move.w       #$7f, d7                                      ; $02390A

loc_02390E:
        move.w       #$8000, (a4)                                  ; $02390E
        dbra         d7, loc_02390E                                ; $023912
        ifne *-$23916
        fail "ROM end moved"
        endif
