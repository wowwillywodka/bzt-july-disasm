; $00D122..$00D165 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Установка флага ориентации/видимости грани: по байту клетки (A0) индексирует таблицу типов (0x24ea,a6), при типе <0x16 вызывает 0x977dc и пишет нибблами признак стороны (or.b в (A1)) для последующего рендера грани
        ifne *-$D122
        fail "ROM start moved"
        endif

RendererRoutine_00D122:
        movem.l      d0-d7/a0-a6, -(a7)                            ; $00D122
        tst.w        -$715a(a6)                                    ; $00D126
        bne.b        loc_00D160                                    ; $00D12A
        movea.l      -$42a2(a6), a0                                ; $00D12C
        clr.w        d4                                            ; $00D130
        move.b       (a0), d4                                      ; $00D132
        lea.l        rCellTypeByIndex(a6), a5                      ; $00D134
        move.b       (a5, d4.w), d4                                ; $00D138
        cmpi.b       #$16, d4                                      ; $00D13C
        bge.b        loc_00D160                                    ; $00D140
        jsr          GetCellRenderStateAddress.l                   ; $00D142
        andi.b       #$f, d4                                       ; $00D148
        move.l       a0, d0                                        ; $00D14C
        andi.w       #$1, d0                                       ; $00D14E
        beq.b        loc_00D15C                                    ; $00D152
        or.b         d4, (a1)                                      ; $00D154
        movem.l      (a7)+, d0-d7/a0-a6                            ; $00D156
        rts                                                        ; $00D15A

loc_00D15C:
        lsl.w        #$4, d4                                       ; $00D15C
        or.b         d4, (a1)                                      ; $00D15E

loc_00D160:
        movem.l      (a7)+, d0-d7/a0-a6                            ; $00D160
        rts                                                        ; $00D164
        ifne *-$D166
        fail "ROM end moved"
        endif
