; $01B1BA..$01B1CF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Wait for corpse DRAW counter==0; set CA/state3. Update alone cannot advance the eleven-frame transition.
        ifne *-$1B1BA
        fail "ROM start moved"
        endif

WaitGunnerCorpseDrawing:
; Wait for corpse DRAW counter==0; set CA/state3. Update alone cannot advance the eleven-frame transition.
        tst.b        ActorStateCounter(a0)                         ; $01B1BA
        bne.w        loc_01B1CE                                    ; $01B1BE
        move.b       #$ca, ActorDeathMode(a0)                      ; $01B1C2
        move.b       #$3, ActorState(a0)                           ; $01B1C8

loc_01B1CE:
        rts                                                        ; $01B1CE
        ifne *-$1B1D0
        fail "ROM end moved"
        endif
