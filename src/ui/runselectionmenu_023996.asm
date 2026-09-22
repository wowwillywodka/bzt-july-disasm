; $023996..$023B9D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Цикл меню выбора (опции/сложность): инициализирует экран (jsr $23c16), опрашивает пад ($804) и кнопки $FF002E/$FF0032, по Up/Down меняет селектор $FF2A4C с откатом, играет звук курсора (D0=$62, jsr $7ace8), перерисовывает курсор ($23cdc); по Start/выбору ставит режим $FF0874 и выходит
        ifne *-$23996
        fail "ROM start moved"
        endif

RunSelectionMenu:
        jsr          InitializeSelectionMenu.l                     ; $023996
        move.w       #$78, d6                                      ; $02399C

loc_0239A0:
        jsr          WaitForVBlank.w                               ; $0239A0
        jsr          ReadController.w                              ; $0239A4
        btst.b       #$7, ramControllerState.l                     ; $0239A8
        bne.w        loc_0239B8                                    ; $0239B0
        dbra         d6, loc_0239A0                                ; $0239B4

loc_0239B8:
        move.w       #$0, d3                                       ; $0239B8
        move.w       d3, $ff2a4c.l                                 ; $0239BC
        jsr          DrawSelectionCursor.l                         ; $0239C2
        move.w       #$c5aa, d0                                    ; $0239C8
        lea.l        JulyBuildAndTitleStrings.l, a0                ; $0239CC
        jsr          PrintCharacterMenuText.l                      ; $0239D2
        move.w       #$c730, d0                                    ; $0239D8
        lea.l        Data_023D05.l, a0                             ; $0239DC
        jsr          PrintCharacterMenuText.l                      ; $0239E2
        move.w       #$c830, d0                                    ; $0239E8
        lea.l        Data_023D0B.l, a0                             ; $0239EC
        jsr          PrintCharacterMenuText.l                      ; $0239F2
        move.w       #$384, rMenuIdleCounter(a6)                   ; $0239F8

loc_0239FE:
        jsr          WaitForVBlank.l                               ; $0239FE
        subq.w       #$1, rMenuIdleCounter(a6)                     ; $023A04
        jsr          ReadController.l                              ; $023A08
        move.w       rControllerState(a6), d0                      ; $023A0E
        andi.w       #$ff60, d0                                    ; $023A12
        beq.w        loc_023A20                                    ; $023A16
        move.w       #$384, rMenuIdleCounter(a6)                   ; $023A1A

loc_023A20:
        btst.b       #$0, ramControllerState.l                     ; $023A20
        beq.w        loc_023A8E                                    ; $023A28
        btst.b       #$0, ramPreviousControllerState.l             ; $023A2C
        bne.w        loc_023A62                                    ; $023A34

loc_023A38:
        move.w       #$62, d0                                      ; $023A38
        jsr          PlaySoundEvent.l                              ; $023A3C
        subq.w       #$1, $ff2a4c.l                                ; $023A42
        bpl.w        loc_023A54                                    ; $023A48
        move.w       #$1, $ff2a4c.l                                ; $023A4C

loc_023A54:
        move.w       $ff2a4c.l, d3                                 ; $023A54
        jsr          DrawSelectionCursor.l                         ; $023A5A
        bra.b        loc_0239FE                                    ; $023A60

loc_023A62:
        cmpi.b       #$0, $ff1058.l                                ; $023A62
        bgt.w        loc_023A7A                                    ; $023A6A
        move.b       #$14, $ff1058.l                               ; $023A6E
        bra.w        loc_023A96                                    ; $023A76

loc_023A7A:
        subq.b       #$1, $ff1058.l                                ; $023A7A
        bne.w        loc_023A96                                    ; $023A80
        move.b       #$8, $ff1058.l                                ; $023A84
        bra.b        loc_023A38                                    ; $023A8C

loc_023A8E:
        move.b       #$0, $ff1058.l                                ; $023A8E

loc_023A96:
        btst.b       #$1, ramControllerState.l                     ; $023A96
        beq.w        loc_023B0E                                    ; $023A9E
        btst.b       #$1, ramPreviousControllerState.l             ; $023AA2
        bne.w        loc_023AE2                                    ; $023AAA

loc_023AAE:
        move.w       #$62, d0                                      ; $023AAE
        jsr          PlaySoundEvent.l                              ; $023AB2
        addq.w       #$1, $ff2a4c.l                                ; $023AB8
        cmpi.w       #$1, $ff2a4c.l                                ; $023ABE
        ble.w        loc_023AD2                                    ; $023AC6
        move.w       #$0, $ff2a4c.l                                ; $023ACA

loc_023AD2:
        move.w       $ff2a4c.l, d3                                 ; $023AD2
        jsr          DrawSelectionCursor.l                         ; $023AD8
        bra.w        loc_0239FE                                    ; $023ADE

loc_023AE2:
        cmpi.b       #$0, $ff1059.l                                ; $023AE2
        bgt.w        loc_023AFA                                    ; $023AEA
        move.b       #$14, $ff1059.l                               ; $023AEE
        bra.w        loc_023B16                                    ; $023AF6

loc_023AFA:
        subq.b       #$1, $ff1059.l                                ; $023AFA
        bne.w        loc_023B16                                    ; $023B00
        move.b       #$8, $ff1059.l                                ; $023B04
        bra.b        loc_023AAE                                    ; $023B0C

loc_023B0E:
        move.b       #$0, $ff1059.l                                ; $023B0E

loc_023B16:
        btst.b       #$6, ramControllerState.l                     ; $023B16
        beq.w        loc_023B2E                                    ; $023B1E
        btst.b       #$6, ramPreviousControllerState.l             ; $023B22
        beq.w        loc_023B76                                    ; $023B2A

loc_023B2E:
        btst.b       #$4, ramControllerState.l                     ; $023B2E
        beq.w        loc_023B46                                    ; $023B36
        btst.b       #$4, ramPreviousControllerState.l             ; $023B3A
        beq.w        loc_023B76                                    ; $023B42

loc_023B46:
        btst.b       #$5, ramControllerState.l                     ; $023B46
        beq.w        loc_023B5E                                    ; $023B4E
        btst.b       #$5, ramPreviousControllerState.l             ; $023B52
        beq.w        loc_023B76                                    ; $023B5A

loc_023B5E:
        btst.b       #$7, ramControllerState.l                     ; $023B5E
        beq.w        loc_023B9A                                    ; $023B66
        btst.b       #$7, ramPreviousControllerState.l             ; $023B6A
        bne.w        loc_023B9A                                    ; $023B72

loc_023B76:
        cmpi.w       #$0, $ff2a4c.l                                ; $023B76
        beq.w        loc_023B8C                                    ; $023B7E
        move.w       #$2, $ff0874.l                                ; $023B82
        rts                                                        ; $023B8A

loc_023B8C:
        move.w       #$1, $ff0874.l                                ; $023B8C
        clr.w        rDemoMode(a6)                                 ; $023B94
        rts                                                        ; $023B98

loc_023B9A:
        bra.w        loc_0239FE                                    ; $023B9A
        ifne *-$23B9E
        fail "ROM end moved"
        endif
