; $00E000..$00E023 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Диспетчер отрисовки HUD/урона: если слот (-0x6f64,A6)>=0 — jsr 0x11bba (рисует счётчик иконки), иначе временно ставит (-0x6f66,A6)=-1 и зовёт 0xE024 (применение/индикация HP, $FF0DF2), затем восстанавливает
        ifne *-$E000
        fail "ROM start moved"
        endif

UiRoutine_00E000:
        tst.w        -$6f64(a6)                                    ; $00E000
        bpl.b        loc_00E018                                    ; $00E004
        move.w       -$6f66(a6), -(a7)                             ; $00E006
        move.w       #$ffff, -$6f66(a6)                            ; $00E00A
        bsr.b        ApplyPlayerDistanceHit                        ; $00E010
        move.w       (a7)+, -$6f66(a6)                             ; $00E012
        rts                                                        ; $00E016

loc_00E018:
        move.l       a0, -(a7)                                     ; $00E018
        jsr          UiRoutine_011BBA.l                            ; $00E01A
        movea.l      (a7)+, a0                                     ; $00E020
        rts                                                        ; $00E022
        ifne *-$E024
        fail "ROM end moved"
        endif
