; $021E5C..$021E6D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 1C410] DMA/копир-хелперы (регион 1C4xx)
        ifne *-$21E5C
        fail "ROM start moved"
        endif

WriteScreenTile:
        move.l       #$40020010, VDP_CONTROL.l                     ; $021E5C
        move.w       d0, VDP_DATA.l                                ; $021E66
        rts                                                        ; $021E6C
        ifne *-$21E6E
        fail "ROM end moved"
        endif
