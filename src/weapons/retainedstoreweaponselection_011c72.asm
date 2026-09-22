; $011C72..$011C77 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$11C72
        fail "ROM start moved"
        endif

RetainedStoreWeaponSelection:
        move.w       d7, -$6f64(a6)                                ; $011C72
        rts                                                        ; $011C76
        ifne *-$11C78
        fail "ROM end moved"
        endif
