; $00C920..$00C937 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Шаг +X-луча (восходящий октант): A0+1 колонка, D2+=(A4); при переполнении перенос вычитанием из строки (D1-=hi, A0-=hi*0x20)
        ifne *-$C920
        fail "ROM start moved"
        endif

RayStepQuadrantTwoX:
        addq.w       #$1, a0                                       ; $00C920
        addq.w       #$1, d0                                       ; $00C922
        add.w        (a4), d2                                      ; $00C924
        cmp.w        d7, d2                                        ; $00C926
        bls.b        loc_00C936                                    ; $00C928
        move.w       d2, d3                                        ; $00C92A
        and.w        d7, d2                                        ; $00C92C
        lsr.w        #$8, d3                                       ; $00C92E
        sub.w        d3, d1                                        ; $00C930
        lsl.w        #$5, d3                                       ; $00C932
        suba.w       d3, a0                                        ; $00C934

loc_00C936:
        rts                                                        ; $00C936
        ifne *-$C938
        fail "ROM end moved"
        endif
