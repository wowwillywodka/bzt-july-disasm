; $0026E2..$0026FF | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$26E2
        fail "ROM start moved"
        endif

AdvanceRetainedPanoramaEffect:
        addq.b       #$1, -$6f52(a6)                               ; $0026E2
        move.b       -$6f52(a6), d0                                ; $0026E6
        cmpi.b       #$20, d0                                      ; $0026EA
        beq.w        FinishRetainedPanoramaEffect                  ; $0026EE
        cmpi.b       #$24, d0                                      ; $0026F2
        beq.w        loc_002790                                    ; $0026F6
        cmpi.b       #$a, d0                                       ; $0026FA
        beq.b        StartRetainedPanoramaEffectSounds             ; $0026FE
        ifne *-$2700
        fail "ROM end moved"
        endif
