; $01A66A..$01A6D3 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
; JULY LOCAL REVIEW:
; Retained state6 frame sequence behind RTS $1A668. Active attack rendering begins at $1A6D4, outside this retained range.
        ifne *-$1A66A
        fail "ROM start moved"
        endif

RetainedActorFrameEvents_01A66A:
; Retained state6 frame sequence behind RTS $1A668. Active attack rendering begins at $1A6D4, outside this retained range.
        move.b       ActorStateCounter(a0), d7                     ; $01A66A
        cmpi.b       #$5, d7                                       ; $01A66E
        beq.b        loc_01A68E                                    ; $01A672
        cmpi.b       #$4, d7                                       ; $01A674
        beq.b        loc_01A69C                                    ; $01A678
        cmpi.b       #$3, d7                                       ; $01A67A
        beq.b        loc_01A6AA                                    ; $01A67E
        cmpi.b       #$2, d7                                       ; $01A680
        beq.b        loc_01A6B8                                    ; $01A684
        cmpi.b       #$1, d7                                       ; $01A686
        beq.b        loc_01A6C6                                    ; $01A68A
        rts                                                        ; $01A68C

loc_01A68E:
        move.w       #$5, d0                                       ; $01A68E
        move.w       #$1, d2                                       ; $01A692
        jmp          DrawActorAnimation.l                          ; $01A696

loc_01A69C:
        move.w       #$5, d0                                       ; $01A69C
        move.w       #$2, d2                                       ; $01A6A0
        jmp          DrawActorAnimation.l                          ; $01A6A4

loc_01A6AA:
        move.w       #$5, d0                                       ; $01A6AA
        move.w       #$3, d2                                       ; $01A6AE
        jmp          DrawActorAnimation.l                          ; $01A6B2

loc_01A6B8:
        move.w       #$5, d0                                       ; $01A6B8
        move.w       #$4, d2                                       ; $01A6BC
        jmp          DrawActorAnimation.l                          ; $01A6C0

loc_01A6C6:
        move.w       #$5, d0                                       ; $01A6C6
        move.w       #$5, d2                                       ; $01A6CA
        jmp          DrawActorAnimation.l                          ; $01A6CE
        ifne *-$1A6D4
        fail "ROM end moved"
        endif
