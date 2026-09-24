; $00976A..$0097A7 | m68k
; Maintained assembly input; no extraction occurs during build.
; Retained path entered by fallthrough from $00974E; no ordinary caller known.
; D0 starts as previous map-cell pointer minus $21, A0 is the new pointer.
; The eight equality tests correspond to previous-to-current deltas
; -33,-32,-31,-1,+1,+31,+32,+33 in a 32-byte-row map window.
; A non-neighbor jump falls through to the complete 7x7 scan at $0097A8.
        ifne *-$976A
        fail "ROM start moved"
        endif

RetainedDispatchActorSpawnEdges:
; For a one-cell move, scan only entering rows/columns. The +33 case
; branches to right+TOP ($009804), exactly as encoded in this ROM.
        cmp.l        a0, d0                                        ; $00976A
        beq.w        RetainedScanTopActorEdge                                    ; $00976C
        addq.l       #$1, d0                                       ; $009770
        cmp.l        a0, d0                                        ; $009772
        beq.w        RetainedScanRightThenTopActorEdges                                    ; $009774
        addi.l       #$1e, d0                                      ; $009778
        cmp.l        a0, d0                                        ; $00977E
        beq.w        RetainedScanLeftActorEdge                         ; $009780
        addq.l       #$2, d0                                       ; $009784
        cmp.l        a0, d0                                        ; $009786
        beq.w        RetainedScanRightActorEdge                         ; $009788
        addi.l       #$1e, d0                                      ; $00978C
        cmp.l        a0, d0                                        ; $009792
        beq.w        RetainedScanLeftAndBottomActorEdges                         ; $009794
        addq.l       #$1, d0                                       ; $009798
        cmp.l        a0, d0                                        ; $00979A
        beq.w        RetainedScanBottomActorEdge                                    ; $00979C
        addq.l       #$1, d0                                       ; $0097A0
        cmp.l        a0, d0                                        ; $0097A2
        beq.w        RetainedScanRightThenTopActorEdges                                    ; $0097A4
        ifne *-$97A8
        fail "ROM end moved"
        endif
