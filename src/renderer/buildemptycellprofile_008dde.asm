; $008DDE..$008DE1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 8C3E] спец-хендлер «пусто»: d3=0 (пол/двери-проёмы)
        ifne *-$8DDE
        fail "ROM start moved"
        endif

BuildEmptyCellProfile:
; Direct table entry: emit an empty profile (D3.W=0). Fallthrough from $008DD8 first queues a projected object.
        clr.w        d3                                            ; $008DDE
        rts                                                        ; $008DE0
        ifne *-$8DE2
        fail "ROM end moved"
        endif
