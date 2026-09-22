; $0096CC..$0096D3 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 9472] скан клеток (st.b-флаг, обход)
        ifne *-$96CC
        fail "ROM start moved"
        endif

EnemiesRoutine_0096CC:
        movem.l      d6-d7/a3, -(a7)                               ; $0096CC
        st.b         d6                                            ; $0096D0
        bra.b        loc_0096DA                                    ; $0096D2
        ifne *-$96D4
        fail "ROM end moved"
        endif
