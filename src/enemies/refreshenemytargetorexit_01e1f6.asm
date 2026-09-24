; $01E1F6..$01E235 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Reselects target when (GameTick+ActorLinkId)&7 == 0. Missing target or octagonal distance >= $A00 invokes ActorExitCallback; that callback can restore a map marker. Not called every update state.
        ifne *-$1E1F6
        fail "ROM start moved"
        endif

RefreshEnemyTargetOrExit:
; Reselects target when (GameTick+ActorLinkId)&7 == 0. Missing target or octagonal distance >= $A00 invokes ActorExitCallback; that callback can restore a map marker. Not called every update state.
        move.w       rGameTick(a6), d0                             ; $01E1F6
        add.b        ActorLinkId(a0), d0                           ; $01E1FA
        andi.w       #$7, d0                                       ; $01E1FE
        bne.b        loc_01E20E                                    ; $01E202
        bsr.w        SelectEnemyPlayerTarget                       ; $01E204
        move.l       a1, ActorTarget(a0)                           ; $01E208
        beq.b        loc_01E230                                    ; $01E20C

; Between modulo-8 reselections the cached pointer is used without a live-slot check.
loc_01E20E:
        movea.l      ActorTarget(a0), a1                           ; $01E20E
        move.w       ActorX(a0), d0                                ; $01E212
        move.w       ActorY(a0), d1                                ; $01E216
        sub.w        ActorX(a1), d0                                   ; $01E21A
        sub.w        ActorY(a1), d1                                   ; $01E21E
        jsr          OctagonalDistance.l                           ; $01E222
        cmpi.w       #$a00, d0                                     ; $01E228
        bcc.b        loc_01E230                                    ; $01E22C
        rts                                                        ; $01E22E

loc_01E230:
        movea.l      ActorExitCallback(a0), a1                     ; $01E230
        jmp          (a1)                                          ; $01E234
        ifne *-$1E236
        fail "ROM end moved"
        endif
