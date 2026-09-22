; $01AEF0..$01AF59 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
; JULY LOCAL REVIEW:
; Retained state6 frames behind RTS $1AEEE; requests animation7 (also out of range). Active attack starts at $1AF5A.
        ifne *-$1AEF0
        fail "ROM start moved"
        endif

RetainedActorFrameEvents_01AEF0:
; Retained state6 frames behind RTS $1AEEE; requests animation7 (also out of range). Active attack starts at $1AF5A.
        move.b       ActorStateCounter(a0), d7                     ; $01AEF0
        cmpi.b       #$5, d7                                       ; $01AEF4
        beq.b        loc_01AF14                                    ; $01AEF8
        cmpi.b       #$4, d7                                       ; $01AEFA
        beq.b        loc_01AF22                                    ; $01AEFE
        cmpi.b       #$3, d7                                       ; $01AF00
        beq.b        loc_01AF30                                    ; $01AF04
        cmpi.b       #$2, d7                                       ; $01AF06
        beq.b        loc_01AF3E                                    ; $01AF0A
        cmpi.b       #$1, d7                                       ; $01AF0C
        beq.b        loc_01AF4C                                    ; $01AF10
        rts                                                        ; $01AF12

loc_01AF14:
        move.w       #$7, d0                                       ; $01AF14
        move.w       #$1, d2                                       ; $01AF18
        jmp          DrawActorAnimation.l                          ; $01AF1C

loc_01AF22:
        move.w       #$7, d0                                       ; $01AF22
        move.w       #$2, d2                                       ; $01AF26
        jmp          DrawActorAnimation.l                          ; $01AF2A

loc_01AF30:
        move.w       #$7, d0                                       ; $01AF30
        move.w       #$3, d2                                       ; $01AF34
        jmp          DrawActorAnimation.l                          ; $01AF38

loc_01AF3E:
        move.w       #$7, d0                                       ; $01AF3E
        move.w       #$4, d2                                       ; $01AF42
        jmp          DrawActorAnimation.l                          ; $01AF46

loc_01AF4C:
        move.w       #$7, d0                                       ; $01AF4C
        move.w       #$5, d2                                       ; $01AF50
        jmp          DrawActorAnimation.l                          ; $01AF54
        ifne *-$1AF5A
        fail "ROM end moved"
        endif
