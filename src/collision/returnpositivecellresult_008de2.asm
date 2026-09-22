; $008DE2..$008DF5 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$8DE2
        fail "ROM start moved"
        endif

ReturnPositiveCellResult:
        move.w       #$1, d3                                       ; $008DE2
        rts                                                        ; $008DE6

loc_008DE8:
        move.l       a0, -$42a2(a6)                                ; $008DE8
        bsr.w        EnvironmentRoutine_00D166                     ; $008DEC
        move.w       #$1, d3                                       ; $008DF0
        rts                                                        ; $008DF4
        ifne *-$8DF6
        fail "ROM end moved"
        endif
