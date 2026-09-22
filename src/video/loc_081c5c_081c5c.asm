; $081C5C..$081F05 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$81C5C
        fail "ROM start moved"
        endif

loc_081C5C:
        jsr          InitializeOptionsScreen.l                     ; $081C5C

loc_081C62:
        jsr          WaitForVBlank.l                               ; $081C62
        jsr          ReadController.l                              ; $081C68
        btst.b       #$0, ramControllerState.l                     ; $081C6E
        beq.w        loc_081CDA                                    ; $081C76
        btst.b       #$0, ramPreviousControllerState.l             ; $081C7A
        bne.w        loc_081CAE                                    ; $081C82

loc_081C86:
        move.w       #$62, d0                                      ; $081C86
        jsr          PlaySoundEvent(pc)                            ; $081C8A
        subq.w       #$1, $ff2a4c.l                                ; $081C8E
        bpl.w        loc_081CA0                                    ; $081C94
        move.w       #$5, $ff2a4c.l                                ; $081C98

loc_081CA0:
        move.w       $ff2a4c.l, d3                                 ; $081CA0
        jsr          DrawOptionsCursor.l                           ; $081CA6
        bra.b        loc_081C62                                    ; $081CAC

loc_081CAE:
        cmpi.b       #$0, $ff1058.l                                ; $081CAE
        bgt.w        loc_081CC6                                    ; $081CB6
        move.b       #$14, $ff1058.l                               ; $081CBA
        bra.w        loc_081CE2                                    ; $081CC2

loc_081CC6:
        subq.b       #$1, $ff1058.l                                ; $081CC6
        bne.w        loc_081CE2                                    ; $081CCC
        move.b       #$8, $ff1058.l                                ; $081CD0
        bra.b        loc_081C86                                    ; $081CD8

loc_081CDA:
        move.b       #$0, $ff1058.l                                ; $081CDA

loc_081CE2:
        btst.b       #$1, ramControllerState.l                     ; $081CE2
        beq.w        loc_081D58                                    ; $081CEA
        btst.b       #$1, ramPreviousControllerState.l             ; $081CEE
        bne.w        loc_081D2C                                    ; $081CF6

loc_081CFA:
        move.w       #$62, d0                                      ; $081CFA
        jsr          PlaySoundEvent(pc)                            ; $081CFE
        addq.w       #$1, $ff2a4c.l                                ; $081D02
        cmpi.w       #$5, $ff2a4c.l                                ; $081D08
        ble.w        loc_081D1C                                    ; $081D10
        move.w       #$0, $ff2a4c.l                                ; $081D14

loc_081D1C:
        move.w       $ff2a4c.l, d3                                 ; $081D1C
        jsr          DrawOptionsCursor.l                           ; $081D22
        bra.w        loc_081C62                                    ; $081D28

loc_081D2C:
        cmpi.b       #$0, $ff1059.l                                ; $081D2C
        bgt.w        loc_081D44                                    ; $081D34
        move.b       #$14, $ff1059.l                               ; $081D38
        bra.w        loc_081D60                                    ; $081D40

loc_081D44:
        subq.b       #$1, $ff1059.l                                ; $081D44
        bne.w        loc_081D60                                    ; $081D4A
        move.b       #$8, $ff1059.l                                ; $081D4E
        bra.b        loc_081CFA                                    ; $081D56

loc_081D58:
        move.b       #$0, $ff1059.l                                ; $081D58

loc_081D60:
        btst.b       #$6, ramControllerState.l                     ; $081D60
        beq.w        loc_081D78                                    ; $081D68
        btst.b       #$6, ramPreviousControllerState.l             ; $081D6C
        beq.w        loc_081DA8                                    ; $081D74

loc_081D78:
        btst.b       #$4, ramControllerState.l                     ; $081D78
        beq.w        loc_081D90                                    ; $081D80
        btst.b       #$4, ramPreviousControllerState.l             ; $081D84
        beq.w        loc_081DA8                                    ; $081D8C

loc_081D90:
        btst.b       #$5, ramControllerState.l                     ; $081D90
        beq.w        loc_081DD2                                    ; $081D98
        btst.b       #$5, ramPreviousControllerState.l             ; $081D9C
        bne.w        loc_081DD2                                    ; $081DA4

