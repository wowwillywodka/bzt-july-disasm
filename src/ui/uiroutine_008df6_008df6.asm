; $008DF6..$008E03 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; По флагу (-$6e4c,A6) пишет 4 цвета палитры (long'и $40407f7f/$7f40407f либо $c0c00000/$c0c000) в буфер CRAM -$6e46/-$6e42 — выбор градиента/освещения сцены
        ifne *-$8DF6
        fail "ROM start moved"
        endif

UiRoutine_008DF6:
        move.l       a0, -$42a2(a6)                                ; $008DF6
        bsr.w        EnvironmentRoutine_00D1A2                     ; $008DFA
        move.w       #$1, d3                                       ; $008DFE
        rts                                                        ; $008E02
        ifne *-$8E04
        fail "ROM end moved"
        endif
