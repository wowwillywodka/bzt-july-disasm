; $00964E..$009655 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$964E
        fail "ROM start moved"
        endif

SendActorSpawnKind13:
        move.b       #$13, d0                                      ; $00964E
        bra.w        SendActorSpawnCommand                         ; $009652
        ifne *-$9656
        fail "ROM end moved"
        endif
