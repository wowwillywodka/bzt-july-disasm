; $01261E..$012633 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Narrow anchor: D0=scale; D4=scale>>2; Y-=scale, X-=D4>>1; mirror=0.
        ifne *-$1261E
        fail "ROM start moved"
        endif

DrawNarrowObjectTile:
; Narrow anchor: D0=scale; D4=scale>>2; Y-=scale, X-=D4>>1; mirror=0.
        sub.w        d5, d2                                        ; $01261E
        move.w       d5, d0                                        ; $012620
        move.w       d0, d4                                        ; $012622
        asr.w        #$2, d4                                       ; $012624
        move.w       d4, d3                                        ; $012626
        asr.w        #$1, d3                                       ; $012628
        sub.w        d3, d1                                        ; $01262A
        clr.w        rSoftwareSpriteMirrorFlag(a6)                                    ; $01262C
        bra.w        ScaleAndDrawSoftwareSpriteTile                ; $012630
        ifne *-$12634
        fail "ROM end moved"
        endif
