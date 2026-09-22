; $0977DC..$097835 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Reviewed July: packed per-cell nibbles at $FF3D9E; A1 selects byte, A0 parity selects its half.
        ifne *-$977DC
        fail "ROM start moved"
        endif

GetCellRenderStateAddress:
; Returns A1=packed nibble byte, A0=parity token (base+full cell index); not two independent state arrays.
        movem.l      d0-d3, -(a7)                                  ; $0977DC
        movea.l      a0, a1                                        ; $0977E0
        lea.l        rEpisodeMapCells(a6), a0                      ; $0977E2
        adda.w       rCurrentFloorMapOffset(a6), a0                ; $0977E6
        move.w       rMapWindowOriginX(a6), d0                     ; $0977EA
        move.w       rMapWindowOriginY(a6), d1                     ; $0977EE
        move.l       a1, d2                                        ; $0977F2
        subi.l       #$ffa5fa, d2                                  ; $0977F4
        divu.w       #$20, d2                                      ; $0977FA
        move.w       d2, d3                                        ; $0977FE
        swap         d2                                            ; $097800
        add.w        d2, d0                                        ; $097802
        add.w        d3, d1                                        ; $097804
        mulu.w       rCurrentFloorWidth(a6), d1                    ; $097806
        add.w        d0, d1                                        ; $09780A
        adda.w       d1, a0                                        ; $09780C
        move.l       a0, d0                                        ; $09780E
        move.l       a0, d1                                        ; $097810
        subi.l       #$ffb9fc, d0                                  ; $097812
        subi.l       #$ffb9fc, d1                                  ; $097818
        lsr.l        #$1, d0                                       ; $09781E
        addi.l       #$ff3d9e, d0                                  ; $097820
        addi.l       #$ff3d9e, d1                                  ; $097826
        movea.l      d1, a0                                        ; $09782C
        movea.l      d0, a1                                        ; $09782E
        movem.l      (a7)+, d0-d3                                  ; $097830
        rts                                                        ; $097834
        ifne *-$97836
        fail "ROM end moved"
        endif
