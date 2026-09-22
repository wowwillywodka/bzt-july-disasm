; $00F816..$00F837 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$F816
        fail "ROM start moved"
        endif

loc_00F816:
        tst.l        -$71b0(a6)                                    ; $00F816
        bne.b        loc_00F81E                                    ; $00F81A
        rts                                                        ; $00F81C

loc_00F81E:
        move.w       -$71ac(a6), -$71ee(a6)                        ; $00F81E
        move.w       -$71aa(a6), -$71f2(a6)                        ; $00F824
        move.w       -$71a8(a6), -$71f0(a6)                        ; $00F82A
        move.w       -$71a6(a6), -$71d8(a6)                        ; $00F830
        rts                                                        ; $00F836
        ifne *-$F838
        fail "ROM end moved"
        endif
