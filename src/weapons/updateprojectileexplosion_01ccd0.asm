; $01CCD0..$01CD1B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Increment effect BYTE. At6 remove (and command05 in link); at2 ApplyExplosionAreaHit. Starting at0 gives one damage event on second update and deletion on sixth. Does not reset weapon byte.
        ifne *-$1CCD0
        fail "ROM start moved"
        endif

UpdateProjectileExplosion:
; Increment effect BYTE. At6 remove (and command05 in link); at2 ApplyExplosionAreaHit. Starting at0 gives one damage event on second update and deletion on sixth. Does not reset weapon byte.
        clr.b        ActorUpdateDelay(a0)                          ; $01CCD0
        addq.b       #$1, ActorEffectCounter(a0)                   ; $01CCD4
        cmpi.b       #$6, ActorEffectCounter(a0)                   ; $01CCD8
        bne.b        ExplosionCheckDamageTick                      ; $01CCDE
        tst.w        rLinkRole(a6)                                 ; $01CCE0
        beq.w        RemoveActor                                   ; $01CCE4
        lea.l        -$6fdc(a6), a1                                ; $01CCE8
        move.b       #$5, (a1)+                                    ; $01CCEC
        move.b       ActorLinkId(a0), (a1)+                        ; $01CCF0
        move.l       a0, -(a7)                                     ; $01CCF4
        lea.l        -$6fdc(a6), a0                                ; $01CCF6
        jsr          QueueLinkCommand.l                            ; $01CCFA
        movea.l      (a7)+, a0                                     ; $01CD00
        bra.w        RemoveActor                                   ; $01CD02

ExplosionCheckDamageTick:
        cmpi.b       #$2, ActorEffectCounter(a0)                   ; $01CD06
        bne.b        loc_01CD1A                                    ; $01CD0C
        move.w       ActorX(a0), d0                                ; $01CD0E
        move.w       ActorY(a0), d1                                ; $01CD12
        bra.w        ApplyExplosionAreaHit                         ; $01CD16

loc_01CD1A:
        rts                                                        ; $01CD1A
        ifne *-$1CD1C
        fail "ROM end moved"
        endif
