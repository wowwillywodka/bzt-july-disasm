; $028BB6..$028BCF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; D1 is explicitly cleared: copies label zero (9 bytes) from $FF2A86 into (A0)+ regardless of incoming D1.
        ifne *-$28BB6
        fail "ROM start moved"
        endif

CopyFirstSceneLabel:
; D1 is explicitly cleared: copies label zero (9 bytes) from $FF2A86 into (A0)+ regardless of incoming D1.
        clr.w        d1                                            ; $028BB6
        move.w       d1, d2                                        ; $028BB8
        lea.l        -$557a(a6), a1                                ; $028BBA
        mulu.w       #$9, d2                                       ; $028BBE
        adda.w       d2, a1                                        ; $028BC2
        move.w       #$8, d2                                       ; $028BC4

loc_028BC8:
        move.b       (a1)+, (a0)+                                  ; $028BC8
        dbra         d2, loc_028BC8                                ; $028BCA
        rts                                                        ; $028BCE
        ifne *-$28BD0
        fail "ROM end moved"
        endif
