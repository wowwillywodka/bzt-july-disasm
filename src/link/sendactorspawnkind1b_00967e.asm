; $00967E..$009685 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$967E
        fail "ROM start moved"
        endif

SendActorSpawnKind1B:
        move.b       #$1b, d0                                      ; $00967E
        bra.w        SendActorSpawnCommand                         ; $009682
        ifne *-$9686
        fail "ROM end moved"
        endif
