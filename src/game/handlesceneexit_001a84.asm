; $001A84..$001B1D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Shared scene-exit path. DemoMode 3 returns D7=2; other nonzero modes return D7=1. Normal mode advances GeometryEpisode, resets after episode index 3.
        ifne *-$1A84
        fail "ROM start moved"
        endif

HandleSceneExit:
; Shared scene-exit path. DemoMode 3 returns D7=2; other nonzero modes return D7=1. Normal mode advances GeometryEpisode, resets after episode index 3.
        bsr.w        VideoRoutine_001CBA                           ; $001A84
        cmpi.w       #$3, rDemoMode(a6)                            ; $001A88
        beq.w        loc_001AFA                                    ; $001A8E
        tst.w        rDemoMode(a6)                                 ; $001A92
        bne.w        loc_001B0C                                    ; $001A96
        movem.l      d0-d7/a0-a5, -(a7)                            ; $001A9A
        lea.l        -$5584(a6), a0                                ; $001A9E
; Calls $02954E, an immediate RTS. This does not display a completed mission summary.
        jsr          DisabledSceneExitSummary.l                    ; $001AA2
        movem.l      (a7)+, d0-d7/a0-a5                            ; $001AA8
        jsr          PlayPendingSequence.l                         ; $001AAC
        move.w       rGeometryEpisode(a6), d0                      ; $001AB2
        addq.w       #$1, d0                                       ; $001AB6
        cmpi.w       #$4, d0                                       ; $001AB8
        beq.b        loc_001AF6                                    ; $001ABC
        move.w       d0, rGeometryEpisode(a6)                      ; $001ABE
        bset.b       #$0, rPauseFlags(a6)                          ; $001AC2
        jsr          RunInventoryStatusLoop.l                      ; $001AC8
        clr.w        rSceneExitRequested(a6)                       ; $001ACE
        clr.w        -$71ca(a6)                                    ; $001AD2
        clr.w        -$71c8(a6)                                    ; $001AD6
        clr.l        rAmmoUsageFixedCounter(a6)                    ; $001ADA
        clr.w        -$71bc(a6)                                    ; $001ADE
; Inventory modal returns D0=$0D via ResumeGemsSequences, not the next episode. LSL.W #4 writes LevelSelection=$D0: floor 0 but legacy episode selector 1. GeometryEpisode remains independent.
        lsl.w        #$4, d0                                       ; $001AE2
        move.b       d0, rLevelSelection(a6)                       ; $001AE4
        move.b       -$720d(a6), rSavedHealth(a6)                  ; $001AE8
        bsr.w        SaveInventoryForSceneRestart                  ; $001AEE
        bra.w        LoadSceneAndRunGameplay                       ; $001AF2

loc_001AF6:
        bra.w        InitializeHardware                            ; $001AF6

loc_001AFA:
        jsr          PlayPendingSequence.l                         ; $001AFA
        jsr          ExitLocalActors.l                             ; $001B00
        move.w       #$2, d7                                       ; $001B06
        rts                                                        ; $001B0A

loc_001B0C:
        jsr          PlayPendingSequence.l                         ; $001B0C
        jsr          ExitLocalActors.l                             ; $001B12
        move.w       #$1, d7                                       ; $001B18
        rts                                                        ; $001B1C
        ifne *-$1B1E
        fail "ROM end moved"
        endif
