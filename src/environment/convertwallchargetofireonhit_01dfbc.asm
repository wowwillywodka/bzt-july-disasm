; $01DFBC..$01E03F | m68k
; Maintained assembly input; no extraction occurs during build.
; Hit callback: replace charge with short fire effect and notify link peers.
        ifne *-$1DFBC
        fail "ROM start moved"
        endif

ConvertWallChargeToFireOnHit:
        move.l       #UpdateWallChargeHitFire, ActorUpdateCallback(a0)              ; $01DFBC
        move.l       #DrawWallChargeHitFire, ActorDrawCallback(a0)                ; $01DFC4
        andi.w       #$ff37, ActorFlags(a0)                        ; $01DFCC
        move.l       #ActorNoOp, ActorExitCallback(a0)             ; $01DFD2
        move.l       #ActorNoOp, ActorHitCallback(a0)              ; $01DFDA
        clr.b        ActorStateCounter(a0)                         ; $01DFE2
        move.w       #$10, ActorZ(a0)                              ; $01DFE6
        clr.w        ActorVelocityZ(a0)                            ; $01DFEC
        clr.w        rStatusSoundScriptActive(a6)                                    ; $01DFF0
        clr.w        rSoundEffectCooldown(a6)                                    ; $01DFF4
        move.l       a0, -(a7)                                     ; $01DFF8
        move.w       #$18, d0                                      ; $01DFFA
        jsr          RouteSoundEventByActorFloor.l                         ; $01DFFE
        movea.l      (a7)+, a0                                     ; $01E004
        move.w       #$1e, rSoundEffectCooldown(a6)                              ; $01E006
        tst.w        rLinkRole(a6)                                 ; $01E00C
        beq.b        loc_01E03E                                    ; $01E010
        move.l       #QueueActorLinkCommand10StateCounter08, ActorLinkCallback(a0)                ; $01E012
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01E01A
        move.b       #$12, (a1)+                                   ; $01E01E
        move.b       ActorLinkId(a0), (a1)+                        ; $01E022
        move.w       ActorFlags(a0), d0                            ; $01E026
        ori.w        #$20, d0                                      ; $01E02A
        move.b       d0, (a1)+                                     ; $01E02E
        move.b       ActorFloor(a0), (a1)+                         ; $01E030
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01E034
        jmp          QueueLinkCommand.l                            ; $01E038

loc_01E03E:
        rts                                                        ; $01E03E
        ifne *-$1E040
        fail "ROM end moved"
        endif
