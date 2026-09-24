; $0096CC..$0096D3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: mark this queued wall segment for background-column fill.
; D6.b becomes $FF, then execution falls into the common deduplicating body
; at $0096DA. The word is nonzero; its high byte is not initialized here.
        ifne *-$96CC
        fail "ROM start moved"
        endif

QueueBackgroundFilledWallMarker:
        movem.l      d6-d7/a3, -(a7)                               ; $0096CC
        st.b         d6                                            ; $0096D0
        bra.b        loc_0096DA                                    ; $0096D2
        ifne *-$96D4
        fail "ROM end moved"
        endif
