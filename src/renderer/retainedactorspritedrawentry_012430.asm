; $012430..$012607 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
; JULY LOCAL REVIEW:
; This root retains an actor-bank frame draw; following object-tile entries have live table references. Storage status and per-entry reachability are distinct.
        ifne *-$12430
        fail "ROM start moved"
        endif

RetainedActorSpriteDrawEntry:
; This root retains an actor-bank frame draw; following object-tile entries have live table references. Storage status and per-entry reachability are distinct.
        movea.l      #StananSpriteBank, a1                         ; $012430
        move.w       #$6, d0                                       ; $012436
        clr.w        d3                                            ; $01243A
        clr.w        d7                                            ; $01243C
        jmp          DrawExplicitAnimationFrame.l                  ; $01243E

loc_012444:
        movea.l      rZoneObjectTiles(a6), a1                      ; $012444
        adda.w       #ObjectTileOffset46_TreeCell37, a1            ; $012448
        bra.w        DrawTallObjectTile                            ; $01244C

loc_012450:
        movea.l      rZoneObjectTiles(a6), a1                      ; $012450
        adda.w       #ObjectTileOffset47_TreeCell5C, a1            ; $012454
        bra.w        DrawTallObjectTile                            ; $012458

loc_01245C:
        movea.l      rZoneObjectTiles(a6), a1                      ; $01245C
        adda.w       #ObjectTileOffset51_ColumnCell60, a1          ; $012460
        bra.w        DrawNarrowObjectTile                          ; $012464

loc_012468:
        movea.l      rZoneObjectTiles(a6), a1                      ; $012468
        adda.w       #ObjectTileOffset52_ColumnCell76, a1          ; $01246C
        bra.w        DrawNarrowObjectTile                          ; $012470

loc_012474:
        movea.l      rZoneObjectTiles(a6), a1                      ; $012474
        adda.w       #ObjectTileOffset54_ColumnCell61, a1          ; $012478
        bra.w        DrawNarrowObjectTile                          ; $01247C

loc_012480:
        movea.l      rZoneObjectTiles(a6), a1                      ; $012480
        adda.w       #ObjectTileOffset48_FloorLamp, a1             ; $012484
        move.w       d5, d0                                        ; $012488
        asr.w        #$2, d0                                       ; $01248A
        sub.w        d0, d5                                        ; $01248C
        sub.w        d5, d2                                        ; $01248E
        move.w       d5, d0                                        ; $012490
        move.w       d0, d4                                        ; $012492
        asr.w        #$1, d4                                       ; $012494
        move.w       d4, d3                                        ; $012496
        asr.w        #$1, d3                                       ; $012498
        sub.w        d3, d1                                        ; $01249A
        clr.w        -$6f32(a6)                                    ; $01249C
        bra.w        ScaleAndDrawSoftwareSpriteTile                ; $0124A0

loc_0124A4:
        movea.l      rZoneObjectTiles(a6), a1                      ; $0124A4
        adda.w       #ObjectTileOffset55_FurnitureShared, a1       ; $0124A8
        move.w       d5, d0                                        ; $0124AC
        asr.w        #$1, d0                                       ; $0124AE
        sub.w        d0, d2                                        ; $0124B0
        move.w       d0, d4                                        ; $0124B2
        asr.w        #$2, d4                                       ; $0124B4
        move.w       d4, d3                                        ; $0124B6
        asr.w        #$1, d3                                       ; $0124B8
        sub.w        d3, d1                                        ; $0124BA
        clr.w        -$6f32(a6)                                    ; $0124BC
        bra.w        ScaleAndDrawSoftwareSpriteTile                ; $0124C0

loc_0124C4:
        movea.l      rZoneObjectTiles(a6), a1                      ; $0124C4
        adda.w       #ObjectTileOffset55_FurnitureShared, a1       ; $0124C8
        asr.w        #$1, d5                                       ; $0124CC
        move.w       d5, d4                                        ; $0124CE
        move.w       d5, d0                                        ; $0124D0
        asr.w        #$2, d0                                       ; $0124D2
        sub.w        d0, d5                                        ; $0124D4
        sub.w        d5, d2                                        ; $0124D6
        move.w       d5, d0                                        ; $0124D8
        move.w       d4, d3                                        ; $0124DA
        asr.w        #$1, d3                                       ; $0124DC
        sub.w        d3, d1                                        ; $0124DE
        clr.w        -$6f32(a6)                                    ; $0124E0
        bra.w        ScaleAndDrawSoftwareSpriteTile                ; $0124E4

loc_0124E8:
        movea.l      rZoneObjectTiles(a6), a1                      ; $0124E8
        adda.w       #ObjectTileOffset53_LampFrame0, a1            ; $0124EC
        sub.w        d5, d2                                        ; $0124F0
        move.w       d5, d0                                        ; $0124F2
        asr.w        #$2, d0                                       ; $0124F4
        move.w       d0, d4                                        ; $0124F6
        asr.w        #$1, d4                                       ; $0124F8
        move.w       d4, d3                                        ; $0124FA
        asr.w        #$1, d3                                       ; $0124FC
        sub.w        d3, d1                                        ; $0124FE
        clr.w        -$6f32(a6)                                    ; $012500
        bra.w        ScaleAndDrawSoftwareSpriteTile                ; $012504

