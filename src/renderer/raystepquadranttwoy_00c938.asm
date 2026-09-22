; $00C938..$00C951 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Шаг -Y-луча (вверх): A1-=0x20 строка, D6+=(2,A4); при переполнении перенос в D4/A1
        ifne *-$C938
        fail "ROM start moved"
        endif

RayStepQuadrantTwoY:
        suba.w       #$20, a1                                      ; $00C938
        subq.w       #$1, d5                                       ; $00C93C
        add.w        $2(a4), d6                                    ; $00C93E
        cmp.w        d7, d6                                        ; $00C942
        bls.b        loc_00C950                                    ; $00C944
        move.w       d6, d3                                        ; $00C946
        and.w        d7, d6                                        ; $00C948
        lsr.w        #$8, d3                                       ; $00C94A
        add.w        d3, d4                                        ; $00C94C
        adda.w       d3, a1                                        ; $00C94E

loc_00C950:
        rts                                                        ; $00C950
        ifne *-$C952
        fail "ROM end moved"
        endif
