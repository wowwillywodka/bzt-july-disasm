; $00F736..$00F761 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Movement sound follows PlayerStridePhase, not the player heading. Select a
; 16-entry sound event by (phase >> 5) & $F and emit it only when ID changes.
        ifne *-$F736
        fail "ROM start moved"
        endif

PlayStrideSoundOnPhaseChange:
        move.w       d0, -(a7)                                     ; $00F736
        move.w       rPlayerStridePhase(a6), d0                                ; $00F738
        asr.w        #$5, d0                                       ; $00F73C
        andi.w       #$f, d0                                       ; $00F73E
        move.b       WallMotionSoundEvents(pc, d0.w), d0           ; $00F742
        cmp.b        rLastStrideSoundPhase(a6), d0                                ; $00F746
        beq.b        loc_00F75E                                    ; $00F74A
        move.b       d0, rLastStrideSoundPhase(a6)                                ; $00F74C
        movem.l      d1/a0, -(a7)                                  ; $00F750
        jsr          PlaySoundEventAndMaybeSendLink.l                         ; $00F754
        movem.l      (a7)+, d1/a0                                  ; $00F75A

loc_00F75E:
        move.w       (a7)+, d0                                     ; $00F75E
        rts                                                        ; $00F760
        ifne *-$F762
        fail "ROM end moved"
        endif
