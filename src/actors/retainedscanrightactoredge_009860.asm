; $009860..$00989D | m68k
; Maintained assembly input; no extraction occurs during build.
; Retained right-column scan: seven cells at A0-$5D + 32*n (n=0..6).
; Clip against player X<$1D00 and local Y cells 0..31. A0 is a local
; cell pointer, whereas the clipping coordinates come from player XY.
        ifne *-$9860
        fail "ROM start moved"
        endif

RetainedScanRightActorEdge:
        cmpi.w       #$1d00, rPlayerX(a6)                          ; $009860
        bcc.b        loc_00989C                                    ; $009866
        move.w       rPlayerY(a6), d0                              ; $009868
        asr.w        #$8, d0                                       ; $00986C
        subq.w       #$4, d0                                       ; $00986E
        lea.l        -$5d(a0), a1                                  ; $009870
        move.w       #$6, d7                                       ; $009874

loc_009878:
        addq.w       #$1, d0                                       ; $009878
        bmi.b        loc_009894                                    ; $00987A
        cmpi.w       #$20, d0                                      ; $00987C
        bcc.b        loc_00989C                                    ; $009880
        clr.w        d3                                            ; $009882
        move.b       (a1), d3                                      ; $009884
        move.b       (a5, d3.w), d3                                ; $009886
        move.b       (a4, d3.w), d3                                ; $00988A
        beq.b        loc_009894                                    ; $00988E
        bsr.w        SelectActorDefinitionFromCell                 ; $009890

loc_009894:
        adda.w       #$20, a1                                      ; $009894
        dbra         d7, loc_009878                                ; $009898

loc_00989C:
        rts                                                        ; $00989C
        ifne *-$989E
        fail "ROM end moved"
        endif
