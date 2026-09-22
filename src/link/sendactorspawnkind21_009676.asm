; $009676..$00967D | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$9676
        fail "ROM start moved"
        endif

SendActorSpawnKind21:
        move.b       #$21, d0                                      ; $009676
        bra.w        SendActorSpawnCommand                         ; $00967A
        ifne *-$967E
        fail "ROM end moved"
        endif
