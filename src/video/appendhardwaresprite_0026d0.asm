; $0026D0..$0026E1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Запись 4-словной VDP-команды спрайта/тайла в буфер (A2)+: addr-lo (D1), value|счётчик из -$7fbe(a6) с инкрементом, attr D3, addr-hi D2 — формирует запись для DMA в видеопамять
        ifne *-$26D0
        fail "ROM start moved"
        endif

AppendHardwareSprite:
        move.w       d1, (a2)+                                     ; $0026D0
        or.w         -$7fbe(a6), d0                                ; $0026D2
        addq.w       #$1, -$7fbe(a6)                               ; $0026D6
        move.w       d0, (a2)+                                     ; $0026DA
        move.w       d3, (a2)+                                     ; $0026DC
        move.w       d2, (a2)+                                     ; $0026DE
        rts                                                        ; $0026E0
        ifne *-$26E2
        fail "ROM end moved"
        endif
