; $021746..$02176B | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Построение UI/меню-экрана: подготовка плоскостей (0x2176c), отрисовка элемента (0x21784), задержка кадров #0x78 (0x21db0) и вывод тайлов из таблицы @0x223f0 (0x22018)
        ifne *-$21746
        fail "ROM start moved"
        endif

RunRetainedScreenPresentation:
        jsr          ClearVideoAndSetScrollMinus16.l                         ; $021746
        jsr          PlayRetainedScreenPageSequence.l                            ; $02174C
        move.w       #$78, d0                                      ; $021752
        jsr          WaitVBlankFrames.l                            ; $021756
        lea.l        RunMissionSelection.l, a0                     ; $02175C
        moveq        #$5, d1                                       ; $021762
        jsr          FadeFullPaletteToBlack.l                         ; $021764
        rts                                                        ; $02176A
        ifne *-$2176C
        fail "ROM end moved"
        endif
