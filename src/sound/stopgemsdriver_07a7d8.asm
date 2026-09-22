; $07A7D8..$07A7F5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Стоп/останов Z80-звукодрайвера: маска IRQ, bus-request (0x7A7F6), пишет 0 в $A01B20 (флаг плеера), снимает шину (0x7A80A), восстанавливает SR — остановка проигрывания
        ifne *-$7A7D8
        fail "ROM start moved"
        endif

StopGemsDriver:
        move.w       sr, -(a7)                                     ; $07A7D8
        ori.w        #$700, sr                                     ; $07A7DA
        jsr          AcquireZ80Bus.l                               ; $07A7DE
        move.b       #$0, $a01b20.l                                ; $07A7E4
        jsr          ReleaseZ80Bus.l                               ; $07A7EC
        move.w       (a7)+, sr                                     ; $07A7F2
        rts                                                        ; $07A7F4
        ifne *-$7A7F6
        fail "ROM end moved"
        endif
