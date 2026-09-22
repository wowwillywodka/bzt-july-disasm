; $00202A..$002053 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$202A
        fail "ROM start moved"
        endif

IntegerSquareRoot:
        movem.l      d2/d7, -(a7)                                  ; $00202A
        move.w       #$f, d7                                       ; $00202E
        clr.w        d1                                            ; $002032

loc_002034:
        move.w       d1, d2                                        ; $002034
        bset.l       d7, d2                                        ; $002036
        mulu.w       d2, d2                                        ; $002038
        cmp.l        d0, d2                                        ; $00203A
        bhi.b        loc_002042                                    ; $00203C
        beq.b        loc_00204C                                    ; $00203E
        bset.l       d7, d1                                        ; $002040

loc_002042:
        dbra         d7, loc_002034                                ; $002042
        movem.l      (a7)+, d2/d7                                  ; $002046
        rts                                                        ; $00204A

loc_00204C:
        bset.l       d7, d1                                        ; $00204C
        movem.l      (a7)+, d2/d7                                  ; $00204E
        rts                                                        ; $002052
        ifne *-$2054
        fail "ROM end moved"
        endif
