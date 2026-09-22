; $0820C2..$08220F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Применение выбора пункта меню опций (диспетчер по $FF2A4C 0..4): 0=сброс/выход (0xc08,0x29550 экран имени,0x81f06), 1=переключение режима $FF0016, 2/3=вкл/выкл звуковых флагов $FF0014.0/.1 с GEMS-командой 0x7a990, 4=предпрослушка музыки треком $FF2A4E через 0x7ace8; перерисовывает соответствующую метку 0x7b552
        ifne *-$820C2
        fail "ROM start moved"
        endif

ApplySelectedOption:
        cmpi.w       #$0, $ff2a4c.l                                ; $0820C2
        beq.w        loc_082100                                    ; $0820CA
        cmpi.w       #$1, $ff2a4c.l                                ; $0820CE
        beq.w        loc_08211E                                    ; $0820D6
        cmpi.w       #$2, $ff2a4c.l                                ; $0820DA
        beq.w        loc_08215E                                    ; $0820E2
        cmpi.w       #$3, $ff2a4c.l                                ; $0820E6
        beq.w        loc_0821B2                                    ; $0820EE
        cmpi.w       #$4, $ff2a4c.l                                ; $0820F2
        beq.w        loc_0821E8                                    ; $0820FA
        rts                                                        ; $0820FE

loc_082100:
        jsr          InitializeVdpRegisters.w                      ; $082100
        jsr          RunPasswordEntry.l                            ; $082104
        jsr          InitializeOptionsScreen(pc)                   ; $08210A
        move.w       #$c328, d0                                    ; $08210E
        lea.l        $ff000a.l, a0                                 ; $082112
        jsr          PrintCharacterMenuText(pc)                    ; $082118
        rts                                                        ; $08211C

loc_08211E:
        cmpi.w       #$1, ramGameOptions.l                         ; $08211E
        beq.w        loc_082136                                    ; $082126
        move.w       #$1, ramGameOptions.l                         ; $08212A
        bra.w        loc_08213C                                    ; $082132

loc_082136:
        clr.w        ramGameOptions.l                              ; $082136

loc_08213C:
        lea.l        Data_08223D.l, a0                             ; $08213C
        cmpi.w       #$0, ramGameOptions.l                         ; $082142
        beq.w        loc_082154                                    ; $08214A
        lea.l        Data_08224E.l, a0                             ; $08214E

loc_082154:
        move.w       #$c426, d0                                    ; $082154
        jsr          PrintCharacterMenuText(pc)                    ; $082158
        rts                                                        ; $08215C

loc_08215E:
        move.w       ramSoundOptions.l, d0                         ; $08215E
        btst.l       #$0, d0                                       ; $082164
        beq.w        loc_082182                                    ; $082168
        move.w       d0, -(a7)                                     ; $08216C
        jsr          SoundRoutine_07A990(pc)                       ; $08216E
        move.w       (a7)+, d0                                     ; $082172
        bclr.l       #$0, d0                                       ; $082174
        lea.l        Data_08225E.l, a0                             ; $082178
        bra.w        loc_08218C                                    ; $08217E

loc_082182:
        bset.l       #$0, d0                                       ; $082182
        lea.l        Data_082262.l, a0                             ; $082186

loc_08218C:
        move.w       d0, ramSoundOptions.l                         ; $08218C
        move.w       #$c522, d0                                    ; $082192
        jsr          PrintCharacterMenuText(pc)                    ; $082196
        move.w       ramSoundOptions.l, d0                         ; $08219A
        btst.l       #$0, d0                                       ; $0821A0
        beq.w        loc_0821B0                                    ; $0821A4
        move.w       #$41, d0                                      ; $0821A8
        jsr          loc_07ACE4(pc)                                ; $0821AC

loc_0821B0:
        rts                                                        ; $0821B0

loc_0821B2:
        move.w       ramSoundOptions.l, d0                         ; $0821B2
        btst.l       #$1, d0                                       ; $0821B8
        beq.w        loc_0821CE                                    ; $0821BC
        bclr.l       #$1, d0                                       ; $0821C0
        lea.l        Data_08225E.l, a0                             ; $0821C4
        bra.w        loc_0821D8                                    ; $0821CA

loc_0821CE:
        bset.l       #$1, d0                                       ; $0821CE
        lea.l        Data_082262.l, a0                             ; $0821D2

loc_0821D8:
        move.w       d0, ramSoundOptions.l                         ; $0821D8
        move.w       #$c622, d0                                    ; $0821DE
        jsr          PrintCharacterMenuText(pc)                    ; $0821E2
        rts                                                        ; $0821E6

loc_0821E8:
        jsr          SoundRoutine_07A990(pc)                       ; $0821E8
        move.w       ramSoundOptions.l, d0                         ; $0821EC
        move.w       d0, -(a7)                                     ; $0821F2
        move.w       #$f, ramSoundOptions.l                        ; $0821F4
        move.w       $ff2a4e.l, d0                                 ; $0821FC
        jsr          PlaySoundEvent(pc)                            ; $082202
        move.w       (a7)+, d0                                     ; $082206
        move.w       d0, ramSoundOptions.l                         ; $082208
        rts                                                        ; $08220E
        ifne *-$82210
        fail "ROM end moved"
        endif
