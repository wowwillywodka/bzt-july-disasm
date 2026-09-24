; $00980C..$00981B | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$980C
        fail "ROM start moved"
        endif

RetainedActorScanBranches:
; Previous-to-current pointer delta -33: left and top entering edges.
        bsr.w        RetainedScanLeftActorEdge                         ; $00980C
        bra.w        RetainedScanTopActorEdge                                    ; $009810
        bsr.w        RetainedScanRightActorEdge                         ; $009814
        bra.w        RetainedScanBottomActorEdge                                    ; $009818
        ifne *-$981C
        fail "ROM end moved"
        endif
