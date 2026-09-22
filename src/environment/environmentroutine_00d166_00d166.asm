; $00D166..$00D1A1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; July выстрел в 0x7b/7d/7f (без счётчика): 977dc → адрес render-state, ставит/чистит нибл $FF3D9E. НЕ анимация
        ifne *-$D166
        fail "ROM start moved"
        endif

EnvironmentRoutine_00D166:
        movem.l      d0-d7/a0-a6, -(a7)                            ; $00D166
        tst.w        -$715a(a6)                                    ; $00D16A
        bne.b        loc_00D19C                                    ; $00D16E
        movea.l      -$42a2(a6), a0                                ; $00D170
        lea.l        rCellTypeByIndex(a6), a5                      ; $00D174
        jsr          GetCellRenderStateAddress.l                   ; $00D178
        move.l       a0, d0                                        ; $00D17E
        andi.w       #$1, d0                                       ; $00D180
        beq.b        loc_00D194                                    ; $00D184
        andi.b       #$f0, (a1)                                    ; $00D186
        ori.b        #$1, (a1)                                     ; $00D18A
        movem.l      (a7)+, d0-d7/a0-a6                            ; $00D18E
        rts                                                        ; $00D192

loc_00D194:
        andi.b       #$f, (a1)                                     ; $00D194
        ori.b        #$10, (a1)                                    ; $00D198

loc_00D19C:
        movem.l      (a7)+, d0-d7/a0-a6                            ; $00D19C
        rts                                                        ; $00D1A0
        ifne *-$D1A2
        fail "ROM end moved"
        endif
