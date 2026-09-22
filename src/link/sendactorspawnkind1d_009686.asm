; $009686..$00968D | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$9686
        fail "ROM start moved"
        endif

SendActorSpawnKind1D:
        move.b       #$1d, d0                                      ; $009686
        bra.w        SendActorSpawnCommand                         ; $00968A
        ifne *-$968E
        fail "ROM end moved"
        endif
