; $000A7A..$000A87 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$A7A
        fail "ROM start moved"
        endif

RestartHardwareFromExceptionFrame:
        move.w       #$2700, (a7)                                  ; $000A7A
        move.l       #InitializeHardware, $2(a7)                   ; $000A7E
        rte                                                        ; $000A86
        ifne *-$A88
        fail "ROM end moved"
        endif
