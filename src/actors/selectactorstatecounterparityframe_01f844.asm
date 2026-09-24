; $01F844..$01F855 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: shared tail used by actor draw paths. D0 is the
; animation index; D2 becomes the low bit of ActorStateCounter.
        ifne *-$1F844
        fail "ROM start moved"
        endif

SelectActorStateCounterParityFrame:
        clr.w        d2                                            ; $01F844
        btst.b       #$0, ActorStateCounter(a0)                    ; $01F846
        beq.w        DrawActorAnimation                            ; $01F84C
        addq.w       #$1, d2                                       ; $01F850
        bra.w        DrawActorAnimation                            ; $01F852
        ifne *-$1F856
        fail "ROM end moved"
        endif
