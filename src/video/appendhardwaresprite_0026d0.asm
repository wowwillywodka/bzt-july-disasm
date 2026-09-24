; $0026D0..$0026E1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Appends one packed Mega Drive SAT record at (A2)+: Y, size|next-link,
; tile attribute, X. The caller owns the per-frame RAM list and terminates its
; final link before the list is DMAed to VRAM $B800.
        ifne *-$26D0
        fail "ROM start moved"
        endif

AppendHardwareSprite:
        move.w       d1, (a2)+                                     ; $0026D0
        or.w         rSpriteAttributeNextLink(a6), d0                                ; $0026D2
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $0026D6
        move.w       d0, (a2)+                                     ; $0026DA
        move.w       d3, (a2)+                                     ; $0026DC
        move.w       d2, (a2)+                                     ; $0026DE
        rts                                                        ; $0026E0
        ifne *-$26E2
        fail "ROM end moved"
        endif
