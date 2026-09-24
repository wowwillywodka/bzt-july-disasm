; $0118CC..$0119B9 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Обновление иконки по индексу (-0x6f6c,A6): vblank-wait, при счётчике >0x100 декрементит и jmp 0x20944 (рисует число); иначе очищает тайл иконки нулями в VRAM, убирает слот и пересканирует массив (-0x6fa0,A6) на маркер 0x9, выставляя новый текущий индекс (-0x6f6c,A6) или -1
        ifne *-$118CC
        fail "ROM start moved"
        endif

TickNightVisionItemAndUpdateIcon:
        tst.w        rVBlankTransferPhasesRemaining(a6)                                    ; $0118CC
        bne.b        TickNightVisionItemAndUpdateIcon                              ; $0118D0
        move.w       rNightVisionInventorySlotIndex(a6), d0                                ; $0118D2
        lsl.w        #$8, d0                                       ; $0118D6
        lsl.w        #$1, d0                                       ; $0118D8
        addi.w       #$93e0, d0                                    ; $0118DA
        move.w       d0, d5                                        ; $0118DE
        movea.l      #VDP_DATA, a4                                 ; $0118E0
        lea.l        rInventorySlots(a6), a0                       ; $0118E6
        move.w       rNightVisionInventorySlotIndex(a6), d0                                ; $0118EA
        mulu.w       #$4, d0                                       ; $0118EE
        cmpi.w       #$100, $2(a0, d0.w)                           ; $0118F2
        bls.b        loc_011930                                    ; $0118F8
        subi.w       #$100, $2(a0, d0.w)                           ; $0118FA
        move.w       $2(a0, d0.w), -(a7)                           ; $011900
        move.w       d5, d0                                        ; $011904
        addi.w       #$68, d0                                      ; $011906
        move.w       d0, d1                                        ; $01190A
        andi.w       #$3fff, d1                                    ; $01190C
        ori.w        #$4000, d1                                    ; $011910
        swap         d1                                            ; $011914
        lsr.w        #$8, d0                                       ; $011916
        lsr.w        #$6, d0                                       ; $011918
        move.w       d0, d1                                        ; $01191A
        move.l       d1, VDP_CONTROL.l                             ; $01191C
        move.w       (a7)+, d0                                     ; $011922
        subq.w       #$1, d0                                       ; $011924
        lsr.w        #$8, d0                                       ; $011926
        addq.w       #$1, d0                                       ; $011928
        jmp          DrawInventoryQuantityDigits.l                            ; $01192A

loc_011930:
        move.w       #$1, rInventorySlotDepletionFlag(a6)                               ; $011930
        clr.w        (a0, d0.w)                                    ; $011936
        clr.w        $2(a0, d0.w)                                  ; $01193A
        subq.b       #$1, rOccupiedInventorySlotCount(a6)          ; $01193E
        move.w       #$f, d6                                       ; $011942
        moveq        #$0, d7                                       ; $011946
        move.w       d5, d0                                        ; $011948
        move.w       d0, d1                                        ; $01194A
        andi.w       #$3fff, d1                                    ; $01194C
        ori.w        #$4000, d1                                    ; $011950
        swap         d1                                            ; $011954
        lsr.w        #$8, d0                                       ; $011956
        lsr.w        #$6, d0                                       ; $011958
        move.w       d0, d1                                        ; $01195A
        move.l       d1, VDP_CONTROL.l                             ; $01195C

loc_011962:
        move.l       d7, (a4)                                      ; $011962
        move.l       d7, (a4)                                      ; $011964
        move.l       d7, (a4)                                      ; $011966
        move.l       d7, (a4)                                      ; $011968
        move.l       d7, (a4)                                      ; $01196A
        move.l       d7, (a4)                                      ; $01196C
        move.l       d7, (a4)                                      ; $01196E
        move.l       d7, (a4)                                      ; $011970
        dbra         d6, loc_011962                                ; $011972
        lea.l        rInventorySlots(a6), a0                       ; $011976
        clr.w        d7                                            ; $01197A
        cmpi.w       #$9, (a0)                                     ; $01197C
        beq.b        loc_0119B4                                    ; $011980
        addq.w       #$4, a0                                       ; $011982
        addq.w       #$1, d7                                       ; $011984
        cmpi.w       #$9, (a0)                                     ; $011986
        beq.b        loc_0119B4                                    ; $01198A
        addq.w       #$4, a0                                       ; $01198C
        addq.w       #$1, d7                                       ; $01198E
        cmpi.w       #$9, (a0)                                     ; $011990
        beq.b        loc_0119B4                                    ; $011994
        addq.w       #$4, a0                                       ; $011996
        addq.w       #$1, d7                                       ; $011998
        cmpi.w       #$9, (a0)                                     ; $01199A
        beq.b        loc_0119B4                                    ; $01199E
        addq.w       #$4, a0                                       ; $0119A0
        addq.w       #$1, d7                                       ; $0119A2
        cmpi.w       #$9, (a0)                                     ; $0119A4
        beq.b        loc_0119B4                                    ; $0119A8
        move.w       #$ffff, rNightVisionInventorySlotIndex(a6)                            ; $0119AA
        bra.w        RestoreScenePaletteAndColorMode                              ; $0119B0

loc_0119B4:
        move.w       d7, rNightVisionInventorySlotIndex(a6)                                ; $0119B4
        rts                                                        ; $0119B8
        ifne *-$119BA
        fail "ROM end moved"
        endif
