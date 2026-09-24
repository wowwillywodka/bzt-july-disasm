; $009208..$009237 | m68k
; Cell type $30: build all four face-height profiles from the current
; state byte after MarkCellRenderStateAfterHit. Independent table entry.
        ifne *-$9208
        fail "ROM start moved"
        endif

BuildCellType30FaceProfile:
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $009208
        bsr.w        MarkCellRenderStateAfterHit                     ; $00920C
        move.b       rTransitHeightOffsetLow(a6), d3                                ; $009210
        bset.l       #$0, d3                                       ; $009214
        lsl.w        #$8, d3                                       ; $009218
        move.b       rTransitHeightOffsetLow(a6), d3                                ; $00921A
        bset.l       #$0, d3                                       ; $00921E
        move.w       d3, rWallFaceHeightProfile0(a6)                                ; $009222
        move.w       d3, rWallFaceHeightProfile1(a6)                                ; $009226
        move.w       d3, rWallFaceHeightProfile2(a6)                                ; $00922A
        move.w       d3, rWallFaceHeightProfile3(a6)                                ; $00922E
        move.w       #$1, d3                                       ; $009232
        rts                                                        ; $009236
        ifne *-$9238
        fail "ROM end moved"
        endif
