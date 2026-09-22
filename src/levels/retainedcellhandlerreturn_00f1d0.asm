; $00F1D0..$00F28B | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$F1D0
        fail "ROM start moved"
        endif

RetainedCellHandlerReturn:
        rts                                                        ; $00F1D0

loc_00F1D2:
        cmpi.w       #$42, -$55ae(a6)                              ; $00F1D2
        bne.b        loc_00F1F6                                    ; $00F1D8
        movem.l      d0-d7/a0-a5, -(a7)                            ; $00F1DA
        jsr          PlayPendingSequence.l                         ; $00F1DE
        move.w       rLegacyEpisodeSelection(a6), d0               ; $00F1E4
        addi.w       #$45, d0                                      ; $00F1E8
        jsr          loc_07ACE4.l                                  ; $00F1EC
        movem.l      (a7)+, d0-d7/a0-a5                            ; $00F1F2

loc_00F1F6:
        tst.w        -$6e4a(a6)                                    ; $00F1F6
        beq.b        loc_00F204                                    ; $00F1FA
        bmi.b        loc_00F20A                                    ; $00F1FC
        move.w       #$2, -$6e4a(a6)                               ; $00F1FE

loc_00F204:
        clr.w        -$6e4c(a6)                                    ; $00F204
        rts                                                        ; $00F208

loc_00F20A:
        move.w       #$fffe, -$6e4a(a6)                            ; $00F20A
        clr.w        -$6e4c(a6)                                    ; $00F210
        rts                                                        ; $00F214

loc_00F216:
        move.w       #$1b00, d2                                    ; $00F216
        cmpi.w       #$20, rCurrentFloorWidth(a6)                  ; $00F21A
        bge.b        loc_00F22A                                    ; $00F220
        move.w       rCurrentFloorWidth(a6), d2                    ; $00F222
        subq.w       #$5, d2                                       ; $00F226
        lsl.w        #$8, d2                                       ; $00F228

loc_00F22A:
        move.w       rPlayerX(a6), d0                              ; $00F22A
        cmpi.w       #$500, d0                                     ; $00F22E
        bcc.b        loc_00F23E                                    ; $00F232
        move.b       d0, d3                                        ; $00F234
        move.w       #$500, d0                                     ; $00F236
        move.b       d3, d0                                        ; $00F23A
        bra.b        loc_00F248                                    ; $00F23C

loc_00F23E:
        cmp.w        d2, d0                                        ; $00F23E
        bcs.b        loc_00F248                                    ; $00F240
        move.b       d0, d3                                        ; $00F242
        move.w       d2, d0                                        ; $00F244
        move.b       d3, d0                                        ; $00F246

loc_00F248:
        move.w       d0, -$720a(a6)                                ; $00F248
        move.w       #$1b00, d2                                    ; $00F24C
        cmpi.w       #$20, rCurrentFloorHeight(a6)                 ; $00F250
        bge.b        loc_00F260                                    ; $00F256
        move.w       rCurrentFloorHeight(a6), d2                   ; $00F258
        subq.w       #$5, d2                                       ; $00F25C
        lsl.w        #$8, d2                                       ; $00F25E

loc_00F260:
        move.w       rPlayerY(a6), d0                              ; $00F260
        cmpi.w       #$500, d0                                     ; $00F264
        bcc.b        loc_00F274                                    ; $00F268
        move.b       d0, d3                                        ; $00F26A
        move.w       #$500, d0                                     ; $00F26C
        move.b       d3, d0                                        ; $00F270
        bra.b        loc_00F27E                                    ; $00F272

loc_00F274:
        cmp.w        d2, d0                                        ; $00F274
        bcs.b        loc_00F27E                                    ; $00F276
        move.b       d0, d3                                        ; $00F278
        move.w       d2, d0                                        ; $00F27A
        move.b       d3, d0                                        ; $00F27C

loc_00F27E:
        move.w       d0, -$7208(a6)                                ; $00F27E

loc_00F282:
        tst.w        -$7ffe(a6)                                    ; $00F282
        bne.b        loc_00F282                                    ; $00F286
        bra.w        RendererRoutine_00F35A                        ; $00F288
        ifne *-$F28C
        fail "ROM end moved"
        endif
