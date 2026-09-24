; $01CD78..$01CE03 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$1CD78
        fail "ROM start moved"
        endif
        clr.b        ActorUpdateDelay(a0)                          ; $01CD78
        addq.b       #$1, ActorEffectCounter(a0)                   ; $01CD7C
        cmpi.b       #$10, ActorEffectCounter(a0)                  ; $01CD80
        bne.b        loc_01CDAE                                    ; $01CD86
        tst.w        rLinkRole(a6)                                 ; $01CD88
        beq.w        RemoveActor                                   ; $01CD8C
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01CD90
        move.b       #$5, (a1)+                                    ; $01CD94
        move.b       ActorLinkId(a0), (a1)+                        ; $01CD98
        move.l       a0, -(a7)                                     ; $01CD9C
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01CD9E
        jsr          QueueLinkCommand.l                            ; $01CDA2
        movea.l      (a7)+, a0                                     ; $01CDA8
        bra.w        RemoveActor                                   ; $01CDAA

loc_01CDAE:
        rts                                                        ; $01CDAE
        move.w       d5, rSoftwareSpriteProjectionScale(a6)                                ; $01CDB0
        move.w       d5, d2                                        ; $01CDB4
        move.w       rPlayerViewOffsetZ(a6), d3                                ; $01CDB6
        sub.w        rTransitHeightOffset(a6), d3                                ; $01CDBA
        addi.w       #$20, d3                                      ; $01CDBE
        muls.w       d3, d2                                        ; $01CDC2
        asr.l        #$6, d2                                       ; $01CDC4
        addi.w       #$28, d2                                      ; $01CDC6
        movea.l      rZoneObjectTiles(a6), a1                      ; $01CDCA
        move.w       rGameTick(a6), d0                             ; $01CDCE
        andi.w       #$1, d0                                       ; $01CDD2
        move.w       d0, rSoftwareSpriteMirrorFlag(a6)                                ; $01CDD6
        clr.w        d0                                            ; $01CDDA
        move.b       ActorEffectCounter(a0), d0                    ; $01CDDC
        neg.w        d0                                            ; $01CDE0
        addi.w       #$10, d0                                      ; $01CDE2
        muls.w       d0, d5                                        ; $01CDE6
        asr.l        #$4, d5                                       ; $01CDE8
        move.w       d5, d0                                        ; $01CDEA
        sub.w        d5, d2                                        ; $01CDEC
        move.w       d0, d4                                        ; $01CDEE
        asr.w        #$1, d4                                       ; $01CDF0
        move.w       d4, d3                                        ; $01CDF2
        asr.w        #$1, d3                                       ; $01CDF4
        sub.w        d3, d1                                        ; $01CDF6
        move.l       a0, -(a7)                                     ; $01CDF8
        jsr          ScaleAndDrawSoftwareSpriteTile.l              ; $01CDFA
        movea.l      (a7)+, a0                                     ; $01CE00
        rts                                                        ; $01CE02
        ifne *-$1CE04
        fail "ROM end moved"
        endif
