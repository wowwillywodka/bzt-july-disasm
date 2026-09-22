; $01BBC4..$01BBD9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Counter0 ->CA/state4, deliberately preserving original mismatch with pickup gate.
        ifne *-$1BBC4
        fail "ROM start moved"
        endif

WaitDenpyderCorpseDrawing:
; Counter0 ->CA/state4, deliberately preserving original mismatch with pickup gate.
        tst.b        ActorStateCounter(a0)                         ; $01BBC4
        bne.w        loc_01BBD8                                    ; $01BBC8
        move.b       #$ca, ActorDeathMode(a0)                      ; $01BBCC
        move.b       #$4, ActorState(a0)                           ; $01BBD2

loc_01BBD8:
        rts                                                        ; $01BBD8
        ifne *-$1BBDA
        fail "ROM end moved"
        endif
