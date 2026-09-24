; $01DB3C..$01DB4B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Decrement the shared live-particle count if nonzero, then remove actor.
        ifne *-$1DB3C
        fail "ROM start moved"
        endif

RemoveHitParticle:
; Actor exit callback or carry fallthrough from resting particle update. A0 must point to the particle actor.
; The link command and list removal are shared with other actors.
        tst.w        rHitParticleCount(a6)                                    ; $01DB3C
        beq.w        RemoveActorAndSendLink                        ; $01DB40
        subq.w       #$1, rHitParticleCount(a6)                               ; $01DB44
        bra.w        RemoveActorAndSendLink                        ; $01DB48
        ifne *-$1DB4C
        fail "ROM end moved"
        endif
