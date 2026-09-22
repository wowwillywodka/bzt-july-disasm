; $021EA4..$021EAF | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$21EA4
        fail "ROM start moved"
        endif

RetainedVramWriteAddressEntry:
        movem.l      d1-d3, -(a7)                                  ; $021EA4
        move.l       #$40020000, d1                                ; $021EA8
        bra.b        loc_021E78                                    ; $021EAE
        ifne *-$21EB0
        fail "ROM end moved"
        endif
