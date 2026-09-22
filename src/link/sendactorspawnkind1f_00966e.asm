; $00966E..$009675 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$966E
        fail "ROM start moved"
        endif

SendActorSpawnKind1F:
        move.b       #$1f, d0                                      ; $00966E
        bra.w        SendActorSpawnCommand                         ; $009672
        ifne *-$9676
        fail "ROM end moved"
        endif
