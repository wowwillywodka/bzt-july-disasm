; $000DAE..$000E8B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; July flow: Start/options/password/link setup, five-character selection, then scene loading. GeometryEpisode is separate from packed LevelSelection. See docs/GAME_FLOW.md.
        ifne *-$DAE
        fail "ROM start moved"
        endif

RunTitleAndGameFlow:
; July flow: Start/options/password/link setup, five-character selection, then scene loading. GeometryEpisode is separate from packed LevelSelection. See docs/GAME_FLOW.md.
        move.w       rCurrentSoundSequenceId(a6), d0                                ; $000DAE
        cmpi.w       #$2, d0                                       ; $000DB2
        bls.b        loc_000DBE                                    ; $000DB6
        cmpi.w       #$42, d0                                      ; $000DB8
        bne.b        loc_000DC4                                    ; $000DBC

loc_000DBE:
        jsr          PlayPendingSequence.l                         ; $000DBE

loc_000DC4:
        clr.w        rLinkRole(a6)                                 ; $000DC4
        clr.w        rLegacyEpisodeSelection(a6)                   ; $000DC8
        jsr          RunMissionSelection.l                         ; $000DCC
        tst.w        rDemoMode(a6)                                 ; $000DD2
        bne.w        loc_000E2C                                    ; $000DD6
        move.w       #$0, d0                                       ; $000DDA
        tst.b        rRequestedStartSelection(a6)                  ; $000DDE
        beq.b        loc_000DFC                                    ; $000DE2
        move.w       #$1, d0                                       ; $000DE4
        cmpi.b       #$10, rRequestedStartSelection(a6)            ; $000DE8
        beq.b        loc_000DFC                                    ; $000DEE
        move.w       #$2, d0                                       ; $000DF0
        cmpi.b       #$20, rRequestedStartSelection(a6)            ; $000DF4
        bne.b        loc_000E0C                                    ; $000DFA

loc_000DFC:
        movea.l      #ActorNoOp, a1                                ; $000DFC
        jsr          DisabledBriefingEntry.l                       ; $000E02
        bsr.w        InitializeVdpRegisters                        ; $000E08

loc_000E0C:
        bsr.w        InitializeNewGameState                        ; $000E0C
        movea.l      #ActorNoOp, a1                                ; $000E10
        clr.w        rSelectedCharacter(a6)                        ; $000E16
        jsr          RunCharacterSelection.l                       ; $000E1A
        bsr.w        LoadSceneAndRunGameplay                       ; $000E20
        clr.l        rGameClockFrameTicks(a6)                                    ; $000E24
        bra.w        InitializeHardware                            ; $000E28

loc_000E2C:
        move.w       #$3, d0                                       ; $000E2C
        movea.l      #ActorNoOp, a1                                ; $000E30
        jsr          DisabledBriefingEntry.l                       ; $000E36
        move.w       d7, -(a7)                                     ; $000E3C
        bsr.w        InitializeVdpRegisters                        ; $000E3E
        move.w       (a7)+, d7                                     ; $000E42
        bne.w        RunTitleAndGameFlow                           ; $000E44
        move.w       rLegacyEpisodeSelection(a6), -(a7)            ; $000E48
        bsr.w        InitializeNewGameState                        ; $000E4C
        move.w       (a7)+, d0                                     ; $000E50
        lsl.w        #$4, d0                                       ; $000E52
        move.b       d0, rLevelSelection(a6)                       ; $000E54
        jsr          NextRandom(pc)                                ; $000E58
        andi.l       #$400, d2                                     ; $000E5C
        divu.w       #$cd, d2                                      ; $000E62
        move.w       d2, rSelectedCharacter(a6)                    ; $000E66
        move.w       rLinkRole(a6), -(a7)                          ; $000E6A
        clr.w        rLinkRole(a6)                                 ; $000E6E
        jsr          GemsStopAll.l                         ; $000E72
        bsr.w        LoadSceneAndRunGameplay                       ; $000E78
        move.w       (a7)+, rLinkRole(a6)                          ; $000E7C
        cmpi.w       #$1, d7                                       ; $000E80
        beq.w        InitializeHardware                            ; $000E84
        bra.w        RunTitleAndGameFlow                           ; $000E88
        ifne *-$E8C
        fail "ROM end moved"
        endif
