; $021FC2..$021FEB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Запись одной записи sprite attribute table (SAT): адрес D0<<3 + база (-0x790c,A6) в $C00004, затем 4 слова атрибутов спрайта (Y/size/tile/X) в порт данных
        ifne *-$21FC2
        fail "ROM start moved"
        endif

WriteHardwareSprite:
        swap         d0                                            ; $021FC2
        clr.w        d0                                            ; $021FC4
        asl.l        #$3, d0                                       ; $021FC6
        add.l        -$790c(a6), d0                                ; $021FC8
        move.l       d0, VDP_CONTROL.l                             ; $021FCC

loc_021FD2:
        move.w       d3, VDP_DATA.l                                ; $021FD2
        move.w       d1, VDP_DATA.l                                ; $021FD8
        move.w       d4, VDP_DATA.l                                ; $021FDE
        move.w       d2, VDP_DATA.l                                ; $021FE4
        rts                                                        ; $021FEA
        ifne *-$21FEC
        fail "ROM end moved"
        endif
