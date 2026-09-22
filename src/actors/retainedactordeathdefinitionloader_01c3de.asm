; $01C3DE..$01C3E7 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1C3DE
        fail "ROM start moved"
        endif

RetainedActorDeathDefinitionLoader:
        movea.l      #$a7e4, a1                                    ; $01C3DE
        bra.w        LoadActorDeathDefinition                      ; $01C3E4
        ifne *-$1C3E8
        fail "ROM end moved"
        endif
