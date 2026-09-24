; $00D1A2..$00D1D5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; July выстрел в 0x79: ++счётчик прогресса (-0x71ca,a6) [читается 0x3570/0x35c0 → текст «X/Y» через 0x29330] + 977dc→адрес пер-клеточного render-state ($FF3D9E), чистит нибл (отметка «клетка обработана»). НЕ анимация открытия (стена исчезает сразу)
        ifne *-$D1A2
        fail "ROM start moved"
        endif

CountAndClearObjectiveCellRenderState:
        movem.l      d0-d7/a0-a6, -(a7)                            ; $00D1A2
        tst.w        rCellSideEffectsSuppressed(a6)                                    ; $00D1A6
        bne.b        loc_00D1D0                                    ; $00D1AA
        addq.w       #$1, rObjectiveProgressCount(a6)                               ; $00D1AC
        movea.l      rCellRenderStateSourcePointer(a6), a0                                ; $00D1B0
        jsr          GetCellRenderStateAddress.l                   ; $00D1B4
        move.l       a0, d0                                        ; $00D1BA
        andi.w       #$1, d0                                       ; $00D1BC
        beq.b        loc_00D1CC                                    ; $00D1C0
        andi.b       #$f0, (a1)                                    ; $00D1C2
        movem.l      (a7)+, d0-d7/a0-a6                            ; $00D1C6
        rts                                                        ; $00D1CA

loc_00D1CC:
        andi.b       #$f, (a1)                                     ; $00D1CC

loc_00D1D0:
        movem.l      (a7)+, d0-d7/a0-a6                            ; $00D1D0
        rts                                                        ; $00D1D4
        ifne *-$D1D6
        fail "ROM end moved"
        endif
