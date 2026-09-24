; $098AA6..$098AAB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; (D0,D1)->(D1,-D0), negating only D1.W after long EXG. Used by ordinary floor transitions.
        ifne *-$98AA6
        fail "ROM start moved"
        endif

RotateVectorMinusQuarterTurn:
; Direct call rotates one quarter turn; fallthrough from $098AA2 performs the second rotation of a half turn.
; (D0,D1)->(D1,-D0), negating only D1.W after long EXG. Used by ordinary floor transitions.
        exg.l        d0, d1                                        ; $098AA6
        neg.w        d1                                            ; $098AA8
        rts                                                        ; $098AAA
        ifne *-$98AAC
        fail "ROM end moved"
        endif
