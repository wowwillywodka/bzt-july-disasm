; $00D122..$00D165 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Conditionally OR the cell class nibble into packed per-cell render
; state. Suppression or a signed type >=$16 skips the write; $8D..$90
; compare negative and record their low nibble before suppression is set.
        ifne *-$D122
        fail "ROM start moved"
        endif

RecordVisibleCellRenderState:
        movem.l      d0-d7/a0-a6, -(a7)                            ; $00D122
        tst.w        rCellSideEffectsSuppressed(a6)                                    ; $00D126
        bne.b        loc_00D160                                    ; $00D12A
        movea.l      rCellRenderStateSourcePointer(a6), a0                                ; $00D12C
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
