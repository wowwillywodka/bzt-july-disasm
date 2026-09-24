; $0203A2..$02049D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Queue per-actor link callbacks for local slots, then queue player command $0C.
; Runs after UpdateActors and before world rendering when rLinkRole is nonzero.
        ifne *-$203A2
        fail "ROM start moved"
        endif

QueueLocalActorAndPlayerLinkState:
        move.w       rActiveActorCount(a6), d7                     ; $0203A2
        beq.w        loc_0203CE                                    ; $0203A6
        subq.w       #$1, d7                                       ; $0203AA
        movea.l      rActiveActorHead(a6), a0                      ; $0203AC

loc_0203B0:
; Unlike UpdateActors, this pass does not save ActorNext around callbacks.
; Link callbacks therefore must leave the active-list chain intact.
        move.w       ActorFlags(a0), d1                            ; $0203B0
        andi.w       #$20, d1                                      ; $0203B4
        bne.b        loc_0203C8                                    ; $0203B8
        movea.l      ActorLinkCallback(a0), a1                     ; $0203BA
        movem.l      d7/a0, -(a7)                                  ; $0203BE
        jsr          (a1)                                          ; $0203C2
        movem.l      (a7)+, d7/a0                                  ; $0203C4

loc_0203C8:
        movea.l      (a0), a0                                      ; $0203C8
        dbra         d7, loc_0203B0                                ; $0203CA

loc_0203CE:
; Player state is emitted even when no actors are active.
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0203CE
        move.b       #$c, (a0)+                                    ; $0203D2
        clr.b        (a0)+                                         ; $0203D6
        move.w       rPlayerX(a6), (a0)+                           ; $0203D8
        move.w       rPlayerY(a6), (a0)+                           ; $0203DC
        move.w       rPlayerFacingVectorX(a6), (a0)+                             ; $0203E0
        move.w       rPlayerFacingVectorY(a6), (a0)+                             ; $0203E4
        move.w       #$fb, d1                                      ; $0203E8
        move.w       rPlayerViewOffsetZ(a6), d0                                ; $0203EC
        cmpi.w       #$4, d0                                       ; $0203F0
        bgt.b        loc_020404                                    ; $0203F4
        cmpi.w       #$ffff, d0                                    ; $0203F6
        bge.b        loc_020408                                    ; $0203FA
        asr.w        #$3, d0                                       ; $0203FC
        move.w       #$3b, d1                                      ; $0203FE
        bra.b        loc_020408                                    ; $020402

loc_020404:
        move.w       #$f3, d1                                      ; $020404

loc_020408:
        tst.w        d0                                            ; $020408
        bmi.b        loc_02040E                                    ; $02040A
        asr.w        #$1, d0                                       ; $02040C

loc_02040E:
        sub.w        rTransitHeightOffset(a6), d0                                ; $02040E
        subi.b       #$20, d0                                      ; $020412
        move.b       d0, (a0)+                                     ; $020416
        move.b       d1, (a0)+                                     ; $020418
        move.b       rPlayerForwardSpeedLow(a6), (a0)+                             ; $02041A
        cmpi.w       #$1, rTransitDirectionState(a6)                               ; $02041E
        beq.w        loc_020486                                    ; $020424
        cmpi.w       #$ffff, rTransitDirectionState(a6)                            ; $020428
        beq.w        loc_020486                                    ; $02042E
        tst.w        rPlayerDeathTicks(a6)                         ; $020432
        bne.b        loc_020484                                    ; $020436
        move.w       rPlayerHitImpulseX(a6), d0                                ; $020438
        move.w       rPlayerHitImpulseY(a6), d1                                ; $02043C
        jsr          OctagonalDistance.l                           ; $020440
        cmpi.w       #$a, d0                                       ; $020446
        bhi.b        loc_020482                                    ; $02044A
        cmpi.w       #$fffc, rPlayerViewOffsetZ(a6)                            ; $02044C
        bge.b        loc_020462                                    ; $020452
        cmpi.w       #$fff4, rPlayerViewOffsetZ(a6)                            ; $020454
        bge.w        loc_02049C                                    ; $02045A
        bra.w        loc_020492                                    ; $02045E

loc_020462:
        tst.b        rCurrentWeaponId(a6)                          ; $020462
        beq.b        loc_020472                                    ; $020466
        cmpi.w       #$2, rWeaponActionPhase(a6)                   ; $020468
        bne.b        loc_02048A                                    ; $02046E
        bra.b        loc_02048A                                    ; $020470

loc_020472:
        tst.w        rWeaponActionPhase(a6)                        ; $020472
        beq.b        loc_02048A                                    ; $020476
        cmpi.w       #$4, rWeaponActionPhase(a6)                   ; $020478
        bhi.b        loc_02048A                                    ; $02047E
        bra.b        loc_02048A                                    ; $020480

loc_020482:
        bra.b        loc_02048A                                    ; $020482

loc_020484:
        bra.b        loc_02048A                                    ; $020484

loc_020486:
; Command $0C is 14 bytes. This is the only write of byte 13 in this producer;
; on other paths QueueLinkCommand sends that byte from prior scratch contents.
        move.b       #$24, (a0)                                    ; $020486

loc_02048A:
        lea.l        rSharedScratchBuffer(a6), a0                                ; $02048A
        jmp          QueueLinkCommand(pc)                          ; $02048E

loc_020492:
        cmpi.w       #$2, rWeaponActionPhase(a6)                   ; $020492
        bne.b        loc_02048A                                    ; $020498
        bra.b        loc_02048A                                    ; $02049A

loc_02049C:
        bra.b        loc_02048A                                    ; $02049C
        ifne *-$2049E
        fail "ROM end moved"
        endif
