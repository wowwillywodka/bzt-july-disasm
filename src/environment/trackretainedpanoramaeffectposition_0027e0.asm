; $0027E0..$0027FF | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$27E0
        fail "ROM start moved"
        endif

TrackRetainedPanoramaEffectPosition:
        tst.b        -$6f4e(a6)                                    ; $0027E0
        beq.b        UiRoutine_002800                              ; $0027E4
        move.w       -$6f4c(a6), d0                                ; $0027E6
        lsl.w        #$1, d0                                       ; $0027EA
        add.w        -$6f4c(a6), d0                                ; $0027EC
        add.w        -$6f50(a6), d0                                ; $0027F0
        asr.w        #$2, d0                                       ; $0027F4
        move.w       d0, -$6f4c(a6)                                ; $0027F6
        move.b       #$14, -$6f52(a6)                              ; $0027FA
        ifne *-$2800
        fail "ROM end moved"
        endif
