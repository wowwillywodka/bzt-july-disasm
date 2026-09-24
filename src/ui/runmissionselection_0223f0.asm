; $0223F0..$0225EB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Главный цикл выбора уровня/брифинга перед стартом миссии: ставит музыку 0x41, опрашивает пад, рисует экран выбора, по нажатию запускает загрузку уровня (jsr 0x20088) и очищает VRAM/CRAM при переходе
        ifne *-$223F0
        fail "ROM start moved"
        endif

RunMissionSelection:
        cmpi.w       #$41, rCurrentSoundSequenceId(a6)                              ; $0223F0
        beq.b        loc_022402                                    ; $0223F6
        move.w       #$41, d0                                      ; $0223F8
        jsr          StoreCurrentSoundSequenceAndPlayEvent.l                                  ; $0223FC

loc_022402:
        jsr          RunSelectionMenu.l                            ; $022402
        cmpi.w       #$2, rTitleScrollState(a6)                               ; $022408
        beq.b        loc_022452                                    ; $02240E
        move.w       rGameOptions(a6), rLinkRole(a6)               ; $022410
        tst.w        rDemoMode(a6)                                 ; $022416
        bne.w        loc_022448                                    ; $02241A
        clr.b        rRequestedStartSelection(a6)                  ; $02241E
        lea.l        rPasswordSavedText(a6), a0                                ; $022422
        jsr          ValidatePasswordAndCheats.l                   ; $022426
        cmpi.w       #$ffff, d7                                    ; $02242C
        beq.b        loc_022438                                    ; $022430
        move.b       rLevelSelection(a6), rRequestedStartSelection(a6) ; $022432

loc_022438:
        jsr          PlayPendingSequence.l                         ; $022438
        tst.w        rLinkRole(a6)                                 ; $02243E
        bne.w        loc_02245A                                    ; $022442
        rts                                                        ; $022446

loc_022448:
        clr.b        rRequestedStartSelection(a6)                  ; $022448
        clr.w        rLinkRole(a6)                                 ; $02244C
        rts                                                        ; $022450

loc_022452:
        jsr          RunOptionsScreen.l                                  ; $022452
        bra.b        RunMissionSelection                           ; $022458

loc_02245A:
        move.l       #$40000000, VDP_CONTROL.l                     ; $02245A
        moveq        #$0, d6                                       ; $022464
        movea.l      #VDP_DATA, a4                                 ; $022466
        move.l       d6, (a4)                                      ; $02246C
        move.l       d6, (a4)                                      ; $02246E
        move.l       d6, (a4)                                      ; $022470
        move.l       d6, (a4)                                      ; $022472
        move.l       d6, (a4)                                      ; $022474
        move.l       d6, (a4)                                      ; $022476
        move.l       d6, (a4)                                      ; $022478
        move.l       d6, (a4)                                      ; $02247A
        lea.l        CommonInterfaceCompressedTiles.l, a3          ; $02247C
        move.w       #$10, d0                                      ; $022482
        jsr          DecompressBytePairToVramLong.l                ; $022486
        jsr          InitializeVdpRegisters.l                      ; $02248C
        moveq        #$0, d6                                       ; $022492
        movea.l      #VDP_DATA, a4                                 ; $022494
        move.l       #$60000003, VDP_CONTROL.l                     ; $02249A
        move.w       #$7ff, d7                                     ; $0224A4

loc_0224A8:
        move.l       d6, (a4)                                      ; $0224A8
        dbra         d7, loc_0224A8                                ; $0224AA
        move.l       #$40000003, VDP_CONTROL.l                     ; $0224AE
        move.w       #$7ff, d7                                     ; $0224B8

