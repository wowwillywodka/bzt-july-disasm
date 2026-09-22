; $09773A..$0977A3 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Извлечение видимого окна карты 32x32: по координатам игрока (D4/D5) и ширине уровня (-0x4384) вычисляет смещение в карте клеток (0x39fc,A6) и копирует 32 строки по 32 байта в рабочий буфер (0x25fa,A6)
        ifne *-$9773A
        fail "ROM start moved"
        endif

ExtractVisibleMapWindow:
; In D4/D5=new origin cells. Always copy 32 rows of 32 bytes; source row pitch is floor width, even below 32.
        move.w       rCurrentFloorWidth(a6), d2                    ; $09773A
        ext.l        d2                                            ; $09773E
        mulu.w       d2, d5                                        ; $097740
        add.w        d4, d5                                        ; $097742
        lea.l        rEpisodeMapCells(a6), a0                      ; $097744
        adda.w       rCurrentFloorMapOffset(a6), a0                ; $097748
        adda.w       d5, a0                                        ; $09774C
        subi.l       #$20, d2                                      ; $09774E
        lea.l        rVisibleMapWindow(a6), a1                     ; $097754
        move.w       #$1f, d0                                      ; $097758

loc_09775C:
        move.b       (a0)+, (a1)+                                  ; $09775C
        move.b       (a0)+, (a1)+                                  ; $09775E
        move.b       (a0)+, (a1)+                                  ; $097760
        move.b       (a0)+, (a1)+                                  ; $097762
        move.b       (a0)+, (a1)+                                  ; $097764
        move.b       (a0)+, (a1)+                                  ; $097766
        move.b       (a0)+, (a1)+                                  ; $097768
        move.b       (a0)+, (a1)+                                  ; $09776A
        move.b       (a0)+, (a1)+                                  ; $09776C
        move.b       (a0)+, (a1)+                                  ; $09776E
        move.b       (a0)+, (a1)+                                  ; $097770
        move.b       (a0)+, (a1)+                                  ; $097772
        move.b       (a0)+, (a1)+                                  ; $097774
        move.b       (a0)+, (a1)+                                  ; $097776
        move.b       (a0)+, (a1)+                                  ; $097778
        move.b       (a0)+, (a1)+                                  ; $09777A
        move.b       (a0)+, (a1)+                                  ; $09777C
        move.b       (a0)+, (a1)+                                  ; $09777E
        move.b       (a0)+, (a1)+                                  ; $097780
        move.b       (a0)+, (a1)+                                  ; $097782
        move.b       (a0)+, (a1)+                                  ; $097784
        move.b       (a0)+, (a1)+                                  ; $097786
        move.b       (a0)+, (a1)+                                  ; $097788
        move.b       (a0)+, (a1)+                                  ; $09778A
        move.b       (a0)+, (a1)+                                  ; $09778C
        move.b       (a0)+, (a1)+                                  ; $09778E
        move.b       (a0)+, (a1)+                                  ; $097790
        move.b       (a0)+, (a1)+                                  ; $097792
        move.b       (a0)+, (a1)+                                  ; $097794
        move.b       (a0)+, (a1)+                                  ; $097796
        move.b       (a0)+, (a1)+                                  ; $097798
        move.b       (a0)+, (a1)+                                  ; $09779A
        adda.l       d2, a0                                        ; $09779C
        dbra         d0, loc_09775C                                ; $09779E
        rts                                                        ; $0977A2
        ifne *-$977A4
        fail "ROM end moved"
        endif
