; $01C60E..$01C615 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; BYTE State is fuse, not enemy AI here. Decrement to0 ->3x3 panel damage then explosion. Entry0 wraps255; no immediate detonation.
        ifne *-$1C60E
        fail "ROM start moved"
        endif

TickBouncingProjectileFuse:
; BYTE State is fuse, not enemy AI here. Decrement to0 ->3x3 panel damage then explosion. Entry0 wraps255; no immediate detonation.
        subq.b       #$1, ActorState(a0)                           ; $01C60E
        beq.b        DamageProjectileThreeByThreePanels            ; $01C612
        rts                                                        ; $01C614
        ifne *-$1C616
        fail "ROM end moved"
        endif
