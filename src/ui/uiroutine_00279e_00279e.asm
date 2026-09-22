; $00279E..$0027DF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Расчёт параметров мигающего HUD-маркера: пишет D0→-$6f4c, $d0→-$6f4a; если флаг -$6f56 и |X(-$6f50)-$120|<$40 (близко к центру) — взводит -$6f4e=1, -$6f4d=$10, -$6f52=$14, иначе -$6f4e=0, -$6f4d=8
        ifne *-$279E
        fail "ROM start moved"
        endif

UiRoutine_00279E:
        move.w       d0, -$6f4c(a6)                                ; $00279E
        move.w       #$d0, -$6f4a(a6)                              ; $0027A2
        tst.b        -$6f56(a6)                                    ; $0027A8
        beq.b        loc_0027D4                                    ; $0027AC
        move.w       -$6f50(a6), d1                                ; $0027AE
        subi.w       #$120, d1                                     ; $0027B2
        bpl.b        loc_0027BA                                    ; $0027B6
        neg.w        d1                                            ; $0027B8

loc_0027BA:
        cmpi.w       #$40, d1                                      ; $0027BA
        bcc.b        loc_0027D4                                    ; $0027BE
        move.b       #$1, -$6f4e(a6)                               ; $0027C0
        move.b       #$10, -$6f4d(a6)                              ; $0027C6
        move.b       #$14, -$6f52(a6)                              ; $0027CC
        rts                                                        ; $0027D2

loc_0027D4:
        clr.b        -$6f4e(a6)                                    ; $0027D4
        move.b       #$8, -$6f4d(a6)                               ; $0027D8
        rts                                                        ; $0027DE
        ifne *-$27E0
        fail "ROM end moved"
        endif
