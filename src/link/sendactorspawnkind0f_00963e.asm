; $00963E..$009645 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$963E
        fail "ROM start moved"
        endif

SendActorSpawnKind0F:
        move.b       #$f, d0                                       ; $00963E
        bra.w        SendActorSpawnCommand                         ; $009642
        ifne *-$9646
        fail "ROM end moved"
        endif
