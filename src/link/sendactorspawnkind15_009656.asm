; $009656..$00965D | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$9656
        fail "ROM start moved"
        endif

SendActorSpawnKind15:
        move.b       #$15, d0                                      ; $009656
        bra.w        SendActorSpawnCommand                         ; $00965A
        ifne *-$965E
        fail "ROM end moved"
        endif
