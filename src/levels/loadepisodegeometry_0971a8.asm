; $0971A8..$0974BF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Reviewed July: episode/floor tables and packed RAM grids; the loader counts markers but performs no upfront actor allocation.
        ifne *-$971A8
        fail "ROM start moved"
        endif

LoadEpisodeGeometry:
; D0=geometry episode 0..3, D1=floor. Copies ALL active floor grids into RAM; does not allocate actors.
        move.w       d0, rGeometryEpisode(a6)                      ; $0971A8
        lsl.w        #$2, d0                                       ; $0971AC
        lea.l        EpisodeMapPointers(pc), a0                    ; $0971AE
        movea.l      (a0, d0.w), a0                                ; $0971B2
        adda.l       #$8c, a0                                      ; $0971B6
        lea.l        rTextureDefinitions(a6), a1                   ; $0971BC
        move.w       #TextureDefinitionBytes/4-1, d7              ; $0971C0

loc_0971C4:
        move.l       (a0)+, (a1)+                                  ; $0971C4
        dbra         d7, loc_0971C4                                ; $0971C6
        lea.l        rTextureOrder(a6), a1                         ; $0971CA
        move.w       #TextureOrderBytes/4-1, d7                    ; $0971CE

loc_0971D2:
        move.l       (a0)+, (a1)+                                  ; $0971D2
        dbra         d7, loc_0971D2                                ; $0971D4
        lea.l        rCellTypeByIndex(a6), a1                      ; $0971D8
        move.w       #CellTypeTableEntries/4-1, d7                 ; $0971DC

loc_0971E0:
        move.l       (a0)+, (a1)+                                  ; $0971E0
        dbra         d7, loc_0971E0                                ; $0971E2
        adda.w       #$10, a0                                      ; $0971E6
        lea.l        rTextureAnimationRecords(a6), a1              ; $0971EA

loc_0971EE:
; Record length includes its size word. Zero word terminates animation records; bodies are copied verbatim.
        move.w       (a0)+, d7                                     ; $0971EE
        move.w       d7, (a1)+                                     ; $0971F0
        beq.b        loc_0971FE                                    ; $0971F2
        subq.w       #$3, d7                                       ; $0971F4

loc_0971F6:
        move.b       (a0)+, (a1)+                                  ; $0971F6
        dbra         d7, loc_0971F6                                ; $0971F8
        bra.b        loc_0971EE                                    ; $0971FC

loc_0971FE:
        lea.l        rCellIndexByType(a6), a0                      ; $0971FE
        move.w       #CellTypeTableEntries-1, d7                   ; $097202

loc_097206:
; Inverse type table: first matching cell index; an absent type maps to zero, not $FF.
        clr.w        d6                                            ; $097206
        lea.l        rCellTypeByIndex(a6), a1                      ; $097208

loc_09720C:
        cmp.b        (a1)+, d7                                     ; $09720C
        beq.b        loc_097214                                    ; $09720E
        addq.b       #$1, d6                                       ; $097210
        bne.b        loc_09720C                                    ; $097212

loc_097214:
        move.b       d6, (a0, d7.w)                                ; $097214
        dbra         d7, loc_097206                                ; $097218
; Clear 8192 bytes of packed render state. This is NOT a clear of the 16384-byte map arena.
        lea.l        rPackedCellRenderState(a6), a0                ; $09721C
        move.w       #$7ff, d2                                     ; $097220

loc_097224:
        move.l       #$0, (a0)+                                    ; $097224
        dbra         d2, loc_097224                                ; $09722A
        lea.l        EpisodeMapPointers(pc), a0                    ; $09722E
        movea.l      (a0, d0.w), a0                                ; $097232
        move.l       a0, rEpisodeGeometryRom(a6)                   ; $097236
        move.w       (a0)+, d0                                     ; $09723A
        move.w       d0, rEpisodeFloorCount(a6)                    ; $09723C
        move.w       #$0, d2                                       ; $097240
; Copy all 32 descriptor slots, including inactive words; only floorCount grids are loaded below.
        move.w       #$1f, d7                                      ; $097244
        lea.l        rFloorDimensions(a6), a1                      ; $097248
        lea.l        rFloorMapOffsets(a6), a2                      ; $09724C

