; $01264C..$012661 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Small anchor: D0=D4=scale>>2; Y-=D0, X-=D4>>1; mirror=0. D4 counts packed-byte columns, hence physical preview width is 2*D4.
        ifne *-$1264C
        fail "ROM start moved"
        endif

DrawSmallObjectTile:
; Small anchor: D0=D4=scale>>2; Y-=D0, X-=D4>>1; mirror=0. D4 counts packed-byte columns, hence physical preview width is 2*D4.
        move.w       d5, d0                                        ; $01264C
        asr.w        #$2, d0                                       ; $01264E
        sub.w        d0, d2                                        ; $012650
        move.w       d0, d4                                        ; $012652
        move.w       d4, d3                                        ; $012654
        asr.w        #$1, d3                                       ; $012656
        sub.w        d3, d1                                        ; $012658
        clr.w        rSoftwareSpriteMirrorFlag(a6)                                    ; $01265A
        bra.w        ScaleAndDrawSoftwareSpriteTile                ; $01265E
        ifne *-$12662
        fail "ROM end moved"
        endif
