; $01A85E..$01A873 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Wait for draw-side StateCounter==0; this is not an update-count death animation.
        ifne *-$1A85E
        fail "ROM start moved"
        endif

WaitWhiteDummyCorpseDrawing:
; Wait for draw-side StateCounter==0; this is not an update-count death animation.
        tst.b        ActorStateCounter(a0)                         ; $01A85E
        bne.w        loc_01A872                                    ; $01A862
        move.b       #$ca, ActorDeathMode(a0)                      ; $01A866
        move.b       #$3, ActorState(a0)                           ; $01A86C

loc_01A872:
        rts                                                        ; $01A872
        ifne *-$1A874
        fail "ROM end moved"
        endif
