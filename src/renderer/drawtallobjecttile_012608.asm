; $012608..$01261D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Tall anchor: D0=scale; D4=scale>>1; Y-=scale, X-=D4>>1; mirror=0.
        ifne *-$12608
        fail "ROM start moved"
        endif

DrawTallObjectTile:
; Tall anchor: D0=scale; D4=scale>>1; Y-=scale, X-=D4>>1; mirror=0.
        sub.w        d5, d2                                        ; $012608
        move.w       d5, d0                                        ; $01260A
        move.w       d0, d4                                        ; $01260C
        asr.w        #$1, d4                                       ; $01260E
        move.w       d4, d3                                        ; $012610
        asr.w        #$1, d3                                       ; $012612
        sub.w        d3, d1                                        ; $012614
        clr.w        -$6f32(a6)                                    ; $012616
        bra.w        ScaleAndDrawSoftwareSpriteTile                ; $01261A
        ifne *-$1261E
        fail "ROM end moved"
        endif
