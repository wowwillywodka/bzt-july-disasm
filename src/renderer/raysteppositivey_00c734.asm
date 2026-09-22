; $00C734..$00C74D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Шаг +Y-луча DDA: A1+=0x20 строка, D6+=(2,A4) приращение; при переполнении >0xFF перенос в D4/A1
        ifne *-$C734
        fail "ROM start moved"
        endif

RayStepPositiveY:
        adda.w       #$20, a1                                      ; $00C734
        addq.w       #$1, d5                                       ; $00C738
        add.w        $2(a4), d6                                    ; $00C73A
        cmp.w        d7, d6                                        ; $00C73E
        bls.b        loc_00C74C                                    ; $00C740
        move.w       d6, d3                                        ; $00C742
        and.w        d7, d6                                        ; $00C744
        lsr.w        #$8, d3                                       ; $00C746
        add.w        d3, d4                                        ; $00C748
        adda.w       d3, a1                                        ; $00C74A

loc_00C74C:
        rts                                                        ; $00C74C
        ifne *-$C74E
        fail "ROM end moved"
        endif
