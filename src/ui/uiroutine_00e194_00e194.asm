; $00E194..$00E1E1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Порог-триггер эффект-скрипта (тряска/рамбл): если (-0x720c,A6)>0x32 И HP(-0x720e,A6)<=0x32 — ставит в очередь 0x20ab2 пакет 0x21082; иначе если 0xF<=(-0x720c)<=0x32 И HP<0x10 — пакет 0x210aa
        ifne *-$E194
        fail "ROM start moved"
        endif

UiRoutine_00E194:
        cmpi.w       #$32, -$720c(a6)                              ; $00E194
        bhi.b        loc_00E1A6                                    ; $00E19A
        cmpi.w       #$f, -$720c(a6)                               ; $00E19C
        bhi.b        loc_00E1C4                                    ; $00E1A2
        rts                                                        ; $00E1A4

loc_00E1A6:
        cmpi.w       #$32, rPlayerHealth(a6)                       ; $00E1A6
        bhi.b        loc_00E1C2                                    ; $00E1AC
        movem.l      d0/a0-a1, -(a7)                               ; $00E1AE
        movea.l      #StatusMessageHealthConditionLow, a0          ; $00E1B2
        jsr          QueueStatusMessage.l                          ; $00E1B8
        movem.l      (a7)+, d0/a0-a1                               ; $00E1BE

loc_00E1C2:
        rts                                                        ; $00E1C2

loc_00E1C4:
        cmpi.w       #$f, rPlayerHealth(a6)                        ; $00E1C4
        bhi.b        loc_00E1C2                                    ; $00E1CA
        movem.l      d0/a0-a1, -(a7)                               ; $00E1CC
        movea.l      #StatusMessageHealthConditionCritical, a0     ; $00E1D0
        jsr          QueueStatusMessage.l                          ; $00E1D6
        movem.l      (a7)+, d0/a0-a1                               ; $00E1DC
        rts                                                        ; $00E1E0
        ifne *-$E1E2
        fail "ROM end moved"
        endif
