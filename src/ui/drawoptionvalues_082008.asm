; $082008..$082081 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Вывод текущих значений всех пунктов меню опций: печатает метку режима ($FF0016: 0x8223d/0x8224e), состояние двух звуковых флагов $FF0014.0/$FF0014.1 (ON/OFF строки 0x8225e/0x82262) через 0x7b552 и выводит уровень громкости музыки вызовом 0x82082
        ifne *-$82008
        fail "ROM start moved"
        endif

DrawOptionValues:
        move.w       #$c328, d0                                    ; $082008
        lea.l        ramPasswordSavedText.l, a0                                 ; $08200C
        jsr          PrintCharacterMenuText(pc)                    ; $082012
        lea.l        Data_08223D.l, a0                             ; $082016
        cmpi.w       #$0, ramGameOptions.l                         ; $08201C
        beq.w        loc_08202E                                    ; $082024
        lea.l        Data_08224E.l, a0                             ; $082028

loc_08202E:
        move.w       #$c426, d0                                    ; $08202E
        jsr          PrintCharacterMenuText(pc)                    ; $082032
        move.w       #$c522, d0                                    ; $082036
        lea.l        Data_08225E.l, a0                             ; $08203A
        move.w       ramSoundOptions.l, d1                         ; $082040
        btst.l       #$0, d1                                       ; $082046
        beq.w        loc_082054                                    ; $08204A
        lea.l        Data_082262.l, a0                             ; $08204E

loc_082054:
        jsr          PrintCharacterMenuText(pc)                    ; $082054
        move.w       #$c622, d0                                    ; $082058
        lea.l        Data_08225E.l, a0                             ; $08205C
        move.w       ramSoundOptions.l, d1                         ; $082062
        btst.l       #$1, d1                                       ; $082068
        beq.w        loc_082076                                    ; $08206C
        lea.l        Data_082262.l, a0                             ; $082070

loc_082076:
        jsr          PrintCharacterMenuText(pc)                    ; $082076
        jsr          DrawMusicVolumeHex.l                          ; $08207A
        rts                                                        ; $082080
        ifne *-$82082
        fail "ROM end moved"
        endif
