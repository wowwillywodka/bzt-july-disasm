; $014428..$0145A7 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Retained weapon04: immediate target at distance<300 gets hit parameter1000; additionally clears mapped cell type18 and spawns fire effect. Normal item remap never selects04.
        ifne *-$14428
        fail "ROM start moved"
        endif

FireRetainedCloseRangeWeapon04:
; Retained weapon04: immediate target at distance<300 gets hit parameter1000; additionally clears mapped cell type18 and spawns fire effect. Normal item remap never selects04.
        tst.w        rWeaponActionPhase(a6)                        ; $014428
        bne.w        loc_0144E0                                    ; $01442C
        tst.w        rWeaponLoweringOffset(a6)                     ; $014430
        bne.w        loc_0144E0                                    ; $014434
        move.w       #$38, d0                                      ; $014438
        jsr          SoundRoutine_00DF84.l                         ; $01443C
        move.w       #$1, rWeaponActionPhase(a6)                   ; $014442
        bsr.w        ConsumeSelectedItemAndUpdateHud               ; $014448
        move.w       #$8, d1                                       ; $01444C
        move.w       -$71b0(a6), d2                                ; $014450
        addi.w       #$40, d2                                      ; $014454
        jsr          SelectPlayerWeaponAimTarget.l                 ; $014458
        cmpa.l       #$0, a1                                       ; $01445E
        beq.b        loc_01449C                                    ; $014464
        movea.l      a1, a0                                        ; $014466
        move.w       $24(a0), d0                                   ; $014468
        sub.w        rPlayerX(a6), d0                              ; $01446C
        move.w       $26(a0), d1                                   ; $014470
        sub.w        rPlayerY(a6), d1                              ; $014474
        bsr.w        OctagonalDistance                             ; $014478
        cmpi.w       #$12c, d0                                     ; $01447C
        bcc.b        loc_01449C                                    ; $014480
        move.w       #$3e8, d0                                     ; $014482
        move.w       rPlayerX(a6), d3                              ; $014486
        move.w       rPlayerY(a6), d4                              ; $01448A
        sub.w        $24(a0), d3                                   ; $01448E
        sub.w        $26(a0), d4                                   ; $014492
        movea.l      ActorHitCallback(a0), a1                      ; $014496
        jsr          (a1)                                          ; $01449A

loc_01449C:
        movea.l      rPlayerCellPointer(a6), a0                    ; $01449C
        lea.l        rCellTypeByIndex(a6), a5                      ; $0144A0
        clr.w        d3                                            ; $0144A4
        move.b       (a0), d3                                      ; $0144A6
        move.b       (a5, d3.w), d3                                ; $0144A8
        cmpi.b       #$18, d3                                      ; $0144AC
        beq.b        loc_0144E2                                    ; $0144B0
        movea.l      rVisibleMapBasePointer(a6), a0                ; $0144B2
        move.w       -$71f2(a6), d0                                ; $0144B6
        asr.w        #$1, d0                                       ; $0144BA
        add.w        rPlayerX(a6), d0                              ; $0144BC
        asr.w        #$8, d0                                       ; $0144C0
        adda.w       d0, a0                                        ; $0144C2
        move.w       -$71f0(a6), d0                                ; $0144C4
        asr.w        #$1, d0                                       ; $0144C8
        add.w        rPlayerY(a6), d0                              ; $0144CA
        asr.w        #$8, d0                                       ; $0144CE
        asl.w        #$5, d0                                       ; $0144D0
        adda.w       d0, a0                                        ; $0144D2
        move.b       (a0), d3                                      ; $0144D4
        move.b       (a5, d3.w), d3                                ; $0144D6
        cmpi.b       #$18, d3                                      ; $0144DA
        beq.b        loc_0144E2                                    ; $0144DE

loc_0144E0:
        rts                                                        ; $0144E0

loc_0144E2:
        cmpa.l       #$ffa5fa, a0                                  ; $0144E2
        bcs.b        loc_0144F2                                    ; $0144E8
        cmpa.l       #$ffe5fa, a0                                  ; $0144EA
        bcs.b        loc_0144F8                                    ; $0144F0

loc_0144F2:
        movea.l      #$ffa9fa, a0                                  ; $0144F2

loc_0144F8:
        clr.b        (a0)                                          ; $0144F8
        jsr          CommitMapCellAndSendLink.l                    ; $0144FA
        suba.l       rVisibleMapBasePointer(a6), a0                ; $014500
        move.l       a0, d0                                        ; $014504
        move.w       d0, d1                                        ; $014506
        andi.w       #$1f, d0                                      ; $014508
        asr.w        #$5, d1                                       ; $01450C
        lsl.w        #$8, d0                                       ; $01450E
        lsl.w        #$8, d1                                       ; $014510
        addi.w       #$80, d0                                      ; $014512
        addi.w       #$80, d1                                      ; $014516
        movem.w      d0-d1, -(a7)                                  ; $01451A
        bsr.w        AllocateActor                                 ; $01451E
        movem.w      (a7)+, d0-d1                                  ; $014522
        cmpa.l       #$0, a0                                       ; $014526
        beq.b        loc_0144E0                                    ; $01452C
        clr.b        $23(a0)                                       ; $01452E
        clr.b        $22(a0)                                       ; $014532
        move.l       #$1cd78, ActorUpdateCallback(a0)              ; $014536
        move.l       #$1cdb0, ActorDrawCallback(a0)                ; $01453E
        move.w       d0, $24(a0)                                   ; $014546
        move.w       d1, $26(a0)                                   ; $01454A
        move.w       #$ffe0, $28(a0)                               ; $01454E
        tst.w        rLinkRole(a6)                                 ; $014554
        beq.b        loc_0144E0                                    ; $014558
        move.l       #RemoveActorAndSendLink, ActorExitCallback(a0) ; $01455A
        move.l       #$1ee78, ActorLinkCallback(a0)                ; $014562
        lea.l        -$6fdc(a6), a1                                ; $01456A
        move.b       #$4, (a1)+                                    ; $01456E
        move.b       $42(a0), (a1)+                                ; $014572
        move.w       $24(a0), (a1)+                                ; $014576
        move.w       $26(a0), (a1)+                                ; $01457A
        move.b       $29(a0), (a1)+                                ; $01457E
        move.b       $5(a0), d0                                    ; $014582
        ori.w        #$20, d0                                      ; $014586
        move.b       d0, (a1)+                                     ; $01458A
        move.b       $36(a0), (a1)+                                ; $01458C
        move.b       #$5, (a1)+                                    ; $014590
        move.w       $2e(a0), (a1)+                                ; $014594
        move.w       $30(a0), (a1)+                                ; $014598
        lea.l        -$6fdc(a6), a0                                ; $01459C
        jsr          QueueLinkCommand.l                            ; $0145A0
        rts                                                        ; $0145A6
        ifne *-$145A8
        fail "ROM end moved"
        endif
