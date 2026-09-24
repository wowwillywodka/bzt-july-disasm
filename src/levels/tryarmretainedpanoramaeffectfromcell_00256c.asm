; $00256C..$002579 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: Cell type $27 only. Arm the retained panorama state if
; its budget is nonzero and it is not already active. Type $28 is a pickup.
        ifne *-$256C
        fail "ROM start moved"
        endif

TryArmRetainedPanoramaEffectFromCell:
        tst.b        rRetainedPanoramaEffectBudget(a6)                                    ; $00256C
        beq.b        loc_002578                                    ; $002570
        tst.b        rRetainedPanoramaEffectActive(a6)                                    ; $002572
        beq.b        ArmRetainedPanoramaEffect                           ; $002576

loc_002578:
        rts                                                        ; $002578
        ifne *-$257A
        fail "ROM end moved"
        endif