loc_012508:
; Type $64 is a composite: draw tile 56, restore saved D1/D2/D5, then draw tile 50. These are two calls with different anchors, not adjacent pieces in ROM.
        movem.w      d1-d2/d5, -(a7)                               ; $012508
        movea.l      rZoneObjectTiles(a6), a1                      ; $01250C
        adda.w       #ObjectTileOffset56_HangingLampTop, a1        ; $012510
        sub.w        d5, d2                                        ; $012514
        move.w       d5, d4                                        ; $012516
        asr.w        #$2, d4                                       ; $012518
        move.w       d4, d0                                        ; $01251A
        asr.w        #$1, d0                                       ; $01251C
        move.w       d4, d3                                        ; $01251E
        asr.w        #$1, d3                                       ; $012520
        sub.w        d3, d1                                        ; $012522
        clr.w        -$6f32(a6)                                    ; $012524
        bsr.w        ScaleAndDrawSoftwareSpriteTile                ; $012528
        bra.w        loc_012580                                    ; $01252C

loc_012530:
        movea.l      rZoneObjectTiles(a6), a1                      ; $012530
        adda.w       #ObjectTileOffset57_SmallLamp, a1             ; $012534
        sub.w        d5, d2                                        ; $012538
        move.w       d5, d4                                        ; $01253A
        asr.w        #$1, d4                                       ; $01253C
        move.w       d4, d0                                        ; $01253E
        asr.w        #$2, d0                                       ; $012540
        move.w       d4, d3                                        ; $012542
        asr.w        #$1, d3                                       ; $012544
        sub.w        d3, d1                                        ; $012546
        clr.w        -$6f32(a6)                                    ; $012548
        bra.w        ScaleAndDrawSoftwareSpriteTile                ; $01254C

loc_012550:
        movea.l      rZoneObjectTiles(a6), a1                      ; $012550
        adda.w       #ObjectTileOffset53_LampFrame0, a1            ; $012554
        btst.b       #$1, -$711f(a6)                               ; $012558
        beq.b        loc_012568                                    ; $01255E
        movea.l      rZoneObjectTiles(a6), a1                      ; $012560
        adda.w       #ObjectTileOffset49_FlashingLampFrame1, a1    ; $012564

loc_012568:
        sub.w        d5, d2                                        ; $012568
        move.w       d5, d0                                        ; $01256A
        asr.w        #$2, d0                                       ; $01256C
        move.w       d0, d4                                        ; $01256E
        asr.w        #$1, d4                                       ; $012570
        move.w       d4, d3                                        ; $012572
        asr.w        #$1, d3                                       ; $012574
        sub.w        d3, d1                                        ; $012576
        clr.w        -$6f32(a6)                                    ; $012578
        bra.w        ScaleAndDrawSoftwareSpriteTile                ; $01257C

loc_012580:
        movem.w      (a7)+, d1-d2/d5                               ; $012580
        movea.l      rZoneObjectTiles(a6), a1                      ; $012584
        adda.w       #ObjectTileOffset50_HangingLampBase, a1       ; $012588
        move.w       d5, d4                                        ; $01258C
        asr.w        #$1, d4                                       ; $01258E
        move.w       d4, d3                                        ; $012590
        asr.w        #$1, d3                                       ; $012592
        sub.w        d3, d1                                        ; $012594
        move.w       d3, d0                                        ; $012596
        move.w       #$20, d3                                      ; $012598
        add.w        -$71d8(a6), d3                                ; $01259C
        sub.w        -$6e4c(a6), d3                                ; $0125A0
        muls.w       d3, d0                                        ; $0125A4
        asr.l        #$6, d0                                       ; $0125A6
        move.w       d0, d3                                        ; $0125A8
        asr.w        #$1, d3                                       ; $0125AA
        sub.w        d3, d2                                        ; $0125AC
        clr.w        -$6f32(a6)                                    ; $0125AE
        bra.w        ScaleAndDrawSoftwareSpriteTile                ; $0125B2

loc_0125B6:
; Type $78 fan: tick&3 selects (tile,mirror) = (58,0),(59,0),(59,1),(58,1).
        clr.w        -$6f32(a6)                                    ; $0125B6
        movea.l      rZoneObjectTiles(a6), a1                      ; $0125BA
        adda.w       #ObjectTileOffset58_FanFrame0, a1             ; $0125BE
        move.w       rGameTick(a6), d0                             ; $0125C2
        andi.w       #$3, d0                                       ; $0125C6
        beq.b        loc_0125D6                                    ; $0125CA
        cmpi.w       #$3, d0                                       ; $0125CC
        beq.b        loc_0125D6                                    ; $0125D0
        adda.w       #ObjectTileBytes, a1                          ; $0125D2

loc_0125D6:
        cmpi.w       #$2, d0                                       ; $0125D6
        bcs.b        loc_0125E2                                    ; $0125DA
        move.w       #$1, -$6f32(a6)                               ; $0125DC

loc_0125E2:
        move.w       d5, d4                                        ; $0125E2
        asr.w        #$1, d4                                       ; $0125E4
        move.w       d4, d3                                        ; $0125E6
        asr.w        #$1, d3                                       ; $0125E8
        sub.w        d3, d1                                        ; $0125EA
        move.w       d3, d0                                        ; $0125EC
        move.w       #$20, d3                                      ; $0125EE
        add.w        -$71d8(a6), d3                                ; $0125F2
        sub.w        -$6e4c(a6), d3                                ; $0125F6
        muls.w       d3, d0                                        ; $0125FA
        asr.l        #$6, d0                                       ; $0125FC
        move.w       d0, d3                                        ; $0125FE
        asr.w        #$1, d3                                       ; $012600
        sub.w        d3, d2                                        ; $012602
        bra.w        ScaleAndDrawSoftwareSpriteTile                ; $012604
        ifne *-$12608
        fail "ROM end moved"
        endif
