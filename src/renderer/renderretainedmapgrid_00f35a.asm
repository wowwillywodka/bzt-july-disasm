; $00F35A..$00F531 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Retained map-grid renderer. Resolve map cell indices through CellTypeByIndex;
; the one-byte cell-type scratch selects extra sprites for selected types.
; The preceding entry island starts with RTS; ordinary reachability is unproved.
        ifne *-$F35A
        fail "ROM start moved"
        endif

RenderRetainedMapGrid:
        tst.w        rPauseMapRenderPassSelector(a6)                                    ; $00F35A
        bpl.w        loc_00F552                                    ; $00F35E
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $00F362
        lea.l        WallAnimationTiles(pc), a0                    ; $00F366
        move.w       rGameTick(a6), d0                             ; $00F36A
        andi.w       #$7, d0                                       ; $00F36E
        asl.w        #$1, d0                                       ; $00F372
        move.w       (a0, d0.w), d5                                ; $00F374
        lea.l        rEpisodeMapCells(a6), a0                      ; $00F378
        adda.w       rCurrentFloorMapOffset(a6), a0                ; $00F37C
        move.w       rPlayerX(a6), d0                              ; $00F380
        lsr.w        #$8, d0                                       ; $00F384
        add.w        rMapWindowOriginX(a6), d0                     ; $00F386
        adda.w       d0, a0                                        ; $00F38A
        move.w       rPlayerY(a6), d0                              ; $00F38C
        lsr.w        #$8, d0                                       ; $00F390
        add.w        rMapWindowOriginY(a6), d0                     ; $00F392
        mulu.w       rCurrentFloorWidth(a6), d0                    ; $00F396
        adda.w       d0, a0                                        ; $00F39A
        move.l       a0, rPlayerCellPointer(a6)                    ; $00F39C
        move.l       a0, -(a7)                                     ; $00F3A0
        lea.l        rVisibleMapWindow(a6), a0                     ; $00F3A2
        move.w       rPlayerX(a6), d0                              ; $00F3A6
        lsr.w        #$8, d0                                       ; $00F3AA
        adda.w       d0, a0                                        ; $00F3AC
        move.w       rPlayerY(a6), d0                              ; $00F3AE
        lsr.w        #$8, d0                                       ; $00F3B2
        lsl.w        #$5, d0                                       ; $00F3B4
        adda.w       d0, a0                                        ; $00F3B6
        movem.l      d5/a2, -(a7)                                  ; $00F3B8
        bsr.w        TryCollectItemAtCurrentCell                     ; $00F3BC
        movem.l      (a7)+, d5/a2                                  ; $00F3C0
        movea.l      (a7)+, a0                                     ; $00F3C4
        cmpa.l       rPreviousPlayerCellPointer(a6), a0            ; $00F3C6
        beq.b        loc_00F3DC                                    ; $00F3CA
        move.w       d5, -(a7)                                     ; $00F3CC
        move.l       a0, rPreviousPlayerCellPointer(a6)            ; $00F3CE
        move.l       a2, -(a7)                                     ; $00F3D2
        bsr.w        DispatchEnteredCellInteraction                     ; $00F3D4
        movea.l      (a7)+, a2                                     ; $00F3D8
        move.w       (a7)+, d5                                     ; $00F3DA

loc_00F3DC:
        lea.l        rCellTypeByIndex(a6), a5                      ; $00F3DC
        clr.w        d3                                            ; $00F3E0
        move.w       #$c81a, d2                                    ; $00F3E2
        lea.l        rEpisodeMapCells(a6), a3                      ; $00F3E6
        adda.w       rCurrentFloorMapOffset(a6), a3                ; $00F3EA
        lea.l        rPackedCellRenderState(a6), a0                ; $00F3EE
        move.w       rCurrentFloorMapOffset(a6), d0                ; $00F3F2
        lsr.w        #$1, d0                                       ; $00F3F6
        adda.w       d0, a0                                        ; $00F3F8
        move.w       rMapSpriteViewCenterX(a6), d0                                ; $00F3FA
        asr.w        #$8, d0                                       ; $00F3FE
        subq.w       #$5, d0                                       ; $00F400
        add.w        rMapWindowOriginX(a6), d0                     ; $00F402
        adda.w       d0, a3                                        ; $00F406
        move.w       d0, d7                                        ; $00F408
        lsr.w        #$1, d0                                       ; $00F40A
        adda.w       d0, a0                                        ; $00F40C
        clr.b        rMapCellParityPhase(a6)                                    ; $00F40E
        andi.w       #$1, d7                                       ; $00F412
        beq.b        loc_00F41E                                    ; $00F416
        move.b       #$1, rMapCellParityPhase(a6)                               ; $00F418

loc_00F41E:
        move.w       rMapSpriteViewCenterY(a6), d0                                ; $00F41E
        asr.w        #$8, d0                                       ; $00F422
        subq.w       #$5, d0                                       ; $00F424
        add.w        rMapWindowOriginY(a6), d0                     ; $00F426
        mulu.w       rCurrentFloorWidth(a6), d0                    ; $00F42A
        adda.w       d0, a3                                        ; $00F42E
        lsr.w        #$1, d0                                       ; $00F430
        adda.w       d0, a0                                        ; $00F432
        move.w       #$9, d7                                       ; $00F434
        move.w       #$10a, d4                                     ; $00F438
        addq.w       #$5, d5                                       ; $00F43C

