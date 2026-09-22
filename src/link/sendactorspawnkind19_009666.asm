; $009666..$00966D | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$9666
        fail "ROM start moved"
        endif

SendActorSpawnKind19:
        move.b       #$19, d0                                      ; $009666
        bra.w        SendActorSpawnCommand                         ; $00966A
        ifne *-$966E
        fail "ROM end moved"
        endif