loc_097250:
        move.b       (a0, d2.w), (a1)+                             ; $097250
        move.b       $1(a0, d2.w), (a1)+                           ; $097254
        move.w       $2(a0, d2.w), (a2)+                           ; $097258
        addq.w       #$4, d2                                       ; $09725C
        dbra         d7, loc_097250                                ; $09725E
        move.w       (a0, d2.w), rFloorTransitionRomOffset(a6)     ; $097262
        move.w       $2(a0, d2.w), rTrainRouteRomOffset(a6)        ; $097268
        move.w       $4(a0, d2.w), rActorMarkerRomOffset(a6)       ; $09726E
        movea.l      rEpisodeGeometryRom(a6), a0                   ; $097274
        adda.w       rActorMarkerRomOffset(a6), a0                 ; $097278
        lea.l        rActorMarkerRecords(a6), a1                   ; $09727C
        move.w       (a0)+, rActorMarkerCount(a6)                  ; $097280
        move.w       #$77, d0                                      ; $097284

loc_097288:
        move.b       (a0)+, (a1)+                                  ; $097288
        dbra         d0, loc_097288                                ; $09728A
        clr.w        rWallOpeningPermit(a6)                        ; $09728E
        movea.l      rEpisodeGeometryRom(a6), a0                   ; $097292
        movea.l      a0, a4                                        ; $097296
        lea.l        rFloorMapOffsets(a6), a1                      ; $097298
        lea.l        rFloorDimensions(a6), a2                      ; $09729C
        lea.l        rEpisodeMapCells(a6), a3                      ; $0972A0
        move.w       rEpisodeFloorCount(a6), d7                    ; $0972A4
        subq.w       #$1, d7                                       ; $0972A8
        clr.w        d2                                            ; $0972AA
        clr.w        d3                                            ; $0972AC

loc_0972AE:
; ROM-relative floor offsets are consumed, then the RAM table is rewritten to packed RAM offsets.
        adda.w       (a1), a0                                      ; $0972AE
        clr.w        d0                                            ; $0972B0
        move.b       (a2)+, d0                                     ; $0972B2
        move.b       (a2)+, d4                                     ; $0972B4
        ext.w        d4                                            ; $0972B6
        mulu.w       d4, d0                                        ; $0972B8
        add.w        d0, d3                                        ; $0972BA
        subq.w       #$1, d0                                       ; $0972BC

loc_0972BE:
        move.b       (a0)+, (a3)+                                  ; $0972BE
        dbra         d0, loc_0972BE                                ; $0972C0
        movea.l      a4, a0                                        ; $0972C4
        move.w       d2, (a1)+                                     ; $0972C6
        move.w       d3, d2                                        ; $0972C8
        dbra         d7, loc_0972AE                                ; $0972CA
        lsl.w        #$1, d1                                       ; $0972CE
        lea.l        rFloorDimensions(a6), a1                      ; $0972D0
        lea.l        rFloorMapOffsets(a6), a2                      ; $0972D4
        move.w       (a2, d1.w), rCurrentFloorMapOffset(a6)        ; $0972D8
        move.b       (a1, d1.w), d2                                ; $0972DE
        andi.w       #$ff, d2                                      ; $0972E2
        move.w       d2, rCurrentFloorWidth(a6)                    ; $0972E6
        move.b       $1(a1, d1.w), d3                              ; $0972EA
        andi.w       #$ff, d3                                      ; $0972EE
        move.w       d3, rCurrentFloorHeight(a6)                   ; $0972F2
        lea.l        rEpisodeMapCells(a6), a1                      ; $0972F6
        adda.w       rCurrentFloorMapOffset(a6), a1                ; $0972FA
        lea.l        rCellTypeByIndex(a6), a5                      ; $0972FE
        mulu.w       d2, d3                                        ; $097302
        clr.l        d7                                            ; $097304

loc_097306:
; D3=width*height: this DBRA loop can inspect one extra cell. No match falls back to linear index 1.
        move.b       (a1)+, d4                                     ; $097306
        move.b       (a5, d4.w), d4                                ; $097308
        cmpi.b       #$77, d4                                      ; $09730C
        beq.b        loc_09731C                                    ; $097310
        addq.w       #$1, d7                                       ; $097312
        dbra         d3, loc_097306                                ; $097314
        move.w       #$1, d7                                       ; $097318

