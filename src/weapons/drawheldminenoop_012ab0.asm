; $012AB0..$012AB1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Mine has no held-weapon drawing or animation; action handler places it immediately.
        ifne *-$12AB0
        fail "ROM start moved"
        endif

DrawHeldMineNoOp:
; Mine has no held-weapon drawing or animation; action handler places it immediately.
        rts                                                        ; $012AB0
        ifne *-$12AB2
        fail "ROM end moved"
        endif
