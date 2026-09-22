; $01C3CA..$01C3D3 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1C3CA
        fail "ROM start moved"
        endif

RetainedActorDefinitionLoader:
        movea.l      #Data_00A64E, a1                              ; $01C3CA
        bra.w        LoadActorDefinition                           ; $01C3D0
        ifne *-$1C3D4
        fail "ROM end moved"
        endif
