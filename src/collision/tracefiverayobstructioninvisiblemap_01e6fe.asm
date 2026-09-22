; $01E6FE..$01E745 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Five sampled rays: D0/D1=start, D3/D4=end; end offsets (0,0),(+28,0),(-28,0),(0,+28),(0,-28). ANY blocked ray stops and returns D3=1/NZ; all clear ->D3=0/Z. D0/D1/D4 restored as sign-extended words, not result D0. Uses VisibleMapBasePointer. No decoded literal entry found; not a level loader. See docs/ENEMY_LOS.md.
        ifne *-$1E6FE
        fail "ROM start moved"
        endif

TraceFiveRayObstructionInVisibleMap:
; Five sampled rays: D0/D1=start, D3/D4=end; end offsets (0,0),(+28,0),(-28,0),(0,+28),(0,-28). ANY blocked ray stops and returns D3=1/NZ; all clear ->D3=0/Z. D0/D1/D4 restored as sign-extended words, not result D0. Uses VisibleMapBasePointer. No decoded literal entry found; not a level loader. See docs/ENEMY_LOS.md.
        movem.w      d0-d1/d3-d4, -(a7)                            ; $01E6FE
        bsr.b        TraceObstructionInVisibleMap                  ; $01E702
        bne.b        FiveRayVisibleBlocked                         ; $01E704
; Reload original word coordinates WITHOUT consuming the saved stack snapshot; MOVEM.W sign-extends each restored register.
        movem.w      (a7), d0-d1/d3-d4                             ; $01E706
        addi.w       #$1c, d3                                      ; $01E70A
        bsr.b        TraceObstructionInVisibleMap                  ; $01E70E
        bne.b        FiveRayVisibleBlocked                         ; $01E710
        movem.w      (a7), d0-d1/d3-d4                             ; $01E712
        subi.w       #$1c, d3                                      ; $01E716
        bsr.b        TraceObstructionInVisibleMap                  ; $01E71A
        bne.b        FiveRayVisibleBlocked                         ; $01E71C
        movem.w      (a7), d0-d1/d3-d4                             ; $01E71E
        addi.w       #$1c, d4                                      ; $01E722
        bsr.b        TraceObstructionInVisibleMap                  ; $01E726
        bne.b        FiveRayVisibleBlocked                         ; $01E728
        movem.w      (a7), d0-d1/d3-d4                             ; $01E72A
        subi.w       #$1c, d4                                      ; $01E72E
        bsr.b        TraceObstructionInVisibleMap                  ; $01E732
        bne.b        FiveRayVisibleBlocked                         ; $01E734
        movem.w      (a7)+, d0-d1/d3-d4                            ; $01E736
; Success: result is D3=0 and Z=1. Restored D0 is the original start X, not the single-ray boolean.
        moveq        #$0, d3                                       ; $01E73A
        rts                                                        ; $01E73C

FiveRayVisibleBlocked:
        movem.w      (a7)+, d0-d1/d3-d4                            ; $01E73E
; First obstructed ray: D3=1, Z=0; remaining offset rays are skipped.
        moveq        #$1, d3                                       ; $01E742
        rts                                                        ; $01E744
        ifne *-$1E746
        fail "ROM end moved"
        endif
