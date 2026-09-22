; $07A9DC..$07A9E3 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$7A9DC
        fail "ROM start moved"
        endif

RetainedGemsCommands:
        jsr          BeginGemsCommand(pc)                          ; $07A9DC
        moveq        #$14, d0                                      ; $07A9E0
        bra.b        loc_07A9B4                                    ; $07A9E2
        ifne *-$7A9E4
        fail "ROM end moved"
        endif
