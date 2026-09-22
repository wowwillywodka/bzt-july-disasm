; $00DFDE..$00DFE3 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$DFDE
        fail "ROM start moved"
        endif

InitializeSoundStateTrampoline:
        jmp          InitializeSoundState.l                        ; $00DFDE
        ifne *-$DFE4
        fail "ROM end moved"
        endif
