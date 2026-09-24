; $01D756..$01D87F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Зонд карты у позиции камеры (-0x7206>>8, -0x7204>>3&-0x20 от базы -0x6fb2,A6): если центр или любой из 8 соседей ПУСТ (==0), пишет тайл (0xc16,A6) в эту клетку с клампом указателя в [0xffa5fa..0xffe5fa] и фиксацией через $20910 — заполнение/заделка пустой клетки
        ifne *-$1D756
        fail "ROM start moved"
        endif

FillNearbyEmptyCellAtPlayer:
        movea.l      rVisibleMapBasePointer(a6), a1                ; $01D756
        move.w       rPlayerX(a6), d0                              ; $01D75A
        asr.w        #$8, d0                                       ; $01D75E
        adda.w       d0, a1                                        ; $01D760
        move.w       rPlayerY(a6), d0                              ; $01D762
        asr.w        #$3, d0                                       ; $01D766
        andi.w       #$ffe0, d0                                    ; $01D768
        adda.w       d0, a1                                        ; $01D76C
        tst.b        (a1)                                          ; $01D76E
        beq.b        loc_01D7A8                                    ; $01D770
        subq.w       #$1, a1                                       ; $01D772
        tst.b        (a1)                                          ; $01D774
        beq.b        loc_01D7A8                                    ; $01D776
        addq.w       #$2, a1                                       ; $01D778
        tst.b        (a1)                                          ; $01D77A
        beq.b        loc_01D7A8                                    ; $01D77C
        suba.w       #$21, a1                                      ; $01D77E
        tst.b        (a1)                                          ; $01D782
        beq.b        loc_01D7A8                                    ; $01D784
        adda.w       #$40, a1                                      ; $01D786
        tst.b        (a1)                                          ; $01D78A
        beq.b        loc_01D7A8                                    ; $01D78C
        subq.w       #$1, a1                                       ; $01D78E
        tst.b        (a1)                                          ; $01D790
        beq.b        loc_01D7A8                                    ; $01D792
        addq.w       #$2, a1                                       ; $01D794
        tst.b        (a1)                                          ; $01D796
        beq.b        loc_01D7A8                                    ; $01D798
        suba.w       #$40, a1                                      ; $01D79A
        tst.b        (a1)                                          ; $01D79E
        beq.b        loc_01D7A8                                    ; $01D7A0
        subq.w       #$2, a1                                       ; $01D7A2
        tst.b        (a1)                                          ; $01D7A4
        bne.b        loc_01D7CC                                    ; $01D7A6

loc_01D7A8:
        cmpa.l       #$ffa5fa, a1                                  ; $01D7A8
        bcs.b        loc_01D7B8                                    ; $01D7AE
        cmpa.l       #$ffe5fa, a1                                  ; $01D7B0
        bcs.b        loc_01D7BE                                    ; $01D7B6

loc_01D7B8:
        movea.l      #$ffa9fa, a1                                  ; $01D7B8

loc_01D7BE:
        move.b       rCellIndexForType2C(a6), (a1)                                ; $01D7BE
        move.l       a0, -(a7)                                     ; $01D7C2
        movea.l      a1, a0                                        ; $01D7C4
        bsr.w        CommitMapCellAndSendLink                      ; $01D7C6
        movea.l      (a7)+, a0                                     ; $01D7CA

loc_01D7CC:
        rts                                                        ; $01D7CC

ExitLivingEnemyToMapCell:
; Exit callback shared by all 11 live enemy definitions. Search the current
; cell and eight neighbors for an empty marker slot; if none exists, count
; legacy floor objectives before removing the actor without writing a marker.
        bsr.w        GetVisibleMapBase                             ; $01D7CE
        move.w       ActorX(a0), d0                                ; $01D7D2
        asr.w        #$8, d0                                       ; $01D7D6
        adda.w       d0, a1                                        ; $01D7D8
        move.w       ActorY(a0), d0                                ; $01D7DA
        asr.w        #$3, d0                                       ; $01D7DE
        andi.w       #$ffe0, d0                                    ; $01D7E0
        adda.w       d0, a1                                        ; $01D7E4
        tst.b        (a1)                                          ; $01D7E6
        beq.b        loc_01D820                                    ; $01D7E8
        subq.w       #$1, a1                                       ; $01D7EA
        tst.b        (a1)                                          ; $01D7EC
        beq.b        loc_01D820                                    ; $01D7EE
        addq.w       #$2, a1                                       ; $01D7F0
        tst.b        (a1)                                          ; $01D7F2
        beq.b        loc_01D820                                    ; $01D7F4
        suba.w       #$21, a1                                      ; $01D7F6
        tst.b        (a1)                                          ; $01D7FA
        beq.b        loc_01D820                                    ; $01D7FC
        adda.w       #$40, a1                                      ; $01D7FE
        tst.b        (a1)                                          ; $01D802
        beq.b        loc_01D820                                    ; $01D804
        subq.w       #$1, a1                                       ; $01D806
        tst.b        (a1)                                          ; $01D808
        beq.b        loc_01D820                                    ; $01D80A
        addq.w       #$2, a1                                       ; $01D80C
        tst.b        (a1)                                          ; $01D80E
        beq.b        loc_01D820                                    ; $01D810
        suba.w       #$40, a1                                      ; $01D812
        tst.b        (a1)                                          ; $01D816
        beq.b        loc_01D820                                    ; $01D818
        subq.w       #$2, a1                                       ; $01D81A
        tst.b        (a1)                                          ; $01D81C
        bne.b        loc_01D850                                    ; $01D81E

loc_01D820:
        lea.l        rCellIndexByType(a6), a2                      ; $01D820
        clr.w        d0                                            ; $01D824
        move.b       ActorExitCellProfile(a0), d0                  ; $01D826
        cmpa.l       #$ffa5fa, a1                                  ; $01D82A
        bcs.b        loc_01D83A                                    ; $01D830
        cmpa.l       #$ffe5fa, a1                                  ; $01D832
        bcs.b        loc_01D840                                    ; $01D838

loc_01D83A:
        movea.l      #$ffa9fa, a1                                  ; $01D83A

loc_01D840:
        move.b       (a2, d0.w), (a1)                              ; $01D840
        move.l       a0, -(a7)                                     ; $01D844
        movea.l      a1, a0                                        ; $01D846
        bsr.w        CommitMapCellAndSendLink                      ; $01D848
        movea.l      (a7)+, a0                                     ; $01D84C
        bra.b        loc_01D856                                    ; $01D84E

loc_01D850:
        jsr          CountLegacyObjectiveFloorEnemies.l            ; $01D850

loc_01D856:
        tst.w        rLinkRole(a6)                                 ; $01D856
        beq.w        RemoveActor                                   ; $01D85A
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01D85E
        move.b       #$5, (a1)                                     ; $01D862
        move.b       ActorLinkId(a0), $1(a1)                       ; $01D866
        movem.l      d0-d7/a0-a3, -(a7)                            ; $01D86C
        movea.l      a1, a0                                        ; $01D870
        jsr          QueueLinkCommand.l                            ; $01D872
        movem.l      (a7)+, d0-d7/a0-a3                            ; $01D878
        bra.w        RemoveActor                                   ; $01D87C
        ifne *-$1D880
        fail "ROM end moved"
        endif
