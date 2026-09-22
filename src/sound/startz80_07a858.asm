; $07A858..$07A87F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Рестарт Z80 после загрузки драйвера: УДЕРЖИВАЕТ Z80 в reset (0→$A11200), короткая задержка, отдаёт шину (0→$A11100), затем СНИМАЕТ reset (0x100→$A11200) — Z80 начинает исполнять саунд-код
        ifne *-$7A858
        fail "ROM start moved"
        endif

StartZ80:
        move.w       sr, -(a7)                                     ; $07A858
        ori.w        #$700, sr                                     ; $07A85A
        move.w       #$0, Z80_RESET.l                              ; $07A85E
        moveq        #$f, d0                                       ; $07A866

loc_07A868:
        subq.l       #$1, d0                                       ; $07A868
        bne.b        loc_07A868                                    ; $07A86A
        move.w       #$0, Z80_BUS_REQUEST.l                        ; $07A86C
        move.w       #$100, Z80_RESET.l                            ; $07A874
        move.w       (a7)+, sr                                     ; $07A87C
        rts                                                        ; $07A87E
        ifne *-$7A880
        fail "ROM end moved"
        endif
