; $07A9A6..$07A9AD | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$7A9A6
        fail "ROM start moved"
        endif

RetainedGemsCommand1D:
        jsr          BeginGemsCommand(pc)                          ; $07A9A6
        moveq        #$1d, d0                                      ; $07A9AA
        bra.b        WriteGemsOneArgumentCommand                                    ; $07A9AC
        ifne *-$7A9AE
        fail "ROM end moved"
        endif
