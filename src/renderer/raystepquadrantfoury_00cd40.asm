; $00CD40..$00CD59 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Шаг DDA-луча вниз/вправо по A1: adda #0x20,A1 (след. строка) + addq D5, add (2,A4),D6 в 8.8-аккумулятор Y; при переносе берёт целую часть, корректирует D4/A1; элементарное продвижение трассировки стен
        ifne *-$CD40
        fail "ROM start moved"
        endif

RayStepQuadrantFourY:
        adda.w       #$20, a1                                      ; $00CD40
        addq.w       #$1, d5                                       ; $00CD44
        add.w        $2(a4), d6                                    ; $00CD46
        cmp.w        d7, d6                                        ; $00CD4A
        bls.b        loc_00CD58                                    ; $00CD4C
        move.w       d6, d3                                        ; $00CD4E
        and.w        d7, d6                                        ; $00CD50
        lsr.w        #$8, d3                                       ; $00CD52
        sub.w        d3, d4                                        ; $00CD54
        suba.w       d3, a1                                        ; $00CD56

loc_00CD58:
        rts                                                        ; $00CD58
        ifne *-$CD5A
        fail "ROM end moved"
        endif
