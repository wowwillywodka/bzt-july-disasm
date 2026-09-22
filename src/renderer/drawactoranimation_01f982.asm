; $01F982..$01F993 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; A0=actor, D0=animation, D2=explicit frame or negative for walk phase; D1=screen X, D5=scale. Bank is ActorSpriteBank. See docs/SPRITE_GRAPHICS.md.
        ifne *-$1F982
        fail "ROM start moved"
        endif

DrawActorAnimation:
; A0=actor, D0=animation, D2=explicit frame or negative for walk phase; D1=screen X, D5=scale. Bank is ActorSpriteBank. See docs/SPRITE_GRAPHICS.md.
        movem.w      d1/d5, -(a7)                                  ; $01F982
        move.w       d2, -(a7)                                     ; $01F986
        movea.l      ActorSpriteBank(a0), a1                       ; $01F988
        cmp.w        (a1)+, d0                                     ; $01F98C
        bcs.b        SelectActorAnimationView                      ; $01F98E
        addq.w       #$6, a7                                       ; $01F990
        rts                                                        ; $01F992
        ifne *-$1F994
        fail "ROM end moved"
        endif
