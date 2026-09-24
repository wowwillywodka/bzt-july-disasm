; $022628..$02267D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Покадровая интерполяция палитры к целевой: по таймеру (-0x7802) выбирает канал R/G/B, сдвигает соответствующий ниббл каждого цвета на ±2 к цели из (-0x7806,A6), пишет в буфер (-0x7908,A6); считает до 0x14 кадров стабильности
        ifne *-$22628
        fail "ROM start moved"
        endif

StepPaletteFade:
        clr.w        d0                                            ; $022628
        bchg.b       #$1, rPaletteFadeHalfRateToggle(a6)                               ; $02262A
        bne.w        loc_0226FA                                    ; $022630
        cmpi.w       #$14, rPaletteFadeStableStepCount(a6)                              ; $022634
        beq.w        loc_0226FA                                    ; $02263A
        lea.l        rPaletteFadeCurrentColors(a6), a0                                ; $02263E
        movea.l      rPaletteFadeTargetColorsPointer(a6), a1                                ; $022642
        addq.b       #$1, rPaletteFadeComponentIndex(a6)                               ; $022646
        cmpi.b       #$3, rPaletteFadeComponentIndex(a6)                               ; $02264A
        bne.b        loc_022656                                    ; $022650
        clr.b        rPaletteFadeComponentIndex(a6)                                    ; $022652

loc_022656:
        move.w       (a1), d1                                      ; $022656
        move.w       (a0), d2                                      ; $022658
        move.w       d2, d3                                        ; $02265A
        cmpi.b       #$1, rPaletteFadeComponentIndex(a6)                               ; $02265C
        beq.b        loc_022688                                    ; $022662
        cmpi.b       #$2, rPaletteFadeComponentIndex(a6)                               ; $022664
        beq.b        loc_0226A8                                    ; $02266A
        andi.w       #$e, d1                                       ; $02266C
        andi.w       #$e, d3                                       ; $022670
        cmp.w        d1, d3                                        ; $022674
        beq.b        loc_022684                                    ; $022676
        st.b         d0                                            ; $022678
        bgt.b        loc_022682                                    ; $02267A
        addq.w       #$2, d3                                       ; $02267C
        ifne *-$2267E
        fail "ROM end moved"
        endif
