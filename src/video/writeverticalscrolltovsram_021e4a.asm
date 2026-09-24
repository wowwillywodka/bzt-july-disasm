; $021E4A..$021E5B | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 1C3FE] DMA/копир-хелперы (регион 1C4xx)
        ifne *-$21E4A
        fail "ROM start moved"
        endif

WriteVerticalScrollToVsram:
        move.l       #$40000010, VDP_CONTROL.l                     ; $021E4A
        move.w       d0, VDP_DATA.l                                ; $021E54
        rts                                                        ; $021E5A
        ifne *-$21E5C
        fail "ROM end moved"
        endif
