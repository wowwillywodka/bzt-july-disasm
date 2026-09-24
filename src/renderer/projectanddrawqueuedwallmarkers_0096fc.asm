; $0096FC..$00974D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: consume six-byte wall-marker records, transform both
; endpoints from player-relative cell coordinates, then project/draw each span.
; This decrements the queue count to zero; record bytes remain in RAM.
        ifne *-$96FC
        fail "ROM start moved"
        endif

ProjectAndDrawQueuedWallMarkers:
        lea.l        rQueuedWallMarkerRecords(a6), a3                                ; $0096FC

loc_009700:
        tst.w        rQueuedWallMarkerCount(a6)                                    ; $009700
        beq.b        loc_00974C                                    ; $009704
        move.b       (a3)+, d0                                     ; $009706
        ext.w        d0                                            ; $009708
        move.b       (a3)+, d1                                     ; $00970A
        ext.w        d1                                            ; $00970C
        add.w        rPlayerCellX(a6), d0                          ; $00970E
        lsl.w        #$8, d0                                       ; $009712
        add.w        rPlayerCellY(a6), d1                          ; $009714
        lsl.w        #$8, d1                                       ; $009718
        move.l       a3, -(a7)                                     ; $00971A
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00971C
        movea.l      (a7)+, a3                                     ; $009720
        move.b       (a3)+, d0                                     ; $009722
        ext.w        d0                                            ; $009724
        move.b       (a3)+, d1                                     ; $009726
        ext.w        d1                                            ; $009728
        add.w        rPlayerCellX(a6), d0                          ; $00972A
        lsl.w        #$8, d0                                       ; $00972E
        add.w        rPlayerCellY(a6), d1                          ; $009730
        lsl.w        #$8, d1                                       ; $009734
        move.w       (a3)+, rCurrentWallMarkerFillMode(a6)                             ; $009736
        move.l       a3, -(a7)                                     ; $00973A
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00973C
        bsr.w        ProjectAndDrawWallMarker                      ; $009740
        movea.l      (a7)+, a3                                     ; $009744
        subq.w       #$1, rQueuedWallMarkerCount(a6)                               ; $009746
        bra.b        loc_009700                                    ; $00974A

loc_00974C:
        rts                                                        ; $00974C
        ifne *-$974E
        fail "ROM end moved"
        endif
