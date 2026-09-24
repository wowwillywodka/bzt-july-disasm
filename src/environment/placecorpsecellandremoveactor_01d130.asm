; $01D130..$01D259 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Установка тайла на сетку уровня по позиции актёра: спецобработка типов 0xC8/0xC9 (тайлы 0x35/0x00 из таблицы $bea), иначе ищет соседнюю свободную клетку (9 соседей) и пишет тайл 0x4b(a0); фиксирует через $20910, при флаге -$53a4 шлёт пакет-событие {0x5,id $42} в очередь команд $1ffcc
        ifne *-$1D130
        fail "ROM start moved"
        endif

PlaceCorpseCellAndRemoveActor:
; Corpse exit. Death modes C8/C9 write fixed cell profiles 35/00; otherwise
; place ActorCorpseCellProfile into the first empty nearby cell, if any.
; The actor is removed even when all nine candidate cells are occupied.
        bsr.w        GetVisibleMapBase                             ; $01D130
        move.w       ActorX(a0), d0                                ; $01D134
        asr.w        #$8, d0                                       ; $01D138
        adda.w       d0, a1                                        ; $01D13A
        move.w       ActorY(a0), d0                                ; $01D13C
        clr.b        d0                                            ; $01D140
        asr.w        #$3, d0                                       ; $01D142
        adda.w       d0, a1                                        ; $01D144
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $01D146
        beq.w        loc_01D15E                                    ; $01D14C
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $01D150
        beq.w        loc_01D192                                    ; $01D156
        bra.w        loc_01D1C6                                    ; $01D15A

loc_01D15E:
        lea.l        rCellIndexByType(a6), a2                      ; $01D15E
        clr.w        d0                                            ; $01D162
        move.b       #$35, d0                                      ; $01D164
        cmpa.l       #$ffa5fa, a1                                  ; $01D168
        bcs.b        loc_01D178                                    ; $01D16E
        cmpa.l       #$ffe5fa, a1                                  ; $01D170
        bcs.b        loc_01D17E                                    ; $01D176

loc_01D178:
        movea.l      #$ffa9fa, a1                                  ; $01D178

loc_01D17E:
        move.b       (a2, d0.w), (a1)                              ; $01D17E
        move.l       a0, -(a7)                                     ; $01D182
        movea.l      a1, a0                                        ; $01D184
        jsr          CommitMapCellAndSendLink.l                    ; $01D186
        movea.l      (a7)+, a0                                     ; $01D18C
        bra.w        loc_01D230                                    ; $01D18E

loc_01D192:
        lea.l        rCellIndexByType(a6), a2                      ; $01D192
        clr.w        d0                                            ; $01D196
        move.b       #$0, d0                                       ; $01D198
        cmpa.l       #$ffa5fa, a1                                  ; $01D19C
        bcs.b        loc_01D1AC                                    ; $01D1A2
        cmpa.l       #$ffe5fa, a1                                  ; $01D1A4
        bcs.b        loc_01D1B2                                    ; $01D1AA

loc_01D1AC:
        movea.l      #$ffa9fa, a1                                  ; $01D1AC

loc_01D1B2:
        move.b       (a2, d0.w), (a1)                              ; $01D1B2
        move.l       a0, -(a7)                                     ; $01D1B6
        movea.l      a1, a0                                        ; $01D1B8
        jsr          CommitMapCellAndSendLink.l                    ; $01D1BA
        movea.l      (a7)+, a0                                     ; $01D1C0
        bra.w        loc_01D230                                    ; $01D1C2

loc_01D1C6:
        tst.b        (a1)                                          ; $01D1C6
        beq.b        loc_01D200                                    ; $01D1C8
        subq.w       #$1, a1                                       ; $01D1CA
        tst.b        (a1)                                          ; $01D1CC
        beq.b        loc_01D200                                    ; $01D1CE
        addq.w       #$2, a1                                       ; $01D1D0
        tst.b        (a1)                                          ; $01D1D2
        beq.b        loc_01D200                                    ; $01D1D4
        suba.w       #$21, a1                                      ; $01D1D6
        tst.b        (a1)                                          ; $01D1DA
        beq.b        loc_01D200                                    ; $01D1DC
        adda.w       #$40, a1                                      ; $01D1DE
        tst.b        (a1)                                          ; $01D1E2
        beq.b        loc_01D200                                    ; $01D1E4
        subq.w       #$1, a1                                       ; $01D1E6
        tst.b        (a1)                                          ; $01D1E8
        beq.b        loc_01D200                                    ; $01D1EA
        addq.w       #$2, a1                                       ; $01D1EC
        tst.b        (a1)                                          ; $01D1EE
        beq.b        loc_01D200                                    ; $01D1F0
        suba.w       #$40, a1                                      ; $01D1F2
        tst.b        (a1)                                          ; $01D1F6
        beq.b        loc_01D200                                    ; $01D1F8
        subq.w       #$2, a1                                       ; $01D1FA
        tst.b        (a1)                                          ; $01D1FC
        bne.b        loc_01D230                                    ; $01D1FE

loc_01D200:
        lea.l        rCellIndexByType(a6), a2                      ; $01D200
        clr.w        d0                                            ; $01D204
        move.b       ActorCorpseCellProfile(a0), d0                ; $01D206
        cmpa.l       #$ffa5fa, a1                                  ; $01D20A
        bcs.b        loc_01D21A                                    ; $01D210
        cmpa.l       #$ffe5fa, a1                                  ; $01D212
        bcs.b        loc_01D220                                    ; $01D218

loc_01D21A:
        movea.l      #$ffa9fa, a1                                  ; $01D21A

loc_01D220:
        move.b       (a2, d0.w), (a1)                              ; $01D220
        move.l       a0, -(a7)                                     ; $01D224
        movea.l      a1, a0                                        ; $01D226
        jsr          CommitMapCellAndSendLink.l                    ; $01D228
        movea.l      (a7)+, a0                                     ; $01D22E

loc_01D230:
        tst.w        rLinkRole(a6)                                 ; $01D230
        beq.w        RemoveActor                                   ; $01D234
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01D238
        move.b       #$5, (a1)                                     ; $01D23C
        move.b       ActorLinkId(a0), $1(a1)                       ; $01D240
        movem.l      d0-d7/a0-a3, -(a7)                            ; $01D246
        movea.l      a1, a0                                        ; $01D24A
        jsr          QueueLinkCommand.l                            ; $01D24C
        movem.l      (a7)+, d0-d7/a0-a3                            ; $01D252
        bra.w        RemoveActor                                   ; $01D256
        ifne *-$1D25A
        fail "ROM end moved"
        endif
