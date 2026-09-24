; $00179E..$001829 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Process remote exit countdown first, then SceneExitRequested, then death. Health <=1 unsigned advances death ticks; 30 ticks retire the character. Exit has priority.
        ifne *-$179E
        fail "ROM start moved"
        endif

CheckSceneExitAndPlayerDeath:
; Process remote exit countdown first, then SceneExitRequested, then death. Health <=1 unsigned advances death ticks; 30 ticks retire the character. Exit has priority.
        tst.w        rRemoteSceneExitDelay(a6)                     ; $00179E
        beq.b        loc_0017B0                                    ; $0017A2
        subq.w       #$1, rRemoteSceneExitDelay(a6)                ; $0017A4
        bne.b        loc_0017B0                                    ; $0017A8
        move.w       #$1, rSceneExitRequested(a6)                  ; $0017AA

loc_0017B0:
        tst.w        rSceneExitRequested(a6)                       ; $0017B0
        bne.w        HandleSceneExit                               ; $0017B4
        cmpi.w       #$1, rPlayerHealth(a6)                        ; $0017B8
        bhi.b        loc_0017F4                                    ; $0017BE
        addq.w       #$1, rPlayerDeathTicks(a6)                    ; $0017C0
        cmpi.w       #$1, rPlayerDeathTicks(a6)                    ; $0017C4
        bne.b        loc_0017F4                                    ; $0017CA
        move.w       #$fff, rPlayerDamageFlashColor(a6)                             ; $0017CC
        tst.w        rLinkRole(a6)                                 ; $0017D2
        beq.b        loc_0017F4                                    ; $0017D6
        lea.l        rSharedScratchBuffer(a6), a1                                ; $0017D8
        move.b       #$12, (a1)+                                   ; $0017DC
        clr.b        (a1)+                                         ; $0017E0
        move.b       #$2a, (a1)+                                   ; $0017E2
        move.b       rCurrentFloorLow(a6), (a1)+                   ; $0017E6
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0017EA
        jsr          QueueLinkCommand.l                            ; $0017EE

loc_0017F4:
        jsr          UpdateMapWindowOrigin.l                       ; $0017F4
        cmpi.w       #$1e, rPlayerDeathTicks(a6)                   ; $0017FA
        bcs.w        RunGameplayIteration                          ; $001800
        move.w       rActiveActorCount(a6), d7                     ; $001804
        beq.b        RetireDeadCharacter                           ; $001808
        subq.w       #$1, d7                                       ; $00180A
        movea.l      rActiveActorHead(a6), a0                      ; $00180C

loc_001810:
; Original uses $4(A6), NOT ActorFlags at $4(A0). The apparent active-actor sweep must not be silently corrected.
        move.w       rFrameBufferWordAtFF8004(a6), d0                                    ; $001810
        andi.w       #$14, d0                                      ; $001814
        cmpi.w       #$14, d0                                      ; $001818
        bne.b        loc_001824                                    ; $00181C
        move.b       #$1, $39(a0)                                  ; $00181E

loc_001824:
        movea.l      (a0), a0                                      ; $001824
        dbra         d7, loc_001810                                ; $001826
        ifne *-$182A
        fail "ROM end moved"
        endif
