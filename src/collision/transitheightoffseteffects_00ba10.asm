; $00BA10..$00BAB5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: Legacy height formulas use the low byte of player X/Y.
; No episode CellTypeByIndex LUT contains the 18 types selecting these targets.
; See docs/TRANSIT_HEIGHT_HANDLERS.md for exact per-type formulas.
        ifne *-$BA10
        fail "ROM start moved"
        endif

SetTransitHeightFromYMinusFF:
        move.w       rPlayerY(a6), d0                              ; $00BA10
        andi.w       #$ff, d0                                      ; $00BA14
        subi.w       #$ff, d0                                      ; $00BA18
        asr.w        #$2, d0                                       ; $00BA1C
        move.w       d0, rTransitHeightOffset(a6)                                ; $00BA1E
        rts                                                        ; $00BA22

SetTransitHeightFromNegatedY:
        move.w       rPlayerY(a6), d0                              ; $00BA24
        andi.w       #$ff, d0                                      ; $00BA28
        neg.w        d0                                            ; $00BA2C
        asr.w        #$2, d0                                       ; $00BA2E
        move.w       d0, rTransitHeightOffset(a6)                                ; $00BA30
        rts                                                        ; $00BA34

SetTransitHeightFromNegatedX:
        move.w       rPlayerX(a6), d0                              ; $00BA36
        andi.w       #$ff, d0                                      ; $00BA3A
        neg.w        d0                                            ; $00BA3E
        asr.w        #$2, d0                                       ; $00BA40
        move.w       d0, rTransitHeightOffset(a6)                                ; $00BA42
        rts                                                        ; $00BA46

SetTransitHeightFromXMinusFF:
        move.w       rPlayerX(a6), d0                              ; $00BA48
        andi.w       #$ff, d0                                      ; $00BA4C
        subi.w       #$ff, d0                                      ; $00BA50
        asr.w        #$2, d0                                       ; $00BA54
        move.w       d0, rTransitHeightOffset(a6)                                ; $00BA56
        rts                                                        ; $00BA5A

ClearTransitHeightOffset:
        clr.w        rTransitHeightOffset(a6)                                    ; $00BA5C
        rts                                                        ; $00BA60

SetTransitHeightFromFFMinusY:
        move.w       rPlayerY(a6), d0                              ; $00BA62
        andi.w       #$ff, d0                                      ; $00BA66
        neg.w        d0                                            ; $00BA6A
        addi.w       #$ff, d0                                      ; $00BA6C
        asr.w        #$2, d0                                       ; $00BA70
        move.w       d0, rTransitHeightOffset(a6)                                ; $00BA72
        rts                                                        ; $00BA76

SetTransitHeightFromYFraction:
        move.w       rPlayerY(a6), d0                              ; $00BA78
        andi.w       #$ff, d0                                      ; $00BA7C
        asr.w        #$2, d0                                       ; $00BA80
        move.w       d0, rTransitHeightOffset(a6)                                ; $00BA82
        rts                                                        ; $00BA86

SetTransitHeightFromXFraction:
        move.w       rPlayerX(a6), d0                              ; $00BA88
        andi.w       #$ff, d0                                      ; $00BA8C
        asr.w        #$2, d0                                       ; $00BA90
        move.w       d0, rTransitHeightOffset(a6)                                ; $00BA92
        rts                                                        ; $00BA96

SetTransitHeightFromFFMinusX:
        move.w       rPlayerX(a6), d0                              ; $00BA98
        andi.w       #$ff, d0                                      ; $00BA9C
        neg.w        d0                                            ; $00BAA0
        addi.w       #$ff, d0                                      ; $00BAA2
        asr.w        #$2, d0                                       ; $00BAA6
        move.w       d0, rTransitHeightOffset(a6)                                ; $00BAA8
        rts                                                        ; $00BAAC

SetTransitHeightNegativeLimit:
        move.w       #$ffc0, rTransitHeightOffset(a6)                            ; $00BAAE
        rts                                                        ; $00BAB4
        ifne *-$BAB6
        fail "ROM end moved"
        endif
