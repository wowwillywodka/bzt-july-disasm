; $009636..$00963D | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$9636
        fail "ROM start moved"
        endif

SendActorSpawnKind0D:
        move.b       #$d, d0                                       ; $009636
        bra.w        SendActorSpawnCommand                         ; $00963A
        ifne *-$963E
        fail "ROM end moved"
        endif
