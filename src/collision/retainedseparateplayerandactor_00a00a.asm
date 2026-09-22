; $00A00A..$00A0C5 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$A00A
        fail "ROM start moved"
        endif

RetainedSeparatePlayerAndActor:
        movea.l      #$0, a0                                       ; $00A00A
        move.w       #$14, d5                                      ; $00A010
        jsr          EnemiesRoutine_01E4FA.l                       ; $00A014
        cmpa.l       #$ffffffff, a1                                ; $00A01A
        beq.w        loc_00A0C4                                    ; $00A020
        cmpi.w       #$38, d6                                      ; $00A024
        bcc.w        loc_00A0C4                                    ; $00A028
        move.w       rPlayerX(a6), d0                              ; $00A02C
        sub.w        $24(a1), d0                                   ; $00A030
        move.w       rPlayerY(a6), d1                              ; $00A034
        sub.w        $26(a1), d1                                   ; $00A038
        addq.w       #$1, d6                                       ; $00A03C
        lsl.w        #$5, d0                                       ; $00A03E
        ext.l        d0                                            ; $00A040
        lsl.w        #$5, d1                                       ; $00A042
        ext.l        d1                                            ; $00A044
        divs.w       d6, d0                                        ; $00A046
        divs.w       d6, d1                                        ; $00A048
        move.w       rPlayerX(a6), d7                              ; $00A04A
        add.w        $24(a1), d7                                   ; $00A04E
        asr.w        #$1, d7                                       ; $00A052
        move.w       d7, d4                                        ; $00A054
        add.w        d0, d7                                        ; $00A056
        sub.w        d0, d4                                        ; $00A058
        move.w       rPlayerY(a6), d5                              ; $00A05A
        add.w        $26(a1), d5                                   ; $00A05E
        asr.w        #$1, d5                                       ; $00A062
        move.w       d5, d6                                        ; $00A064
        add.w        d1, d5                                        ; $00A066
        sub.w        d1, d6                                        ; $00A068
        movea.l      rVisibleMapBasePointer(a6), a0                ; $00A06A
        lea.l        rCellTypeByIndex(a6), a5                      ; $00A06E
        clr.w        d2                                            ; $00A072
        move.w       d7, d0                                        ; $00A074
        asr.w        #$8, d0                                       ; $00A076
        adda.w       d0, a0                                        ; $00A078
        move.w       d5, d0                                        ; $00A07A
        clr.b        d0                                            ; $00A07C
        asr.w        #$3, d0                                       ; $00A07E
        clr.w        d3                                            ; $00A080
        move.b       (a0, d0.w), d3                                ; $00A082
        move.b       (a5, d3.w), d3                                ; $00A086
        bsr.w        GetCellCollisionClass                         ; $00A08A
        bne.b        loc_00A098                                    ; $00A08E
        move.w       d7, rPlayerX(a6)                              ; $00A090
        move.w       d5, rPlayerY(a6)                              ; $00A094

loc_00A098:
        movea.l      rVisibleMapBasePointer(a6), a0                ; $00A098
        clr.w        d2                                            ; $00A09C
        move.w       d4, d0                                        ; $00A09E
        asr.w        #$8, d0                                       ; $00A0A0
        adda.w       d0, a0                                        ; $00A0A2
        move.w       d6, d0                                        ; $00A0A4
        clr.b        d0                                            ; $00A0A6
        asr.w        #$3, d0                                       ; $00A0A8
        clr.w        d3                                            ; $00A0AA
        move.b       (a0, d0.w), d3                                ; $00A0AC
        move.b       (a5, d3.w), d3                                ; $00A0B0
        jsr          GetEnemyWalkability.l                         ; $00A0B4
        bne.b        loc_00A0C4                                    ; $00A0BA
        move.w       d4, $24(a1)                                   ; $00A0BC
        move.w       d6, $26(a1)                                   ; $00A0C0

loc_00A0C4:
        rts                                                        ; $00A0C4
        ifne *-$A0C6
        fail "ROM end moved"
        endif
