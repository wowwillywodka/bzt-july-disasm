; $00D26E..$00D273 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June C3E2] рендер-хелпер (регион C3xx)
        ifne *-$D26E
        fail "ROM start moved"
        endif

ProjectWallFaceOnly:
        lea.l        ReturnFromWallProjection(pc), a5              ; $00D26E
        bra.b        loc_00D27A                                    ; $00D272
        ifne *-$D274
        fail "ROM end moved"
        endif
