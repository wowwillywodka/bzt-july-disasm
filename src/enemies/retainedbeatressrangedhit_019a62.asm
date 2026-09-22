; $019A62..$019AE5 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
; JULY LOCAL REVIEW:
; Retained ordinary ranged-hit tail behind unconditional sound JMP $19A5C. No external decoded literal references found. Active death begins separately at $19AE6.
        ifne *-$19A62
        fail "ROM start moved"
        endif

RetainedBeatressRangedHit:
; Retained ordinary ranged-hit tail behind unconditional sound JMP $19A5C. No external decoded literal references found. Active death begins separately at $19AE6.
        move.w       #$400, d3                                     ; $019A62
        tst.w        -$71d8(a6)                                    ; $019A66
        bpl.b        loc_019A7C                                    ; $019A6A
        move.w       #$200, d3                                     ; $019A6C
        tst.w        rSceneColorMode(a6)                           ; $019A70
        beq.b        loc_019A86                                    ; $019A74
        move.w       #$17b, d3                                     ; $019A76
        bra.b        loc_019A86                                    ; $019A7A

loc_019A7C:
        tst.w        rSceneColorMode(a6)                           ; $019A7C
        beq.b        loc_019A96                                    ; $019A80
        move.w       #$300, d3                                     ; $019A82

loc_019A86:
        jsr          NextRandom.l                                  ; $019A86
        asr.l        #$8, d2                                       ; $019A8C
        andi.w       #$3ff, d2                                     ; $019A8E
        cmp.w        d3, d2                                        ; $019A92
        bcc.b        loc_019AD0                                    ; $019A94

loc_019A96:
        move.w       ActorX(a0), d0                                ; $019A96
        move.w       ActorY(a0), d1                                ; $019A9A
        sub.w        ActorX(a3), d0                                ; $019A9E
        sub.w        ActorY(a3), d1                                ; $019AA2
        move.w       d0, d3                                        ; $019AA6
        move.w       d1, d4                                        ; $019AA8
        jsr          OctagonalDistance.l                           ; $019AAA
        cmpi.w       #$400, d0                                     ; $019AB0
        bcc.b        loc_019AE4                                    ; $019AB4
        jsr          NextRandom.w                                  ; $019AB6
        asr.w        #$8, d2                                       ; $019ABA
        andi.w       #$3, d2                                       ; $019ABC
        beq.w        loc_019AE4                                    ; $019AC0
        move.l       a0, -(a7)                                     ; $019AC4
        movea.l      a3, a0                                        ; $019AC6
        movea.l      ActorHitCallback(a0), a1                      ; $019AC8
        jsr          (a1)                                          ; $019ACC
        movea.l      (a7)+, a0                                     ; $019ACE

loc_019AD0:
        move.w       #$5f, d0                                      ; $019AD0
        jsr          SoundRoutine_00DF64.l                         ; $019AD4
        move.w       #$83, d0                                      ; $019ADA
        jsr          SoundRoutine_00DF64.l                         ; $019ADE

loc_019AE4:
        rts                                                        ; $019AE4
        ifne *-$19AE6
        fail "ROM end moved"
        endif
