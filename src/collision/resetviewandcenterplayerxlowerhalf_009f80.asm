; $009F80..$009F9B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Transition helper: halve vertical view Z, clear its target and velocity,
; then center the fractional player X byte if bit 7 was clear.
        ifne *-$9F80
        fail "ROM start moved"
        endif

ResetViewAndCenterPlayerXLowerHalf:
        asr.w        rPlayerViewOffsetZ(a6)                                    ; $009F80
        clr.w        rPlayerViewOffsetTargetZ(a6)                                    ; $009F84
        clr.w        rPlayerViewVerticalVelocity(a6)                                    ; $009F88
        btst.b       #$7, rPlayerXLow(a6)                               ; $009F8C
        bne.b        loc_009F9A                                    ; $009F92
        move.b       #$80, rPlayerXLow(a6)                              ; $009F94

loc_009F9A:
        rts                                                        ; $009F9A
        ifne *-$9F9C
        fail "ROM end moved"
        endif
