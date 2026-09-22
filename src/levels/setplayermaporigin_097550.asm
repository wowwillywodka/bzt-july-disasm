; $097550..$097619 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Старт/кламп позиции игрока на уровне: D0<<1 индексирует таблицу базового смещения карты (-0x437e,A6)->(-0x4386) и таблицу ширины/высоты сетки байт-парами (-0x433e,A6)->ширина(-0x4384)/высота(-0x4382); клампит координаты игрока (-0x438e/-0x438c) и точную позицию (-0x7206/-0x7204) к границам, затем bsr 0x976bc
        ifne *-$97550
        fail "ROM start moved"
        endif

SetPlayerMapOrigin:
; D0=destination floor, D2/D3=global fixed-point XY. Select floor and center/clamp the local window.
        lsl.w        #$1, d0                                       ; $097550
        lea.l        rFloorDimensions(a6), a1                      ; $097552
        lea.l        rFloorMapOffsets(a6), a2                      ; $097556
        move.w       (a2, d0.w), rCurrentFloorMapOffset(a6)        ; $09755A
        move.b       (a1, d0.w), d1                                ; $097560
        andi.w       #$ff, d1                                      ; $097564
        move.w       d1, rCurrentFloorWidth(a6)                    ; $097568
        move.b       $1(a1, d0.w), d1                              ; $09756C
        andi.w       #$ff, d1                                      ; $097570
        move.w       d1, rCurrentFloorHeight(a6)                   ; $097574
        move.w       d2, d0                                        ; $097578
        move.w       d3, d1                                        ; $09757A
        lsr.w        #$8, d0                                       ; $09757C
        lsr.w        #$8, d1                                       ; $09757E
        cmpi.w       #$20, rCurrentFloorWidth(a6)                  ; $097580
        bls.b        loc_09759C                                    ; $097586
        subi.w       #$10, d0                                      ; $097588
        bge.b        loc_097594                                    ; $09758C
        move.w       #$0, d0                                       ; $09758E
        bra.b        loc_09759C                                    ; $097592

loc_097594:
        andi.w       #$ff, d2                                      ; $097594
        ori.w        #$1000, d2                                    ; $097598

loc_09759C:
        cmpi.w       #$20, rCurrentFloorHeight(a6)                 ; $09759C
        bls.b        loc_0975B8                                    ; $0975A2
        subi.w       #$10, d1                                      ; $0975A4
        bge.b        loc_0975B0                                    ; $0975A8
        move.w       #$0, d1                                       ; $0975AA
        bra.b        loc_0975B8                                    ; $0975AE

loc_0975B0:
        andi.w       #$ff, d3                                      ; $0975B0
        ori.w        #$1000, d3                                    ; $0975B4

loc_0975B8:
        move.w       rCurrentFloorWidth(a6), d4                    ; $0975B8
        move.w       rCurrentFloorHeight(a6), d5                   ; $0975BC
        move.w       d0, d6                                        ; $0975C0
        move.w       d1, d7                                        ; $0975C2
        addi.w       #$20, d6                                      ; $0975C4
        addi.w       #$20, d7                                      ; $0975C8
        cmpi.w       #$20, d4                                      ; $0975CC
        bls.b        loc_0975DE                                    ; $0975D0
        cmp.w        d4, d6                                        ; $0975D2
        bls.b        loc_0975DE                                    ; $0975D4
        sub.w        d4, d6                                        ; $0975D6
        sub.w        d6, d0                                        ; $0975D8
        lsl.w        #$8, d6                                       ; $0975DA
        add.w        d6, d2                                        ; $0975DC

loc_0975DE:
        cmpi.w       #$20, d5                                      ; $0975DE
        bls.b        loc_0975F0                                    ; $0975E2
        cmp.w        d5, d7                                        ; $0975E4
        bls.b        loc_0975F0                                    ; $0975E6
        sub.w        d5, d7                                        ; $0975E8
        sub.w        d7, d1                                        ; $0975EA
        lsl.w        #$8, d7                                       ; $0975EC
        add.w        d7, d3                                        ; $0975EE

loc_0975F0:
        cmpi.w       #$20, d4                                      ; $0975F0
        bhi.b        loc_0975FA                                    ; $0975F4
        move.w       #$0, d0                                       ; $0975F6

loc_0975FA:
        cmpi.w       #$20, d5                                      ; $0975FA
        bhi.b        loc_097604                                    ; $0975FE
        move.w       #$0, d1                                       ; $097600

loc_097604:
        move.w       d0, rMapWindowOriginX(a6)                     ; $097604
        move.w       d1, rMapWindowOriginY(a6)                     ; $097608
        move.w       d2, rPlayerX(a6)                              ; $09760C
        move.w       d3, rPlayerY(a6)                              ; $097610
; D2/D3 still contain new local player fixed-point XY here; preserve this actual caller contract.
        bsr.w        ShiftWorldRelativeCoordinates                 ; $097614
        rts                                                        ; $097618
        ifne *-$9761A
        fail "ROM end moved"
        endif
