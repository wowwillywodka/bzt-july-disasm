; $022EB4..$022F17 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Инициализация анимированного звёздного фона/титульного экрана: ставит флаг (-0x778c), обнуляет счётчики скролла (-0x76e0..-0x7784), грузит указатели на скрипты движения ($22fc6/$22fd6) и градиента ($23336), затем DMA-fill VRAM нулями через $C00000 (0xC0 лонгов)
        ifne *-$22EB4
        fail "ROM start moved"
        endif

UiRoutine_022EB4:
        tst.w        -$778c(a6)                                    ; $022EB4
        bne.b        loc_022EC0                                    ; $022EB8
        move.w       #$1, -$778c(a6)                               ; $022EBA

loc_022EC0:
        clr.w        -$76e0(a6)                                    ; $022EC0
        clr.w        -$76de(a6)                                    ; $022EC4
        clr.w        -$76dc(a6)                                    ; $022EC8
        clr.w        -$7786(a6)                                    ; $022ECC
        clr.w        -$7784(a6)                                    ; $022ED0
        move.l       #TitleScrollWordSequences, -$7782(a6)         ; $022ED4
        move.l       #$22fd6, -$777e(a6)                           ; $022EDC
        move.l       #TitleAnimationCurves, -$777a(a6)             ; $022EE4
        move.l       #TitleAnimationCurves, -$7776(a6)             ; $022EEC
        move.l       #$60000003, VDP_CONTROL.l                     ; $022EF4
        move.w       #$bf, d7                                      ; $022EFE
        moveq        #$0, d6                                       ; $022F02
        movea.l      #VDP_DATA, a4                                 ; $022F04

loc_022F0A:
        move.l       d6, (a4)                                      ; $022F0A
        move.l       d6, (a4)                                      ; $022F0C
        move.l       d6, (a4)                                      ; $022F0E
        move.l       d6, (a4)                                      ; $022F10
        dbra         d7, loc_022F0A                                ; $022F12
        rts                                                        ; $022F16
        ifne *-$22F18
        fail "ROM end moved"
        endif