loc_081DA8:
        cmpi.w       #$4, $ff2a4c.l                                ; $081DA8
        beq.w        loc_081DC8                                    ; $081DB0
        cmpi.w       #$5, $ff2a4c.l                                ; $081DB4
        beq.w        loc_081EDE                                    ; $081DBC
        move.w       #$62, d0                                      ; $081DC0
        jsr          PlaySoundEvent(pc)                            ; $081DC4

loc_081DC8:
        jsr          ApplySelectedOption.l                         ; $081DC8
        bra.w        loc_081C62                                    ; $081DCE

loc_081DD2:
        cmpi.w       #$4, $ff2a4c.l                                ; $081DD2
        bne.w        loc_081EBE                                    ; $081DDA
        btst.b       #$2, ramControllerState.l                     ; $081DDE
        beq.w        loc_081E46                                    ; $081DE6
        btst.b       #$2, ramPreviousControllerState.l             ; $081DEA
        bne.w        loc_081E1A                                    ; $081DF2

loc_081DF6:
        move.w       #$62, d0                                      ; $081DF6
        jsr          PlaySoundEvent(pc)                            ; $081DFA
        subq.w       #$1, $ff2a4e.l                                ; $081DFE
        bpl.w        loc_081E10                                    ; $081E04
        move.w       #$99, $ff2a4e.l                               ; $081E08

loc_081E10:
        jsr          DrawMusicVolumeHex.l                          ; $081E10
        bra.w        loc_081C62                                    ; $081E16

loc_081E1A:
        cmpi.b       #$0, $ff1057.l                                ; $081E1A
        bgt.w        loc_081E32                                    ; $081E22
        move.b       #$14, $ff1057.l                               ; $081E26
        bra.w        loc_081E4E                                    ; $081E2E

loc_081E32:
        subq.b       #$1, $ff1057.l                                ; $081E32
        bne.w        loc_081E4E                                    ; $081E38
        move.b       #$8, $ff1057.l                                ; $081E3C
        bra.b        loc_081DF6                                    ; $081E44

loc_081E46:
        move.b       #$0, $ff1057.l                                ; $081E46

loc_081E4E:
        btst.b       #$3, ramControllerState.l                     ; $081E4E
        beq.w        loc_081EBE                                    ; $081E56
        btst.b       #$3, ramPreviousControllerState.l             ; $081E5A
        bne.w        loc_081E92                                    ; $081E62

loc_081E66:
        move.w       #$62, d0                                      ; $081E66
        jsr          PlaySoundEvent(pc)                            ; $081E6A
        addq.w       #$1, $ff2a4e.l                                ; $081E6E
        cmpi.w       #$99, $ff2a4e.l                               ; $081E74
        ble.w        loc_081E88                                    ; $081E7C
        move.w       #$0, $ff2a4e.l                                ; $081E80

loc_081E88:
        jsr          DrawMusicVolumeHex.l                          ; $081E88
        bra.w        loc_081C62                                    ; $081E8E

loc_081E92:
        cmpi.b       #$0, $ff1056.l                                ; $081E92
        bgt.w        loc_081EAA                                    ; $081E9A
        move.b       #$14, $ff1056.l                               ; $081E9E
        bra.w        loc_081EC6                                    ; $081EA6

loc_081EAA:
        subq.b       #$1, $ff1056.l                                ; $081EAA
        bne.w        loc_081EC6                                    ; $081EB0
        move.b       #$8, $ff1056.l                                ; $081EB4
        bra.b        loc_081E66                                    ; $081EBC

loc_081EBE:
        move.b       #$0, $ff1056.l                                ; $081EBE

loc_081EC6:
        btst.b       #$7, ramControllerState.l                     ; $081EC6
        beq.w        loc_081C62                                    ; $081ECE
        btst.b       #$7, ramPreviousControllerState.l             ; $081ED2
        bne.w        loc_081C62                                    ; $081EDA

loc_081EDE:
        cmpi.w       #$5, $ff2a4c.l                                ; $081EDE
        bne.w        loc_081C62                                    ; $081EE6
        jsr          SoundRoutine_07A990(pc)                       ; $081EEA
        move.w       ramSoundOptions.l, d0                         ; $081EEE
        btst.l       #$0, d0                                       ; $081EF4
        beq.w        loc_081F04                                    ; $081EF8
        move.w       #$41, d0                                      ; $081EFC
        jsr          loc_07ACE4(pc)                                ; $081F00

loc_081F04:
        rts                                                        ; $081F04
        ifne *-$81F06
        fail "ROM end moved"
        endif
