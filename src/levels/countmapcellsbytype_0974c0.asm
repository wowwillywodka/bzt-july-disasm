; $0974C0..$0974DB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Reviewed July: type lookup falls through to CountMapCellIndex; D4 accumulates count, not just a returned index.
        ifne *-$974C0
        fail "ROM start moved"
        endif

CountMapCellsByType:
; Find first cell index for type D2, then FALL THROUGH to count the whole $4000-byte arena into D4.
        clr.w        d0                                            ; $0974C0
        lea.l        rCellTypeByIndex(a6), a0                      ; $0974C2
        movea.l      a0, a1                                        ; $0974C6
        move.w       #$ff, d7                                      ; $0974C8

loc_0974CC:
        clr.w        d3                                            ; $0974CC
        move.b       (a0)+, d3                                     ; $0974CE
        cmp.b        d2, d3                                        ; $0974D0
        beq.b        CountMapCellIndex                             ; $0974D2
        addq.w       #$1, d0                                       ; $0974D4
        dbra         d7, loc_0974CC                                ; $0974D6
        moveq        #-1, d0                                       ; $0974DA
        ifne *-$974DC
        fail "ROM end moved"
        endif
