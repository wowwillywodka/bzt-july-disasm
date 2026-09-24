; $017E5A..$017EDD | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
; JULY LOCAL REVIEW:
; Retained direct-hit tail behind RTS $17E58; no decoded external literal entry found. Active death starts separately at $17EDE.
        ifne *-$17E5A
        fail "ROM start moved"
        endif

RetainedBlueDummyDirectHit:
; Retained direct-hit tail behind RTS $17E58; no decoded external literal entry found. Active death starts separately at $17EDE.
        move.w       #$400, d3                                     ; $017E5A
        tst.w        rPlayerViewOffsetZ(a6)                                    ; $017E5E
        bpl.b        loc_017E74                                    ; $017E62
        move.w       #$200, d3                                     ; $017E64
        tst.w        rSceneColorMode(a6)                           ; $017E68
        beq.b        loc_017E7E                                    ; $017E6C
        move.w       #$17b, d3                                     ; $017E6E
        bra.b        loc_017E7E                                    ; $017E72

loc_017E74:
        tst.w        rSceneColorMode(a6)                           ; $017E74
        beq.b        loc_017E8E                                    ; $017E78
        move.w       #$300, d3                                     ; $017E7A

loc_017E7E:
        jsr          NextRandom.l                                  ; $017E7E
        asr.l        #$8, d2                                       ; $017E84
        andi.w       #$3ff, d2                                     ; $017E86
        cmp.w        d3, d2                                        ; $017E8A
        bcc.b        loc_017EC8                                    ; $017E8C

loc_017E8E:
        move.w       ActorX(a0), d0                                ; $017E8E
        move.w       ActorY(a0), d1                                ; $017E92
        sub.w        ActorX(a3), d0                                ; $017E96
        sub.w        ActorY(a3), d1                                ; $017E9A
        move.w       d0, d3                                        ; $017E9E
        move.w       d1, d4                                        ; $017EA0
        jsr          OctagonalDistance.l                           ; $017EA2
        cmpi.w       #$400, d0                                     ; $017EA8
        bcc.b        loc_017EDC                                    ; $017EAC
        jsr          NextRandom.w                                  ; $017EAE
        asr.w        #$8, d2                                       ; $017EB2
        andi.w       #$3, d2                                       ; $017EB4
        beq.w        loc_017EDC                                    ; $017EB8
        move.l       a0, -(a7)                                     ; $017EBC
        movea.l      a3, a0                                        ; $017EBE
        movea.l      ActorHitCallback(a0), a1                      ; $017EC0
        jsr          (a1)                                          ; $017EC4
        movea.l      (a7)+, a0                                     ; $017EC6

loc_017EC8:
        move.w       #$5f, d0                                      ; $017EC8
        jsr          RouteSoundEventByActorFloor.l                         ; $017ECC
        move.w       #$83, d0                                      ; $017ED2
        jsr          RouteSoundEventByActorFloor.l                         ; $017ED6

loc_017EDC:
        rts                                                        ; $017EDC
        ifne *-$17EDE
        fail "ROM end moved"
        endif
