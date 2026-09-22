; $019A1C..$019A61 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Direct hit on ActorTarget: D0=$28A; D3/D4=(SavedXY-targetXY) ASR1. No local assignment to SavedXY in this Beatress machine. No impact-time range/LOS check. Local target doubles player motion words; sound$2A.
        ifne *-$19A1C
        fail "ROM start moved"
        endif

ApplyBeatressMeleeHit:
; Direct hit on ActorTarget: D0=$28A; D3/D4=(SavedXY-targetXY) ASR1. No local assignment to SavedXY in this Beatress machine. No impact-time range/LOS check. Local target doubles player motion words; sound$2A.
        movea.l      ActorTarget(a0), a3                           ; $019A1C
        move.w       ActorSavedX(a0), d3                           ; $019A20
        move.w       ActorSavedY(a0), d4                           ; $019A24
        sub.w        ActorX(a3), d3                                ; $019A28
        sub.w        ActorY(a3), d4                                ; $019A2C
        asr.w        #$1, d3                                       ; $019A30
        asr.w        #$1, d4                                       ; $019A32
        move.w       #$28a, d0                                     ; $019A34
        move.l       a0, -(a7)                                     ; $019A38
        movea.l      a3, a0                                        ; $019A3A
        movea.l      ActorHitCallback(a0), a1                      ; $019A3C
        move.l       a3, -(a7)                                     ; $019A40
        jsr          (a1)                                          ; $019A42
        movea.l      (a7)+, a3                                     ; $019A44
        movea.l      (a7)+, a0                                     ; $019A46
        cmpa.l       #$ff11e2, a3                                  ; $019A48
        bne.b        loc_019A58                                    ; $019A4E
        asl.w        -$7202(a6)                                    ; $019A50
        asl.w        -$7200(a6)                                    ; $019A54

loc_019A58:
        move.w       #$2a, d0                                      ; $019A58
        jmp          SoundRoutine_00DF64.l                         ; $019A5C
        ifne *-$19A62
        fail "ROM end moved"
        endif
