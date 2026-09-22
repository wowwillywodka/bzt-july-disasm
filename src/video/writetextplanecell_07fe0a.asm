; $07FE0A..$07FE35 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Запись одного слова D0 в ячейку VRAM по индексу D4: вычисляет адрес (D4*4 + 0xbc00), формирует VDP-команду записи (bset бит30, andi 0x7fff0003) в $C00004 и пишет D0 в порт данных $C00000
        ifne *-$7FE0A
        fail "ROM start moved"
        endif

WriteTextPlaneCell:
        andi.l       #$ffff, d4                                    ; $07FE0A
        lsl.w        #$2, d4                                       ; $07FE10
        addi.l       #$bc00, d4                                    ; $07FE12
        lsl.l        #$2, d4                                       ; $07FE18
        lsr.w        #$2, d4                                       ; $07FE1A
        swap         d4                                            ; $07FE1C
        bset.l       #$1e, d4                                      ; $07FE1E
        andi.l       #$7fff0003, d4                                ; $07FE22
        move.l       d4, VDP_CONTROL.l                             ; $07FE28
        move.w       d0, VDP_DATA.l                                ; $07FE2E
        rts                                                        ; $07FE34
        ifne *-$7FE36
        fail "ROM end moved"
        endif
