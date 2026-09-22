; $0977A4..$0977DB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Reviewed July: A1 local cell -> persistent packed RAM cell using window origin, not player position.
        ifne *-$977A4
        fail "ROM start moved"
        endif

CommitVisibleMapCell:
; A1=changed local-window cell. Persist to packed floor RAM using origin + local coordinates; no bounds guard.
        movem.l      d0-d3/a0, -(a7)                               ; $0977A4
        lea.l        rEpisodeMapCells(a6), a0                      ; $0977A8
        adda.w       rCurrentFloorMapOffset(a6), a0                ; $0977AC
        move.w       rMapWindowOriginX(a6), d0                     ; $0977B0
        move.w       rMapWindowOriginY(a6), d1                     ; $0977B4
        move.l       a1, d2                                        ; $0977B8
        subi.l       #$ffa5fa, d2                                  ; $0977BA
        move.w       d2, d3                                        ; $0977C0
        andi.w       #$1f, d2                                      ; $0977C2
        lsr.w        #$5, d3                                       ; $0977C6
        add.w        d2, d0                                        ; $0977C8
        add.w        d3, d1                                        ; $0977CA
        mulu.w       rCurrentFloorWidth(a6), d1                    ; $0977CC
        add.w        d0, d1                                        ; $0977D0
        adda.w       d1, a0                                        ; $0977D2
        move.b       (a1), (a0)                                    ; $0977D4
        movem.l      (a7)+, d0-d3/a0                               ; $0977D6
        rts                                                        ; $0977DA
        ifne *-$977DC
        fail "ROM end moved"
        endif
