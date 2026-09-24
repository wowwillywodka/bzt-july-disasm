; $022018..$02201F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 1C5CC] DMA/копир-хелперы (регион 1C4xx)
        ifne *-$22018
        fail "ROM start moved"
        endif

FadeFullPaletteToBlack:
        moveq        #$0, d0                                       ; $022018
        moveq        #$3f, d5                                      ; $02201A
        bra.w        FadePaletteToBlack                            ; $02201C
        ifne *-$22020
        fail "ROM end moved"
        endif
