; $01905E..$0190E1 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
; JULY LOCAL REVIEW:
; Retained direct-hit tail after RTS $1905C. No decoded external literal entry found. Active death starts separately at $190E2.
        ifne *-$1905E
        fail "ROM start moved"
        endif

RetainedLarvaCreatureDirectHit:
; Retained direct-hit tail after RTS $1905C. No decoded external literal entry found. Active death starts separately at $190E2.
        move.w       #$400, d3                                     ; $01905E
        tst.w        rPlayerViewOffsetZ(a6)                                    ; $019062
        bpl.b        loc_019078                                    ; $019066
        move.w       #$200, d3                                     ; $019068
        tst.w        rSceneColorMode(a6)                           ; $01906C
        beq.b        loc_019082                                    ; $019070
        move.w       #$17b, d3                                     ; $019072
        bra.b        loc_019082                                    ; $019076

loc_019078:
        tst.w        rSceneColorMode(a6)                           ; $019078
        beq.b        loc_019092                                    ; $01907C
        move.w       #$300, d3                                     ; $01907E

loc_019082:
        jsr          NextRandom.l                                  ; $019082
        asr.l        #$8, d2                                       ; $019088
        andi.w       #$3ff, d2                                     ; $01908A
        cmp.w        d3, d2                                        ; $01908E
        bcc.b        loc_0190CC                                    ; $019090

loc_019092:
        move.w       ActorX(a0), d0                                ; $019092
        move.w       ActorY(a0), d1                                ; $019096
        sub.w        ActorX(a3), d0                                ; $01909A
        sub.w        ActorY(a3), d1                                ; $01909E
        move.w       d0, d3                                        ; $0190A2
        move.w       d1, d4                                        ; $0190A4
        jsr          OctagonalDistance.l                           ; $0190A6
        cmpi.w       #$400, d0                                     ; $0190AC
        bcc.b        loc_0190E0                                    ; $0190B0
        jsr          NextRandom.w                                  ; $0190B2
        asr.w        #$8, d2                                       ; $0190B6
        andi.w       #$3, d2                                       ; $0190B8
        beq.w        loc_0190E0                                    ; $0190BC
        move.l       a0, -(a7)                                     ; $0190C0
        movea.l      a3, a0                                        ; $0190C2
        movea.l      ActorHitCallback(a0), a1                      ; $0190C4
        jsr          (a1)                                          ; $0190C8
        movea.l      (a7)+, a0                                     ; $0190CA

loc_0190CC:
        move.w       #$5f, d0                                      ; $0190CC
        jsr          RouteSoundEventByActorFloor.l                         ; $0190D0
        move.w       #$83, d0                                      ; $0190D6
        jsr          RouteSoundEventByActorFloor.l                         ; $0190DA

loc_0190E0:
        rts                                                        ; $0190E0
        ifne *-$190E2
        fail "ROM end moved"
        endif
