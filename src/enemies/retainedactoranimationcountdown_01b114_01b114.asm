; $01B114..$01B129 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
; JULY LOCAL REVIEW:
; Retained frame6-and-decrement entry; counter1 actually branches to $1B0DE (frame3). Following $1B126 is the ACTIVE CC->CB selector branch.
        ifne *-$1B114
        fail "ROM start moved"
        endif

RetainedActorAnimationCountdown_01B114:
; Retained frame6-and-decrement entry; counter1 actually branches to $1B0DE (frame3). Following $1B126 is the ACTIVE CC->CB selector branch.
        move.w       #$3, d0                                       ; $01B114
        move.w       #$6, d2                                       ; $01B118
        subq.b       #$1, ActorStateCounter(a0)                    ; $01B11C
        jmp          DrawActorAnimation.l                          ; $01B120

loc_01B126:
        bra.w        loc_01B060                                    ; $01B126
        ifne *-$1B12A
        fail "ROM end moved"
        endif
