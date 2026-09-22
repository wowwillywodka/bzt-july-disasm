; $00D8EA..$00DA27 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$D8EA
        fail "ROM start moved"
        endif

loc_00D8EA:
        move.b       -$6e47(a6), d7                                ; $00D8EA
        sub.b        -$6e48(a6), d7                                ; $00D8EE
        ext.w        d7                                            ; $00D8F2
        muls.w       -$7174(a6), d7                                ; $00D8F4
        move.b       -$6e48(a6), d3                                ; $00D8F8
        lsl.w        #$8, d3                                       ; $00D8FC
        add.w        d3, d7                                        ; $00D8FE
        muls.w       -$7170(a6), d7                                ; $00D900
        asr.l        #$8, d7                                       ; $00D904
        move.b       -$6e48(a6), d4                                ; $00D906
        sub.b        -$6e47(a6), d4                                ; $00D90A
        ext.w        d4                                            ; $00D90E
        move.w       #$ff, d3                                      ; $00D910
        sub.w        -$7178(a6), d3                                ; $00D914
        muls.w       d3, d4                                        ; $00D918
        move.b       -$6e47(a6), d3                                ; $00D91A
        lsl.w        #$8, d3                                       ; $00D91E
        add.w        d3, d4                                        ; $00D920
        muls.w       -$716c(a6), d4                                ; $00D922
        asr.l        #$8, d4                                       ; $00D926
        sub.l        d7, d4                                        ; $00D928
        divs.w       d5, d4                                        ; $00D92A
        move.w       d7, -$6e3e(a6)                                ; $00D92C
        move.w       d4, -$6e3c(a6)                                ; $00D930
        tst.w        -$6f6c(a6)                                    ; $00D934
        bpl.b        loc_00D940                                    ; $00D938
        tst.w        -$6f6a(a6)                                    ; $00D93A
        bpl.b        loc_00D958                                    ; $00D93E

loc_00D940:
        move.w       -$6e3c(a6), d7                                ; $00D940
        add.w        d7, -$6e3e(a6)                                ; $00D944
        movea.l      #WallMarkerColumnPixels, a5                   ; $00D948
        bsr.w        RendererRoutine_00DA28                        ; $00D94E
        subq.w       #$1, d5                                       ; $00D952
        bne.b        loc_00D940                                    ; $00D954
        rts                                                        ; $00D956

loc_00D958:
        move.l       rWallColumnScalerTable(a6), rRenderPointerScratch(a6) ; $00D958
        cmpa.l       -$6f60(a6), a4                                ; $00D95E
        bls.b        loc_00D972                                    ; $00D962
        cmpa.l       -$6f5c(a6), a4                                ; $00D964
        bhi.b        loc_00D972                                    ; $00D968
        move.l       #AlternateWallColumnScalers, rWallColumnScalerTable(a6) ; $00D96A

loc_00D972:
        cmpa.l       -$6f60(a6), a4                                ; $00D972
        bne.b        loc_00D982                                    ; $00D976
        move.l       #AlternateWallColumnScalers, rWallColumnScalerTable(a6) ; $00D978
        bra.b        loc_00D98E                                    ; $00D980

loc_00D982:
        cmpa.l       -$6f5c(a6), a4                                ; $00D982
        bne.b        loc_00D98E                                    ; $00D986
        move.l       rRenderPointerScratch(a6), rWallColumnScalerTable(a6) ; $00D988

loc_00D98E:
        move.w       -$6e3c(a6), d7                                ; $00D98E
        add.w        d7, -$6e3e(a6)                                ; $00D992
        movea.l      #WallMarkerColumnPixels, a5                   ; $00D996
        bsr.w        RendererRoutine_00DA28                        ; $00D99C
        subq.w       #$1, d5                                       ; $00D9A0
        bne.b        loc_00D972                                    ; $00D9A2
        move.l       rRenderPointerScratch(a6), rWallColumnScalerTable(a6) ; $00D9A4
        rts                                                        ; $00D9AA

loc_00D9AC:
        clr.w        -$6e3e(a6)                                    ; $00D9AC
        tst.w        -$6f6c(a6)                                    ; $00D9B0
        bpl.b        loc_00D9BC                                    ; $00D9B4
        tst.w        -$6f6a(a6)                                    ; $00D9B6
        bpl.b        loc_00D9D4                                    ; $00D9BA

loc_00D9BC:
        suba.w       #$a0, a5                                      ; $00D9BC
        cmpa.l       #$ff8b4a, a5                                  ; $00D9C0
        beq.b        loc_00D9CC                                    ; $00D9C6
        adda.w       #$a0, a5                                      ; $00D9C8

loc_00D9CC:
        bsr.b        RendererRoutine_00DA28                        ; $00D9CC
        subq.w       #$1, d5                                       ; $00D9CE
        bne.b        loc_00D9BC                                    ; $00D9D0
        rts                                                        ; $00D9D2

loc_00D9D4:
        move.l       rWallColumnScalerTable(a6), rRenderPointerScratch(a6) ; $00D9D4
        cmpa.l       -$6f60(a6), a4                                ; $00D9DA
        bls.b        loc_00D9EE                                    ; $00D9DE
        cmpa.l       -$6f5c(a6), a4                                ; $00D9E0
        bhi.b        loc_00D9EE                                    ; $00D9E4
        move.l       #AlternateWallColumnScalers, rWallColumnScalerTable(a6) ; $00D9E6

loc_00D9EE:
        cmpa.l       -$6f60(a6), a4                                ; $00D9EE
        bne.b        loc_00D9FE                                    ; $00D9F2
        move.l       #AlternateWallColumnScalers, rWallColumnScalerTable(a6) ; $00D9F4
        bra.b        loc_00DA0A                                    ; $00D9FC

loc_00D9FE:
        cmpa.l       -$6f5c(a6), a4                                ; $00D9FE
        bne.b        loc_00DA0A                                    ; $00DA02
        move.l       rRenderPointerScratch(a6), rWallColumnScalerTable(a6) ; $00DA04

loc_00DA0A:
        suba.w       #$a0, a5                                      ; $00DA0A
        cmpa.l       #$ff8b4a, a5                                  ; $00DA0E
        beq.b        loc_00DA1A                                    ; $00DA14
        adda.w       #$a0, a5                                      ; $00DA16

loc_00DA1A:
        bsr.b        RendererRoutine_00DA28                        ; $00DA1A
        subq.w       #$1, d5                                       ; $00DA1C
        bne.b        loc_00D9EE                                    ; $00DA1E
        move.l       rRenderPointerScratch(a6), rWallColumnScalerTable(a6) ; $00DA20
        rts                                                        ; $00DA26
        ifne *-$DA28
        fail "ROM end moved"
        endif
