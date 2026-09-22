; $009646..$00964D | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$9646
        fail "ROM start moved"
        endif

SendActorSpawnKind11:
        move.b       #$11, d0                                      ; $009646
        bra.w        SendActorSpawnCommand                         ; $00964A
        ifne *-$964E
        fail "ROM end moved"
        endif
