; $00965E..$009665 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$965E
        fail "ROM start moved"
        endif

SendActorSpawnKind17:
        move.b       #$17, d0                                      ; $00965E
        bra.w        SendActorSpawnCommand                         ; $009662
        ifne *-$9666
        fail "ROM end moved"
        endif
