; $01E80E..$01E855 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Five sampled rays in fixed active window; same offsets/short-circuit contract as visible-map wrapper. Enemy callers trace from target XY toward five points around shooter XY. Requires ALL rays clear; not an any-visible-point test, no FOV/floor/Z/actor-list check. See docs/ENEMY_LOS.md.
        ifne *-$1E80E
        fail "ROM start moved"
        endif

TraceFiveRayObstructionInActiveWindow:
; Five sampled rays in fixed active window; same offsets/short-circuit contract as visible-map wrapper. Enemy callers trace from target XY toward five points around shooter XY. Requires ALL rays clear; not an any-visible-point test, no FOV/floor/Z/actor-list check. See docs/ENEMY_LOS.md.
        movem.w      d0-d1/d3-d4, -(a7)                            ; $01E80E
        bsr.b        TraceObstructionInActiveWindow                ; $01E812
        bne.b        FiveRayActiveBlocked                          ; $01E814
; Reload original word coordinates WITHOUT consuming the saved stack snapshot; offsets are independent, never cumulative.
        movem.w      (a7), d0-d1/d3-d4                             ; $01E816
        addi.w       #$1c, d3                                      ; $01E81A
        bsr.b        TraceObstructionInActiveWindow                ; $01E81E
        bne.b        FiveRayActiveBlocked                          ; $01E820
        movem.w      (a7), d0-d1/d3-d4                             ; $01E822
        subi.w       #$1c, d3                                      ; $01E826
        bsr.b        TraceObstructionInActiveWindow                ; $01E82A
        bne.b        FiveRayActiveBlocked                          ; $01E82C
        movem.w      (a7), d0-d1/d3-d4                             ; $01E82E
        addi.w       #$1c, d4                                      ; $01E832
        bsr.b        TraceObstructionInActiveWindow                ; $01E836
        bne.b        FiveRayActiveBlocked                          ; $01E838
        movem.w      (a7), d0-d1/d3-d4                             ; $01E83A
        subi.w       #$1c, d4                                      ; $01E83E
        bsr.b        TraceObstructionInActiveWindow                ; $01E842
        bne.b        FiveRayActiveBlocked                          ; $01E844
        movem.w      (a7)+, d0-d1/d3-d4                            ; $01E846
; Success: result is D3=0 and Z=1. Restored D0 is the original start X, not the single-ray boolean.
        moveq        #$0, d3                                       ; $01E84A
        rts                                                        ; $01E84C

FiveRayActiveBlocked:
        movem.w      (a7)+, d0-d1/d3-d4                            ; $01E84E
; First obstructed ray: D3=1, Z=0; remaining offset rays are skipped.
        moveq        #$1, d3                                       ; $01E852
        rts                                                        ; $01E854
        ifne *-$1E856
        fail "ROM end moved"
        endif
