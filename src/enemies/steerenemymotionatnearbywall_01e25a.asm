; $01E25A..$01E2D1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; AI-тик движущегося врага: раз в 4 кадра ищет цель 0x1e59e, при дистанции <0x600 читает клетку карты (0x1e6ec) и celltype-LUT (0x24ea); на стенах 6/7/0x83/0x84 клампит скорость vx/vy (0x25/0x27,A0) до ±0x40 и шлёт состояние через 0xdf64
        ifne *-$1E25A
        fail "ROM start moved"
        endif

SteerEnemyMotionAtNearbyWall:
        move.w       rGameTick(a6), d0                             ; $01E25A
        add.b        ActorLinkId(a0), d0                           ; $01E25E
        andi.w       #$3, d0                                       ; $01E262
        bne.b        loc_01E274                                    ; $01E266
        bsr.w        SelectEnemyPlayerTarget                       ; $01E268
        move.l       a1, ActorTarget(a0)                           ; $01E26C
        beq.w        loc_01E31E                                    ; $01E270

; Between modulo-4 reselections the cached pointer is used without a live-slot check.
loc_01E274:
        movea.l      ActorTarget(a0), a1                           ; $01E274
        move.w       ActorX(a0), d0                                ; $01E278
        move.w       ActorY(a0), d1                                ; $01E27C
        sub.w        ActorX(a1), d0                                   ; $01E280
        sub.w        ActorY(a1), d1                                   ; $01E284
        jsr          OctagonalDistance.l                           ; $01E288
        cmpi.w       #$600, d0                                     ; $01E28E
        bcc.w        loc_01E31E                                    ; $01E292
        bsr.w        GetVisibleMapBase                             ; $01E296
        move.w       ActorX(a0), d0                                ; $01E29A
        asr.w        #$8, d0                                       ; $01E29E
        adda.w       d0, a1                                        ; $01E2A0
        move.w       ActorY(a0), d0                                ; $01E2A2
        clr.b        d0                                            ; $01E2A6
        asr.w        #$3, d0                                       ; $01E2A8
        adda.w       d0, a1                                        ; $01E2AA
        clr.w        d3                                            ; $01E2AC
        move.b       (a1), d3                                      ; $01E2AE
        lea.l        rCellTypeByIndex(a6), a1                      ; $01E2B0
        move.b       (a1, d3.w), d3                                ; $01E2B4
        cmpi.b       #$6, d3                                       ; $01E2B8
        beq.b        ClampEnemyMotionAtWall                       ; $01E2BC
        cmpi.b       #$7, d3                                       ; $01E2BE
        beq.b        loc_01E2F8                                    ; $01E2C2
        cmpi.b       #$83, d3                                      ; $01E2C4
        beq.b        ClampEnemyMotionAtWall                       ; $01E2C8
        cmpi.b       #$84, d3                                      ; $01E2CA
        beq.b        loc_01E2F8                                    ; $01E2CE

loc_01E2D0:
        rts                                                        ; $01E2D0
        ifne *-$1E2D2
        fail "ROM end moved"
        endif