loc_09731C:
        divu.w       d2, d7                                        ; $09731C
        lsl.w        #$8, d7                                       ; $09731E
        addi.w       #$80, d7                                      ; $097320
        move.w       d7, d3                                        ; $097324
        swap         d7                                            ; $097326
        lsl.w        #$8, d7                                       ; $097328
        addi.w       #$80, d7                                      ; $09732A
        move.w       d7, d0                                        ; $09732E
        move.w       d7, d2                                        ; $097330
        move.w       d3, d1                                        ; $097332
        lsr.w        #$8, d0                                       ; $097334
        lsr.w        #$8, d1                                       ; $097336
        cmpi.w       #$20, rCurrentFloorWidth(a6)                  ; $097338
        bls.b        loc_097350                                    ; $09733E
        subi.w       #$10, d0                                      ; $097340
        bge.b        loc_09734C                                    ; $097344
        move.w       #$0, d0                                       ; $097346
        bra.b        loc_097350                                    ; $09734A

loc_09734C:
        move.w       #$1080, d2                                    ; $09734C

loc_097350:
        cmpi.w       #$20, rCurrentFloorHeight(a6)                 ; $097350
        bls.b        loc_097368                                    ; $097356
        subi.w       #$10, d1                                      ; $097358
        bge.b        loc_097364                                    ; $09735C
        move.w       #$0, d1                                       ; $09735E
        bra.b        loc_097368                                    ; $097362

loc_097364:
        move.w       #$1080, d3                                    ; $097364

loc_097368:
        move.w       rCurrentFloorWidth(a6), d4                    ; $097368
        move.w       rCurrentFloorHeight(a6), d5                   ; $09736C
        move.w       d0, d6                                        ; $097370
        move.w       d1, d7                                        ; $097372
        addi.w       #$20, d6                                      ; $097374
        addi.w       #$20, d7                                      ; $097378
        cmpi.w       #$20, d4                                      ; $09737C
        bls.b        loc_09738E                                    ; $097380
        cmp.w        d4, d6                                        ; $097382
        bls.b        loc_09738E                                    ; $097384
        sub.w        d4, d6                                        ; $097386
        sub.w        d6, d0                                        ; $097388
        lsl.w        #$8, d6                                       ; $09738A
        add.w        d6, d2                                        ; $09738C

loc_09738E:
        cmpi.w       #$20, d5                                      ; $09738E
        bls.b        loc_0973A0                                    ; $097392
        cmp.w        d5, d7                                        ; $097394
        bls.b        loc_0973A0                                    ; $097396
        sub.w        d5, d7                                        ; $097398
        sub.w        d7, d1                                        ; $09739A
        lsl.w        #$8, d7                                       ; $09739C
        add.w        d7, d3                                        ; $09739E

loc_0973A0:
        cmpi.w       #$20, d4                                      ; $0973A0
        bhi.b        loc_0973AA                                    ; $0973A4
        move.w       #$0, d0                                       ; $0973A6

loc_0973AA:
        cmpi.w       #$20, d5                                      ; $0973AA
        bhi.b        loc_0973B4                                    ; $0973AE
        move.w       #$0, d1                                       ; $0973B0

loc_0973B4:
        move.w       d0, rMapWindowOriginX(a6)                     ; $0973B4
        move.w       d1, rMapWindowOriginY(a6)                     ; $0973B8
        move.w       d2, rPlayerX(a6)                              ; $0973BC
        move.w       d3, rPlayerY(a6)                              ; $0973C0
; Unlike ordinary scrolling, D2/D3 here are player fixed-point coordinates, not old window-origin cells.
        bsr.w        ShiftWorldRelativeCoordinates                 ; $0973C4
        clr.w        d0                                            ; $0973C8
        lea.l        rCellTypeByIndex(a6), a0                      ; $0973CA
        movea.l      a0, a1                                        ; $0973CE
        move.w       #$ff, d7                                      ; $0973D0

loc_0973D4:
        clr.w        d3                                            ; $0973D4
        move.b       (a0)+, d3                                     ; $0973D6
        cmpi.b       #$79, d3                                      ; $0973D8
        beq.b        loc_0973E8                                    ; $0973DC
        addq.w       #$1, d0                                       ; $0973DE
        dbra         d7, loc_0973D4                                ; $0973E0
        move.b       #$ff, d0                                      ; $0973E4

