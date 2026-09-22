; $000A72..$000A79 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June A72] обработчик прерывания (rte-хвосты; HInt/VInt → jsr AA844)
        ifne *-$A72
        fail "ROM start moved"
        endif

FatalException:
        jsr          DrawMissionStatistics.l                       ; $000A72

loc_000A78:
        bra.b        loc_000A78                                    ; $000A78
        ifne *-$A7A
        fail "ROM end moved"
        endif
