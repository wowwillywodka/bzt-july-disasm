; $07A73E..$07A76D | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$7A73E
        fail "ROM start moved"
        endif

RetainedGemsRegisterWrappers:
        andi.l       #$ffff, d0                                    ; $07A73E
        move.l       d0, -(a7)                                     ; $07A744
        bsr.w        GemsStartSequence                           ; $07A746
        addq.w       #$4, a7                                       ; $07A74A
        rts                                                        ; $07A74C
        andi.l       #$ffff, d0                                    ; $07A74E
        move.l       d0, -(a7)                                     ; $07A754
        bsr.w        GemsStopSequence                           ; $07A756
        addq.w       #$4, a7                                       ; $07A75A
        rts                                                        ; $07A75C
        andi.l       #$ffff, d0                                    ; $07A75E
        move.l       d0, -(a7)                                     ; $07A764
        bsr.w        GemsSetTempo                           ; $07A766
        addq.w       #$4, a7                                       ; $07A76A
        rts                                                        ; $07A76C
        ifne *-$7A76E
        fail "ROM end moved"
        endif