loc_0973E8:
        move.b       d0, rObjectiveCellTypeIndexScratch(a6)                                ; $0973E8
        clr.w        d1                                            ; $0973EC
        cmpi.b       #$ff, d0                                      ; $0973EE
        beq.b        loc_09740A                                    ; $0973F2
        move.b       rObjectiveCellTypeIndexScratch(a6), d0                                ; $0973F4
        lea.l        rEpisodeMapCells(a6), a0                      ; $0973F8
        move.w       #$3fff, d7                                    ; $0973FC

loc_097400:
        cmp.b        (a0)+, d0                                     ; $097400
        bne.b        loc_097406                                    ; $097402
        addq.w       #$1, d1                                       ; $097404

loc_097406:
        dbra         d7, loc_097400                                ; $097406

loc_09740A:
        move.w       d1, rEpisodeObjectiveCellTotal(a6)                                ; $09740A
        clr.w        d4                                            ; $09740E
        move.w       #$29, d2                                      ; $097410
        bsr.w        CountMapCellsByType                           ; $097414
        move.w       #$2a, d2                                      ; $097418
        bsr.w        CountMapCellsByType                           ; $09741C
        move.w       #$2b, d2                                      ; $097420
        bsr.w        CountMapCellsByType                           ; $097424
        move.w       #$2c, d2                                      ; $097428
        bsr.w        CountMapCellsByType                           ; $09742C
        move.w       #$65, d2                                      ; $097430
        bsr.w        CountMapCellsByType                           ; $097434
        move.w       #$66, d2                                      ; $097438
        bsr.w        CountMapCellsByType                           ; $09743C
        move.w       #$67, d2                                      ; $097440
        bsr.b        CountMapCellsByType                           ; $097444
        move.w       #$68, d2                                      ; $097446
        bsr.b        CountMapCellsByType                           ; $09744A
        move.w       #$69, d2                                      ; $09744C
        bsr.b        CountMapCellsByType                           ; $097450
        move.w       #$6a, d2                                      ; $097452
        bsr.b        CountMapCellsByType                           ; $097456
        move.w       #$6b, d2                                      ; $097458
        bsr.b        CountMapCellsByType                           ; $09745C
        move.w       #$8, d2                                       ; $09745E
        bsr.b        CountMapCellsByType                           ; $097462
        move.w       #$9, d2                                       ; $097464
        bsr.b        CountMapCellsByType                           ; $097468
        move.w       #$a, d2                                       ; $09746A
        bsr.b        CountMapCellsByType                           ; $09746E
        move.w       #$27, d2                                      ; $097470
        bsr.b        CountMapCellsByType                           ; $097474
        move.w       d4, rEpisodeEnemyTotalForStats(a6)                                ; $097476
        clr.w        d4                                            ; $09747A
        move.w       #$ec, d0                                      ; $09747C
        bsr.b        CountMapCellIndex                             ; $097480
        move.w       #$ed, d0                                      ; $097482
        bsr.b        CountMapCellIndex                             ; $097486
        move.w       #$ee, d0                                      ; $097488
        bsr.b        CountMapCellIndex                             ; $09748C
        move.w       #$ef, d0                                      ; $09748E
        bsr.b        CountMapCellIndex                             ; $097492
        move.w       #$f4, d0                                      ; $097494
        bsr.b        CountMapCellIndex                             ; $097498
        move.w       #$f5, d0                                      ; $09749A
        bsr.b        CountMapCellIndex                             ; $09749E
        move.w       #$f6, d0                                      ; $0974A0
        bsr.b        CountMapCellIndex                             ; $0974A4
        move.w       #$f7, d0                                      ; $0974A6
        bsr.b        CountMapCellIndex                             ; $0974AA
        add.w        d4, d4                                        ; $0974AC
        add.w        d4, rEpisodeEnemyTotalForStats(a6)                                ; $0974AE
        clr.w        d4                                            ; $0974B2
        move.w       #$25, d2                                      ; $0974B4
        bsr.b        CountMapCellsByType                           ; $0974B8
        add.w        d4, rEpisodeMedipackCellTotal(a6)                                ; $0974BA
        rts                                                        ; $0974BE
        ifne *-$974C0
        fail "ROM end moved"
        endif
