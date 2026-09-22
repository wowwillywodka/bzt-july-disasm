; $01E236..$01E259 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1E236
        fail "ROM start moved"
        endif

RetainedActorTargetRefresh:
        move.w       rGameTick(a6), d0                             ; $01E236
        add.b        ActorLinkId(a0), d0                           ; $01E23A
        andi.w       #$7, d0                                       ; $01E23E
        bne.b        loc_01E24E                                    ; $01E242
        bsr.w        RetainedPartnerProximityResponse              ; $01E244
        move.l       a1, ActorTarget(a0)                           ; $01E248
        beq.b        loc_01E254                                    ; $01E24C

loc_01E24E:
        movea.l      ActorTarget(a0), a1                           ; $01E24E
        rts                                                        ; $01E252

loc_01E254:
        movea.l      ActorExitCallback(a0), a1                     ; $01E254
        jmp          (a1)                                          ; $01E258
        ifne *-$1E25A
        fail "ROM end moved"
        endif
