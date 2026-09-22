; $00CB24..$00CB3B | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Шаг -X-луча (лево-нисходящий октант): A0-1 колонка, D2+=(A4); при переполнении перенос вычитанием из строки (D1-=hi, A0-=hi*0x20)
        ifne *-$CB24
        fail "ROM start moved"
        endif

RayStepQuadrantThreeX:
        subq.w       #$1, a0                                       ; $00CB24
        subq.w       #$1, d0                                       ; $00CB26
        add.w        (a4), d2                                      ; $00CB28
        cmp.w        d7, d2                                        ; $00CB2A
        bls.b        loc_00CB3A                                    ; $00CB2C
        move.w       d2, d3                                        ; $00CB2E
        and.w        d7, d2                                        ; $00CB30
        lsr.w        #$8, d3                                       ; $00CB32
        sub.w        d3, d1                                        ; $00CB34
        lsl.w        #$5, d3                                       ; $00CB36
        suba.w       d3, a0                                        ; $00CB38

loc_00CB3A:
        rts                                                        ; $00CB3A
        ifne *-$CB3C
        fail "ROM end moved"
        endif
