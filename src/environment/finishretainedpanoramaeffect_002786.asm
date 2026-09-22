; $002786..$00279D | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$2786
        fail "ROM start moved"
        endif

FinishRetainedPanoramaEffect:
        clr.b        -$6f56(a6)                                    ; $002786
        clr.b        -$6f52(a6)                                    ; $00278A
        rts                                                        ; $00278E

loc_002790:
        clr.b        -$6f56(a6)                                    ; $002790
        clr.b        -$6f51(a6)                                    ; $002794
        subq.b       #$1, -$6f53(a6)                               ; $002798
        rts                                                        ; $00279C
        ifne *-$279E
        fail "ROM end moved"
        endif
