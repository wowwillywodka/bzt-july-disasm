; $098A9E..$098AA5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Three calls/fallthroughs to RotateVectorMinusQuarterTurn: (D0,D1)->(-D1,D0), word arithmetic. Used by ordinary floor transitions, not train state dispatch.
        ifne *-$98A9E
        fail "ROM start moved"
        endif

RotateVectorPlusQuarterTurn:
; Three calls/fallthroughs to RotateVectorMinusQuarterTurn: (D0,D1)->(-D1,D0), word arithmetic. Used by ordinary floor transitions, not train state dispatch.
        bsr.w        RotateVectorMinusQuarterTurn                  ; $098A9E

loc_098AA2:
        bsr.w        RotateVectorMinusQuarterTurn                  ; $098AA2
        ifne *-$98AA6
        fail "ROM end moved"
        endif
