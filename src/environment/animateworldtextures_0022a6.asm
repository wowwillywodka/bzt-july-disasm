; $0022A6..$0022ED | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Драйвер анимации тайлов/палитры: addq (-0x7120,A6) счётчик кадров, A0=(0x29fc,A6) таблица аним-скриптов, A1=(0xcea,A6) приёмник; декремент таймера $2(a0), при 0 перезагрузка из $3(a0), переход по оффсету $4(a0) к скрипту A2, копирование слов (A2)+→(A1+d0) до отрицательного терминатора, шаг d3; финал jsr 0x15002
        ifne *-$22A6
        fail "ROM start moved"
        endif

AnimateWorldTextures:
        addq.w       #$1, rGameTick(a6)                            ; $0022A6
        move.w       rGameTick(a6), d0                             ; $0022AA
        lea.l        rTextureAnimationRecords(a6), a0              ; $0022AE
        lea.l        rTextureDefinitions(a6), a1                   ; $0022B2

loc_0022B6:
        move.w       (a0), d3                                      ; $0022B6
        beq.w        loc_0022E6                                    ; $0022B8
        subq.b       #$1, $2(a0)                                   ; $0022BC
        bne.w        loc_0022E0                                    ; $0022C0
        move.b       $3(a0), $2(a0)                                ; $0022C4
        move.w       $4(a0), d0                                    ; $0022CA
        lea.l        (a0, d0.w), a2                                ; $0022CE

loc_0022D2:
        move.w       (a2)+, d0                                     ; $0022D2
        bmi.b        loc_0022DC                                    ; $0022D4
        move.w       (a2)+, (a1, d0.w)                             ; $0022D6
        bra.b        loc_0022D2                                    ; $0022DA

loc_0022DC:
        move.w       (a2)+, $4(a0)                                 ; $0022DC

loc_0022E0:
        lea.l        (a0, d3.w), a0                                ; $0022E0
        bra.b        loc_0022B6                                    ; $0022E4

loc_0022E6:
        jsr          UpdateEnemyReleaseWalls.l                     ; $0022E6
        rts                                                        ; $0022EC
        ifne *-$22EE
        fail "ROM end moved"
        endif