loc_00F43E:
        move.w       #$9, d6                                       ; $00F43E
        movea.l      a0, a1                                        ; $00F442
        movea.l      a3, a4                                        ; $00F444
        addi.w       #$80, d2                                      ; $00F446
        move.w       d2, d0                                        ; $00F44A
        move.w       d0, d1                                        ; $00F44C
        andi.w       #$3fff, d1                                    ; $00F44E
        ori.w        #$4000, d1                                    ; $00F452
        swap         d1                                            ; $00F456
        lsr.w        #$8, d0                                       ; $00F458
        lsr.w        #$6, d0                                       ; $00F45A
        move.w       d0, d1                                        ; $00F45C
        move.l       d1, VDP_CONTROL.l                             ; $00F45E
        clr.l        d0                                            ; $00F464
        move.w       rCurrentFloorWidth(a6), d0                    ; $00F466
        adda.w       d0, a3                                        ; $00F46A
        lsr.w        #$1, d0                                       ; $00F46C
        adda.w       d0, a0                                        ; $00F46E
        move.w       #$ea, d1                                      ; $00F470

loc_00F474:
        clr.w        d0                                            ; $00F474
        clr.w        d3                                            ; $00F476
        move.b       rMapCellParityPhase(a6), d3                                ; $00F478
        eori.b       #$1, rMapCellParityPhase(a6)                               ; $00F47C
        andi.w       #$1, d3                                       ; $00F482
        bne.b        loc_00F492                                    ; $00F486
        move.b       (a1), d0                                      ; $00F488
        lsr.w        #$4, d0                                       ; $00F48A
        andi.w       #$f, d0                                       ; $00F48C
        bra.b        loc_00F498                                    ; $00F490

loc_00F492:
        move.b       (a1)+, d0                                     ; $00F492
        andi.w       #$f, d0                                       ; $00F494

loc_00F498:
        clr.w        d3                                            ; $00F498
        move.b       (a4)+, d3                                     ; $00F49A
        move.b       (a5, d3.w), d3                                ; $00F49C
        move.b       d3, rRetainedMapCellTypeScratch(a6)                                ; $00F4A0
        clr.w        d3                                            ; $00F4A4
        move.b       d0, d3                                        ; $00F4A6
        cmpi.b       #$85, rRetainedMapCellTypeScratch(a6)                              ; $00F4A8
        bne.b        loc_00F4CA                                    ; $00F4AE
        move.w       d4, (a2)+                                     ; $00F4B0
        move.w       rSpriteAttributeNextLink(a6), d0                                ; $00F4B2
        ori.w        #$0, d0                                       ; $00F4B6
        move.w       d0, (a2)+                                     ; $00F4BA
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $00F4BC
        addq.w       #$5, d5                                       ; $00F4C0
        move.w       d5, (a2)+                                     ; $00F4C2
        subq.w       #$5, d5                                       ; $00F4C4
        move.w       d1, (a2)+                                     ; $00F4C6
        bra.b        loc_00F506                                    ; $00F4C8

loc_00F4CA:
        tst.w        rTimedItemSlot6Index(a6)                                    ; $00F4CA
        bmi.w        loc_00F506                                    ; $00F4CE
        cmpi.b       #$29, rRetainedMapCellTypeScratch(a6)                              ; $00F4D2
        bcs.b        loc_00F506                                    ; $00F4D8
        cmpi.b       #$2b, rRetainedMapCellTypeScratch(a6)                              ; $00F4DA
        bls.b        loc_00F4F2                                    ; $00F4E0
        cmpi.b       #$65, rRetainedMapCellTypeScratch(a6)                              ; $00F4E2
        bcs.b        loc_00F506                                    ; $00F4E8
        cmpi.b       #$6b, rRetainedMapCellTypeScratch(a6)                              ; $00F4EA
        bhi.b        loc_00F506                                    ; $00F4F0

loc_00F4F2:
        move.w       d4, (a2)+                                     ; $00F4F2
        move.w       rSpriteAttributeNextLink(a6), d0                                ; $00F4F4
        ori.w        #$0, d0                                       ; $00F4F8
        move.w       d0, (a2)+                                     ; $00F4FC
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $00F4FE
        move.w       d5, (a2)+                                     ; $00F502
        move.w       d1, (a2)+                                     ; $00F504

loc_00F506:
        bsr.w        GetCellCollisionClass                         ; $00F506
        addi.w       #$e2ea, d3                                    ; $00F50A
        move.w       d3, VDP_DATA.l                                ; $00F50E
        addq.w       #$8, d1                                       ; $00F514
        dbra         d6, loc_00F474                                ; $00F516
        addq.w       #$8, d4                                       ; $00F51A
        dbra         d7, loc_00F43E                                ; $00F51C
        subq.w       #$5, d5                                       ; $00F520
        bsr.w        AppendPlayerWorldSpritesToSat                        ; $00F522
        addq.w       #$5, d5                                       ; $00F526
        bsr.w        AppendVisibleActorsToSat                        ; $00F528
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $00F52C
        rts                                                        ; $00F530
        ifne *-$F532
        fail "ROM end moved"
        endif
