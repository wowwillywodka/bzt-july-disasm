; $00CB3C..$00CB55 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; DDA-шаг вертикального луча: suba #0x20,A1 (соседняя строка карты), subq #1,D5 (счётчик), add (2,A4),D6 в дробный аккумулятор; при D6>D7 вынос целой части (lsr #8) вычитается из D4 и A1
        ifne *-$CB3C
        fail "ROM start moved"
        endif

RayStepQuadrantThreeY:
        suba.w       #$20, a1                                      ; $00CB3C
        subq.w       #$1, d5                                       ; $00CB40
        add.w        $2(a4), d6                                    ; $00CB42
        cmp.w        d7, d6                                        ; $00CB46
        bls.b        loc_00CB54                                    ; $00CB48
        move.w       d6, d3                                        ; $00CB4A
        and.w        d7, d6                                        ; $00CB4C
        lsr.w        #$8, d3                                       ; $00CB4E
        sub.w        d3, d4                                        ; $00CB50
        suba.w       d3, a1                                        ; $00CB52

loc_00CB54:
        rts                                                        ; $00CB54
        ifne *-$CB56
        fail "ROM end moved"
        endif
