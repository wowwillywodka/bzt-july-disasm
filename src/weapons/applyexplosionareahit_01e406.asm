; $01E406..$01E4F9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Spawn selector7x7 before taking active-list count. Same-floor actors, one sampled LOS, distance<$400 ->hit callback; no owner/flags/death filter. Player separately uses visible-map ray and character-ID1 doubles distance. See docs/ENEMY_PROJECTILES.md.
        ifne *-$1E406
        fail "ROM start moved"
        endif

ApplyExplosionAreaHit:
; Spawn selector7x7 before taking active-list count. Same-floor actors, one sampled LOS, distance<$400 ->hit callback; no owner/flags/death filter. Player separately uses visible-map ray and character-ID1 doubles distance. See docs/ENEMY_PROJECTILES.md.
        clr.w        d5                                            ; $01E406
        move.b       ActorFloor(a0), d5                            ; $01E408
        movem.l      d0-d1/d5/a0, -(a7)                            ; $01E40C
        bsr.w        GetVisibleMapBase                             ; $01E410
        movea.l      a1, a0                                        ; $01E414
        asr.w        #$8, d0                                       ; $01E416
        adda.w       d0, a0                                        ; $01E418
        clr.b        d1                                            ; $01E41A
        asr.w        #$3, d1                                       ; $01E41C
        adda.w       d1, a0                                        ; $01E41E
        clr.w        d3                                            ; $01E420
        lea.l        rCellTypeByIndex(a6), a5                      ; $01E422
        movea.l      #ActorSpawnCellSelectors, a4                  ; $01E426
        move.w       rCurrentFloor(a6), -(a7)                      ; $01E42C
        move.w       d5, rCurrentFloor(a6)                         ; $01E430
; Scan pointer from explosion XY but selector uses GLOBAL player XY for bounds/coordinates; CurrentFloor temporarily equals explosion floor. New spawned actors can join this same blast scan.
        jsr          SpawnActorsInSevenBySevenWindow.l             ; $01E434
        move.w       (a7)+, rCurrentFloor(a6)                      ; $01E43A
        movem.l      (a7)+, d0-d1/d5/a0                            ; $01E43E
        move.w       rActiveActorCount(a6), d7                     ; $01E442
        beq.b        ExplosionTryLocalPlayer                       ; $01E446
        subq.w       #$1, d7                                       ; $01E448
        movea.l      rActiveActorHead(a6), a0                      ; $01E44A

ExplosionVisitActor:
        movem.w      d0-d1/d5/d7, -(a7)                            ; $01E44E
        move.l       (a0), -(a7)                                   ; $01E452
        cmp.b        ActorFloor(a0), d5                            ; $01E454
        bne.b        loc_01E4A4                                    ; $01E458
        movem.w      d0-d1, -(a7)                                  ; $01E45A
        move.w       ActorX(a0), d3                                ; $01E45E
        move.w       ActorY(a0), d4                                ; $01E462
        bsr.w        TraceObstructionInActiveWindow                ; $01E466
        beq.b        loc_01E472                                    ; $01E46A
        movem.w      (a7)+, d0-d1                                  ; $01E46C
        bra.b        loc_01E4A4                                    ; $01E470

loc_01E472:
        movem.w      (a7)+, d0-d1                                  ; $01E472
        sub.w        ActorX(a0), d0                                ; $01E476
        sub.w        ActorY(a0), d1                                ; $01E47A
        move.w       d0, d3                                        ; $01E47E
        move.w       d1, d4                                        ; $01E480
        jsr          OctagonalDistance.l                           ; $01E482
        cmpi.w       #$400, d0                                     ; $01E488
        bcc.b        loc_01E4A4                                    ; $01E48C
        cmpi.w       #$80, d0                                      ; $01E48E
        bhi.b        loc_01E49A                                    ; $01E492
; Distance<=$80 sets global $FF2A42 for hit callback; sender $1EAE2 uses it to select link command07 instead of06. Not ActorAlternateDeathSignal. Cleared after callback; assumed clear on entry for farther hits.
        move.b       #$1, -$55be(a6)                               ; $01E494

loc_01E49A:
        movea.l      ActorHitCallback(a0), a1                      ; $01E49A
; D0=distance, D3/D4=blastXY-targetXY. No source/faction/Flags exclusion, including other projectiles. Original CurrentWeapon byte remains unchanged, so local enemy weapon-specific reactions still apply.
        jsr          (a1)                                          ; $01E49E
        clr.b        -$55be(a6)                                    ; $01E4A0

loc_01E4A4:
        movea.l      (a7)+, a0                                     ; $01E4A4
        movem.w      (a7)+, d0-d1/d5/d7                            ; $01E4A6
        dbra         d7, ExplosionVisitActor                       ; $01E4AA

ExplosionTryLocalPlayer:
; Only same current floor; separate visible-map LOS. Character ID1 doubles D0 before unsigned <$400 test; common player hit then applies its own height/HP rules.
        cmp.b        rCurrentFloorLow(a6), d5                      ; $01E4AE
        bne.b        loc_01E4F8                                    ; $01E4B2
        movem.w      d0-d1, -(a7)                                  ; $01E4B4
        move.w       rPlayerX(a6), d3                              ; $01E4B8
        move.w       rPlayerY(a6), d4                              ; $01E4BC
        bsr.w        TraceObstructionInVisibleMap                  ; $01E4C0
        beq.b        loc_01E4CC                                    ; $01E4C4
        movem.w      (a7)+, d0-d1                                  ; $01E4C6
        bra.b        loc_01E4F8                                    ; $01E4CA

loc_01E4CC:
        movem.w      (a7)+, d0-d1                                  ; $01E4CC
        sub.w        rPlayerX(a6), d0                              ; $01E4D0
        sub.w        rPlayerY(a6), d1                              ; $01E4D4
        move.w       d0, d3                                        ; $01E4D8
        move.w       d1, d4                                        ; $01E4DA
        jsr          OctagonalDistance.l                           ; $01E4DC
        cmpi.w       #$1, rSelectedCharacter(a6)                   ; $01E4E2
        bne.b        loc_01E4EC                                    ; $01E4E8
        lsl.w        #$1, d0                                       ; $01E4EA

loc_01E4EC:
        cmpi.w       #$400, d0                                     ; $01E4EC
        bcc.b        loc_01E4F8                                    ; $01E4F0
        jsr          ApplyPlayerDistanceHit.l                      ; $01E4F2

loc_01E4F8:
        rts                                                        ; $01E4F8
        ifne *-$1E4FA
        fail "ROM end moved"
        endif
