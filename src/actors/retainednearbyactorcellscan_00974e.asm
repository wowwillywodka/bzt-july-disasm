; $00974E..$009769 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$974E
        fail "ROM start moved"
        endif

RetainedNearbyActorCellScan:
; 7x7 and entering-edge scans; no direct caller or observed PC found in the reviewed July map. Reachability unproved.
        clr.w        d3                                            ; $00974E
        lea.l        rCellTypeByIndex(a6), a5                      ; $009750
        lea.l        ActorSpawnCellSelectors(pc), a4               ; $009754
        move.l       rPreviousPlayerCellPointer(a6), d0            ; $009758
        subi.l       #$21, d0                                      ; $00975C
        cmp.l        a0, d0                                        ; $009762
        beq.w        RetainedActorScanBranches                     ; $009764
        addq.l       #$1, d0                                       ; $009768
        ifne *-$976A
        fail "ROM end moved"
        endif
