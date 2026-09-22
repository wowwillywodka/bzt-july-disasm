; $01C6E0..$01C6E5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Always D3.w=0/Z=1 then RTS; used by Blue/Larva flights. Following raw-cell/ActorZ surface classifier is NOT reached by those calls.
        ifne *-$1C6E0
        fail "ROM start moved"
        endif

DisabledActorProjectileSurfaceTest:
; Always D3.w=0/Z=1 then RTS; used by Blue/Larva flights. Following raw-cell/ActorZ surface classifier is NOT reached by those calls.
        move.w       #$0, d3                                       ; $01C6E0
        rts                                                        ; $01C6E4
        ifne *-$1C6E6
        fail "ROM end moved"
        endif
