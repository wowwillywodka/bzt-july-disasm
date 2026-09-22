; $07A80A..$07A813 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 641FA] Z80 bus release ($A11100=0) — GEMS-хелпер [VERIFIED]
        ifne *-$7A80A
        fail "ROM start moved"
        endif

ReleaseZ80Bus:
        move.w       #$0, Z80_BUS_REQUEST.l                        ; $07A80A
        rts                                                        ; $07A812
        ifne *-$7A814
        fail "ROM end moved"
        endif
