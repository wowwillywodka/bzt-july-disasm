; $0096D4..$0096FB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: D3.l holds four signed byte coordinates. Search six-byte
; records for that key; append key plus a zero fill-mode word only if absent.
; There is no capacity check here.
        ifne *-$96D4
        fail "ROM start moved"
        endif

QueueUniqueWallMarker:
        movem.l      d6-d7/a3, -(a7)                               ; $0096D4
        clr.w        d6                                            ; $0096D8

loc_0096DA:
        lea.l        rQueuedWallMarkerRecords(a6), a3                                ; $0096DA
        move.w       rQueuedWallMarkerCount(a6), d7                                ; $0096DE
        beq.b        loc_0096EE                                    ; $0096E2

loc_0096E4:
        cmp.l        (a3), d3                                      ; $0096E4
        beq.b        loc_0096F6                                    ; $0096E6
        addq.w       #$6, a3                                       ; $0096E8
        subq.w       #$1, d7                                       ; $0096EA
        bne.b        loc_0096E4                                    ; $0096EC

loc_0096EE:
        move.l       d3, (a3)+                                     ; $0096EE
        move.w       d6, (a3)+                                     ; $0096F0
        addq.w       #$1, rQueuedWallMarkerCount(a6)                               ; $0096F2

loc_0096F6:
        movem.l      (a7)+, d6-d7/a3                               ; $0096F6
        rts                                                        ; $0096FA
        ifne *-$96FC
        fail "ROM end moved"
        endif
