; $00257A..$0025C3 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 2548] Установка флагов эффекта (-$6f5c=$ff,-$6f5a=4) со случайным параметром (rand@$a46) и загрузка 0x170 лонгов графики из 0x16d19a в VRAM ($40000000)
        ifne *-$257A
        fail "ROM start moved"
        endif

VideoRoutine_00257A:
        move.b       #$ff, -$6f56(a6)                              ; $00257A
        clr.b        -$6f52(a6)                                    ; $002580
        clr.b        -$6f51(a6)                                    ; $002584
        move.b       #$4, -$6f54(a6)                               ; $002588
        jsr          NextRandom.l                                  ; $00258E
        swap         d2                                            ; $002594
        andi.w       #$78, d2                                      ; $002596
        move.b       d2, -$6f55(a6)                                ; $00259A

loc_00259E:
        tst.w        -$7ffe(a6)                                    ; $00259E
        bne.b        loc_00259E                                    ; $0025A2
        move.l       #$40000000, VDP_CONTROL.l                     ; $0025A4
        lea.l        Data_1641E0.l, a0                             ; $0025AE
        move.w       #$16f, d7                                     ; $0025B4

loc_0025B8:
        move.l       (a0)+, VDP_DATA.l                             ; $0025B8
        dbra         d7, loc_0025B8                                ; $0025BE
        rts                                                        ; $0025C2
        ifne *-$25C4
        fail "ROM end moved"
        endif
