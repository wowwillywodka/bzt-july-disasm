; $002776..$002785 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Called for cell type $28, or $27 when PlayerViewOffsetZ > -10. Supplies
; fixed hit distance and direction to ApplyPlayerDistanceHit, which can
; subtract player HP. No GEMS call occurs here.
        ifne *-$2776
        fail "ROM start moved"
        endif

ApplyRetainedPanoramaCellHit:
        move.w       #$64, d3                                      ; $002776
        clr.w        d4                                            ; $00277A
        move.w       #$64, d0                                      ; $00277C
        jmp          ApplyPlayerDistanceHit.l                      ; $002780
        ifne *-$2786
        fail "ROM end moved"
        endif
