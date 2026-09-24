; $01CC14..$01CC85 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Finish at next XY, not last committed position: disabled surface test returns0, damage ONE panel, clear motion/shake words, RemoveActor locally. No ordinary explosion, no link removal command here.
        ifne *-$1CC14
        fail "ROM start moved"
        endif

FinishSlowProjectileAtNextPoint:
; Finish at next XY, not last committed position: disabled surface test returns0, damage ONE panel, clear motion/shake words, RemoveActor locally. No ordinary explosion, no link removal command here.
        move.w       ActorX(a0), d0                                ; $01CC14
        add.w        ActorMotionX(a0), d0                          ; $01CC18
; Original next-X >=$1F00 detour reads a raw cell at CURRENT XY then discards it; next point is recomputed. This is not a bounds clamp.
        cmpi.w       #$1f00, d0                                    ; $01CC1C
        bcs.b        loc_01CC3E                                    ; $01CC20
        bsr.w        GetVisibleMapBase                             ; $01CC22
        move.w       ActorX(a0), d0                                ; $01CC26
        asr.w        #$8, d0                                       ; $01CC2A
        adda.w       d0, a1                                        ; $01CC2C
        move.w       ActorY(a0), d0                                ; $01CC2E
        clr.b        d0                                            ; $01CC32
        asr.w        #$3, d0                                       ; $01CC34
        adda.w       d0, a1                                        ; $01CC36
        clr.w        d0                                            ; $01CC38
        move.b       (a1, d0.w), d0                                ; $01CC3A

loc_01CC3E:
        bsr.w        GetVisibleMapBase                             ; $01CC3E
        move.w       ActorX(a0), d0                                ; $01CC42
        add.w        ActorMotionX(a0), d0                          ; $01CC46
        move.w       ActorY(a0), d1                                ; $01CC4A
        add.w        ActorMotionY(a0), d1                          ; $01CC4E
        bsr.w        DisabledActorProjectileSurfaceTest            ; $01CC52
        bne.w        RemoveActorAndSendLink                        ; $01CC56
        movem.l      d0-d1/a0, -(a7)                               ; $01CC5A
        jsr          DamagePanelCellAtPoint.l                      ; $01CC5E
        movem.l      (a7)+, d0-d1/a0                               ; $01CC64
        clr.w        ActorMotionX(a0)                              ; $01CC68
        clr.w        ActorMotionY(a0)                              ; $01CC6C
        clr.w        rStatusSoundScriptActive(a6)                                    ; $01CC70
        clr.w        rSoundEffectCooldown(a6)                                    ; $01CC74
        bra.w        RemoveActor                                   ; $01CC78

loc_01CC7C:
        move.w       d0, ActorX(a0)                                ; $01CC7C
        move.w       d1, ActorY(a0)                                ; $01CC80
        rts                                                        ; $01CC84
        ifne *-$1CC86
        fail "ROM end moved"
        endif
