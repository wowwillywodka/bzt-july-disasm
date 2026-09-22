; $01B874..$01B889 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Dormant draw forces bank $23E84A and animation4/frame1.
        ifne *-$1B874
        fail "ROM start moved"
        endif

DrawDenpyderDormant:
; Dormant draw forces bank $23E84A and animation4/frame1.
        move.w       #$4, d0                                       ; $01B874
        move.l       #DenpyderSpriteBank, ActorSpriteBank(a0)      ; $01B878
        move.w       #$1, d2                                       ; $01B880
        jmp          DrawActorAnimation.l                          ; $01B884
        ifne *-$1B88A
        fail "ROM end moved"
        endif
