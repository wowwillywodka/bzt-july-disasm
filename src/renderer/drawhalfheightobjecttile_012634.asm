; $012634..$01264B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Half-height anchor: D0=scale>>1, D4=D0>>1; Y-=D0, X-=D4>>1; mirror=0.
        ifne *-$12634
        fail "ROM start moved"
        endif

DrawHalfHeightObjectTile:
; Half-height anchor: D0=scale>>1, D4=D0>>1; Y-=D0, X-=D4>>1; mirror=0.
        move.w       d5, d0                                        ; $012634
        asr.w        #$1, d0                                       ; $012636
        sub.w        d0, d2                                        ; $012638
        move.w       d0, d4                                        ; $01263A
        asr.w        #$1, d4                                       ; $01263C
        move.w       d4, d3                                        ; $01263E
        asr.w        #$1, d3                                       ; $012640
        sub.w        d3, d1                                        ; $012642
        clr.w        -$6f32(a6)                                    ; $012644
        bra.w        ScaleAndDrawSoftwareSpriteTile                ; $012648
        ifne *-$1264C
        fail "ROM end moved"
        endif
