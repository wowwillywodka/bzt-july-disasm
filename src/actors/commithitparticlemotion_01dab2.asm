; $01DAB2..$01DAD1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: commit XY after 16 substeps and damp each
; horizontal motion component by one arithmetic quarter.
        ifne *-$1DAB2
        fail "ROM start moved"
        endif

CommitHitParticleMotion:
        asr.l        #$4, d3                                       ; $01DAB2
        asr.l        #$4, d4                                       ; $01DAB4
        move.w       d3, ActorX(a0)                                ; $01DAB6
        move.w       d4, ActorY(a0)                                ; $01DABA
        move.w       ActorMotionX(a0), d0                          ; $01DABE
        asr.w        #$2, d0                                       ; $01DAC2
        sub.w        d0, ActorMotionX(a0)                          ; $01DAC4
        move.w       ActorMotionY(a0), d0                          ; $01DAC8
        asr.w        #$2, d0                                       ; $01DACC
        sub.w        d0, ActorMotionY(a0)                          ; $01DACE
        ifne *-$1DAD2
        fail "ROM end moved"
        endif
