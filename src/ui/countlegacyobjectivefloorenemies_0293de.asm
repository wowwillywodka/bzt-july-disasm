; $0293DE..$029495 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Legacy count scans 1024 bytes at VisibleMapWindow + LegacyObjectiveFloor*1024, not the variable-size floor buffer. It sets a message timer, not SceneExitRequested.
        ifne *-$293DE
        fail "ROM start moved"
        endif

CountLegacyObjectiveFloorEnemies:
; Legacy count scans 1024 bytes at VisibleMapWindow + LegacyObjectiveFloor*1024, not the variable-size floor buffer. It sets a message timer, not SceneExitRequested.
        tst.w        rFloorClearMessageTimer(a6)                   ; $0293DE
        beq.b        loc_0293E6                                    ; $0293E2
        rts                                                        ; $0293E4

loc_0293E6:
        movem.l      d0/d5-d7/a0-a1, -(a7)                         ; $0293E6
        move.w       rLegacyObjectiveFloor(a6), d5                 ; $0293EA
        clr.w        d6                                            ; $0293EE
        move.w       rActiveActorCount(a6), d7                     ; $0293F0
        beq.b        loc_029420                                    ; $0293F4
        subq.w       #$1, d7                                       ; $0293F6
        movea.l      rActiveActorHead(a6), a0                      ; $0293F8

loc_0293FC:
        cmp.b        $36(a0), d5                                   ; $0293FC
        bne.b        loc_029412                                    ; $029400
        move.w       $4(a0), d0                                    ; $029402
        andi.w       #$14, d0                                      ; $029406
        cmpi.w       #$14, d0                                      ; $02940A
        bne.b        loc_029412                                    ; $02940E
        addq.w       #$1, d6                                       ; $029410

loc_029412:
        movea.l      (a0), a0                                      ; $029412
        cmpa.l       #$0, a0                                       ; $029414
        beq.b        loc_029420                                    ; $02941A
        dbra         d7, loc_0293FC                                ; $02941C

loc_029420:
        move.w       rLegacyObjectiveFloor(a6), d0                 ; $029420
        lsl.w        #$8, d0                                       ; $029424
        lsl.w        #$2, d0                                       ; $029426
        lea.l        rVisibleMapWindow(a6), a0                     ; $029428
        adda.w       d0, a0                                        ; $02942C
        lea.l        rCellTypeByIndex(a6), a1                      ; $02942E
        move.w       #$3ff, d7                                     ; $029432
        clr.w        d0                                            ; $029436

loc_029438:
        move.b       (a0)+, d0                                     ; $029438
        move.b       (a1, d0.w), d0                                ; $02943A
        cmpi.b       #$29, d0                                      ; $02943E
        bcs.b        loc_029458                                    ; $029442
        cmpi.b       #$6b, d0                                      ; $029444
        bhi.b        loc_029458                                    ; $029448
        cmpi.b       #$2b, d0                                      ; $02944A
        bls.b        loc_029456                                    ; $02944E
        cmpi.b       #$65, d0                                      ; $029450
        bcs.b        loc_029458                                    ; $029454

loc_029456:
        addq.w       #$1, d6                                       ; $029456

loc_029458:
        dbra         d7, loc_029438                                ; $029458
        cmpi.w       #$63, d6                                      ; $02945C
        bls.b        loc_029466                                    ; $029460
        move.w       #$63, d6                                      ; $029462

loc_029466:
        cmp.w        rLastDrawnEnemyCount(a6), d6                  ; $029466
        beq.b        loc_029472                                    ; $02946A
        jsr          UiRoutine_0209FE.l                            ; $02946C

loc_029472:
        move.w       d6, rRemainingEnemyCount(a6)                  ; $029472
        beq.b        loc_02947E                                    ; $029476
        movem.l      (a7)+, d0/d5-d7/a0-a1                         ; $029478
        rts                                                        ; $02947C

loc_02947E:
        move.w       #$e1, rFloorClearMessageTimer(a6)             ; $02947E
        movea.l      #StatusMessageZeroEnemiesRemaining, a0        ; $029484
        jsr          QueueStatusMessage.l                          ; $02948A
        movem.l      (a7)+, d0/d5-d7/a0-a1                         ; $029490
        rts                                                        ; $029494
        ifne *-$29496
        fail "ROM end moved"
        endif
