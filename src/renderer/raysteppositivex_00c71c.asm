; $00C71C..$00C733 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Шаг +X-луча DDA: A0+1 колонка, D2+=(A4) приращение; при переполнении >0xFF перенос в строку (D1+=hi, A0+=hi*0x20)
        ifne *-$C71C
        fail "ROM start moved"
        endif

RayStepPositiveX:
        addq.w       #$1, a0                                       ; $00C71C
        addq.w       #$1, d0                                       ; $00C71E
        add.w        (a4), d2                                      ; $00C720
        cmp.w        d7, d2                                        ; $00C722
        bls.b        loc_00C732                                    ; $00C724
        move.w       d2, d3                                        ; $00C726
        and.w        d7, d2                                        ; $00C728
        lsr.w        #$8, d3                                       ; $00C72A
        add.w        d3, d1                                        ; $00C72C
        lsl.w        #$5, d3                                       ; $00C72E
        adda.w       d3, a0                                        ; $00C730

loc_00C732:
        rts                                                        ; $00C732
        ifne *-$C734
        fail "ROM end moved"
        endif
