; $002734..$00274D | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$2734
        fail "ROM start moved"
        endif

StartRetainedPanoramaEffectSounds:
        move.b       #$1, -$6f51(a6)                               ; $002734
        move.w       #$5f, d0                                      ; $00273A
        jsr          SoundRoutine_00DF84.l                         ; $00273E
        move.w       #$83, d0                                      ; $002744
        jsr          SoundRoutine_00DF84.l                         ; $002748
        ifne *-$274E
        fail "ROM end moved"
        endif