loc_0224BC:
        move.l       d6, (a4)                                      ; $0224BC
        dbra         d7, loc_0224BC                                ; $0224BE
        lea.l        rVramDmaCommandQueue(a6), a0                                ; $0224C2
        move.l       #$ffffffff, (a0)                              ; $0224C6
        move.l       a0, rDmaQueueTail(a6)                         ; $0224CC
        lea.l        WaitingForPartnerMenuText(pc), a0             ; $0224D0
        move.w       #$e500, d0                                    ; $0224D4
        bsr.w        PrintHudString                                ; $0224D8
        lea.l        Data_022611(pc), a0                           ; $0224DC
        move.w       #$e880, d0                                    ; $0224E0
        bsr.w        PrintHudString                                ; $0224E4
        move.l       #$c0000000, VDP_CONTROL.l                     ; $0224E8
        movea.l      #InterfacePalettes, a0                        ; $0224F2
        movea.l      #VDP_DATA, a4                                 ; $0224F8
        move.l       (a0)+, (a4)                                   ; $0224FE
        move.l       (a0)+, (a4)                                   ; $022500
        move.l       (a0)+, (a4)                                   ; $022502
        move.l       (a0)+, (a4)                                   ; $022504
        move.l       (a0)+, (a4)                                   ; $022506
        move.l       (a0)+, (a4)                                   ; $022508
        move.l       (a0)+, (a4)                                   ; $02250A
        move.l       (a0)+, (a4)                                   ; $02250C
        jsr          ResetLinkReceiverPortAndQueues(pc)                       ; $02250E
        lea.l        rSharedScratchBuffer(a6), a0                                ; $022512
        move.b       #$1, (a0)                                     ; $022516
        move.b       rRequestedStartSelection(a6), $1(a0)          ; $02251A
        jsr          QueueLinkCommand(pc)                          ; $022520
        move.w       rLinkRetryDelay(a6), -(a7)                             ; $022524
        move.w       rLinkTransferModeShadow(a6), -(a7)                             ; $022528
        clr.w        rLinkRetryDelay(a6)                                    ; $02252C
        move.w       #$2000, rLinkTransferModeShadow(a6)                            ; $022530
        jsr          TransmitLinkCommands(pc)                      ; $022536
        move.w       (a7)+, rLinkTransferModeShadow(a6)                             ; $02253A
        move.w       (a7)+, rLinkRetryDelay(a6)                             ; $02253E

loc_022542:
        lea.l        rSharedScratchBuffer(a6), a0                                ; $022542
        jsr          DequeueLinkCommand(pc)                       ; $022546
        beq.b        loc_022556                                    ; $02254A
        cmpi.b       #$2, (a0)                                     ; $02254C
        bne.b        loc_022542                                    ; $022550
        bra.w        loc_0225A0                                    ; $022552

loc_022556:
        lea.l        rSharedScratchBuffer(a6), a0                                ; $022556
        move.b       #$2, (a0)                                     ; $02255A
        move.b       rRequestedStartSelection(a6), $1(a0)          ; $02255E
        jsr          QueueLinkCommand(pc)                          ; $022564
        jsr          ConfigureLinkInitiatorPort(pc)                       ; $022568

loc_02256C:
        jsr          WaitForVBlank.l                               ; $02256C
        jsr          ReadController.l                              ; $022572
        btst.b       #$7, rControllerState(a6)                     ; $022578
        beq.b        loc_02258A                                    ; $02257E
        btst.b       #$7, rPreviousControllerState(a6)             ; $022580
        beq.w        loc_0225E0                                    ; $022586

loc_02258A:
        lea.l        rSharedScratchBuffer(a6), a0                                ; $02258A
        jsr          DequeueLinkCommand(pc)                       ; $02258E
        beq.b        loc_02259E                                    ; $022592
        cmpi.b       #$1, (a0)                                     ; $022594
        beq.w        loc_0225CA                                    ; $022598
        bra.b        loc_02258A                                    ; $02259C

loc_02259E:
        bra.b        loc_02256C                                    ; $02259E

loc_0225A0:
        move.b       $1(a0), d0                                    ; $0225A0
        cmp.b        rRequestedStartSelection(a6), d0              ; $0225A4
        bls.b        loc_0225AE                                    ; $0225A8
        move.b       d0, rRequestedStartSelection(a6)              ; $0225AA

loc_0225AE:
        move.w       #$1, rLinkRole(a6)                            ; $0225AE
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0225B4
        move.b       #$1, (a0)                                     ; $0225B8
        move.b       rRequestedStartSelection(a6), $1(a0)          ; $0225BC
        jsr          QueueLinkCommand(pc)                          ; $0225C2
        jmp          TransmitLinkCommands(pc)                      ; $0225C6

loc_0225CA:
        move.b       $1(a0), d0                                    ; $0225CA
        cmp.b        rRequestedStartSelection(a6), d0              ; $0225CE
        bls.b        loc_0225D8                                    ; $0225D2
        move.b       d0, rRequestedStartSelection(a6)              ; $0225D4

loc_0225D8:
        move.w       #$2, rLinkRole(a6)                            ; $0225D8
        rts                                                        ; $0225DE

loc_0225E0:
        jsr          ResetLinkReceiverPortAndQueues(pc)                       ; $0225E0
        clr.w        rLinkRole(a6)                                 ; $0225E4
        bra.w        RunMissionSelection                           ; $0225E8
        ifne *-$225EC
        fail "ROM end moved"
        endif
