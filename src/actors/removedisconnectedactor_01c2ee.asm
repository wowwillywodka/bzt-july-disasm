; $01C2EE..$01C2F1 | m68k
; Maintained assembly input; no extraction occurs during build.
; Default disconnect action: remove this actor from the active pool.
        ifne *-$1C2EE
        fail "ROM start moved"
        endif

RemoveDisconnectedActor:
        bra.w        RemoveActor                                   ; $01C2EE
        ifne *-$1C2F2
        fail "ROM end moved"
        endif
