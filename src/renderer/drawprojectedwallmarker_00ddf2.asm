; $00DDF2..$00DF63 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$DDF2
        fail "ROM start moved"
        endif

DrawProjectedWallMarker:
        move.w       $c(a2), rWallSpanStartInverseDepth(a6)                            ; $00DDF2
        bpl.b        loc_00DDFC                                    ; $00DDF8

loc_00DDFA:
        rts                                                        ; $00DDFA

loc_00DDFC:
        move.w       $c(a3), rWallSpanEndInverseDepth(a6)                            ; $00DDFC
        bmi.b        loc_00DDFA                                    ; $00DE02
        move.w       $e(a3), rWallSpanEndColumn(a6)                            ; $00DE04
        bmi.b        loc_00DDFA                                    ; $00DE0A
        move.w       $e(a2), rWallSpanStartColumn(a6)                            ; $00DE0C
        bpl.b        loc_00DE18                                    ; $00DE12
        clr.w        rWallSpanStartColumn(a6)                                    ; $00DE14

loc_00DE18:
        cmpi.w       #$80, rWallSpanStartColumn(a6)                              ; $00DE18
        bge.b        loc_00DDFA                                    ; $00DE1E
        cmpi.w       #$80, rWallSpanEndColumn(a6)                              ; $00DE20
        blt.b        loc_00DE2E                                    ; $00DE26
        move.w       #$7f, rWallSpanEndColumn(a6)                              ; $00DE28

loc_00DE2E:
        tst.w        rVBlankTransferPhasesRemaining(a6)                                    ; $00DE2E
        beq.b        loc_00DE42                                    ; $00DE32
        cmpi.w       #$40, rWallSpanEndColumn(a6)                              ; $00DE34
        bcs.b        loc_00DE42                                    ; $00DE3A

loc_00DE3C:
        tst.w        rVBlankTransferPhasesRemaining(a6)                                    ; $00DE3C
        bne.b        loc_00DE3C                                    ; $00DE40

loc_00DE42:
        move.w       rCurrentWallMarkerFillMode(a6), d6                                ; $00DE42
        lea.l        rSoftwareFrameBuffer(a6), a0                                ; $00DE46
        move.w       rWallSpanStartColumn(a6), d0                                ; $00DE4A
        lea.l        rScreenColumnDepthWords(a6), a4                                  ; $00DE4E
        adda.w       d0, a4                                        ; $00DE52
        adda.w       d0, a4                                        ; $00DE54
        movea.l      #WallMarkerColumnPixels, a5                   ; $00DE56
        tst.w        d6                                            ; $00DE5C
        beq.b        loc_00DE70                                    ; $00DE5E
        move.w       #$50, d6                                      ; $00DE60
        lea.l        rSceneBackgroundColumns(a6), a5                                  ; $00DE64
        btst.l       #$0, d0                                       ; $00DE68
        bne.b        loc_00DE70                                    ; $00DE6C
        adda.w       d6, a5                                        ; $00DE6E

loc_00DE70:
        move.w       d0, d1                                        ; $00DE70
        andi.w       #$3, d0                                       ; $00DE72
        adda.w       d0, a0                                        ; $00DE76
        neg.w        d0                                            ; $00DE78
        addq.w       #$3, d0                                       ; $00DE7A
        andi.w       #$fffc, d1                                    ; $00DE7C
        ext.l        d1                                            ; $00DE80
        lsl.l        #$4, d1                                       ; $00DE82
        adda.l       d1, a0                                        ; $00DE84
        lsl.l        #$2, d1                                       ; $00DE86
        adda.l       d1, a0                                        ; $00DE88
        move.w       rWallSpanEndColumn(a6), d5                                ; $00DE8A
        sub.w        rWallSpanStartColumn(a6), d5                                ; $00DE8E
        addq.w       #$1, d5                                       ; $00DE92
        ble.w        loc_00DDFA                                    ; $00DE94
        move.w       rWallSpanEndInverseDepth(a6), d1                                ; $00DE98
        ext.l        d1                                            ; $00DE9C
        lsl.l        #$8, d1                                       ; $00DE9E
        move.w       rWallSpanStartInverseDepth(a6), d2                                ; $00DEA0
        ext.l        d2                                            ; $00DEA4
        lsl.l        #$8, d2                                       ; $00DEA6
        sub.l        d2, d1                                        ; $00DEA8
        divs.w       d5, d1                                        ; $00DEAA
        ext.l        d1                                            ; $00DEAC

loc_00DEAE:
        suba.w       #$a0, a5                                      ; $00DEAE
        cmpa.l       #ramSceneBackgroundColumns, a5                                  ; $00DEB2
        beq.b        loc_00DEBE                                    ; $00DEB8
        adda.w       #$a0, a5                                      ; $00DEBA

loc_00DEBE:
        movem.l      d0/d5, -(a7)                                  ; $00DEBE
        move.l       d2, d0                                        ; $00DEC2
        asr.l        #$8, d0                                       ; $00DEC4
        cmp.w        (a4)+, d0                                     ; $00DEC6
        bcs.w        loc_00DF40                                    ; $00DEC8
        move.w       d0, d3                                        ; $00DECC
        muls.w       rPlayerViewOffsetZ(a6), d3                                ; $00DECE
        asr.l        #$6, d3                                       ; $00DED2
        move.w       #$50, d4                                      ; $00DED4
        sub.w        d0, d4                                        ; $00DED8
        asr.w        #$1, d4                                       ; $00DEDA
        add.w        d3, d4                                        ; $00DEDC
        beq.b        loc_00DF08                                    ; $00DEDE
        bmi.b        loc_00DF08                                    ; $00DEE0
        cmpi.w       #$50, d4                                      ; $00DEE2
        bls.b        loc_00DEEC                                    ; $00DEE6
        move.w       #$50, d4                                      ; $00DEE8

loc_00DEEC:
        movem.l      a0/a5, -(a7)                                  ; $00DEEC
        neg.w        d4                                            ; $00DEF0
        addi.w       #$50, d4                                      ; $00DEF2
        lsl.w        #$2, d4                                       ; $00DEF6
        movea.l      #ShiftedColumnCopyTails, a3                   ; $00DEF8
        movea.l      (a3, d4.w), a3                                ; $00DEFE
        jsr          (a3)                                          ; $00DF02
        movem.l      (a7)+, a0/a5                                  ; $00DF04

loc_00DF08:
        move.w       #$50, d4                                      ; $00DF08
        sub.w        d0, d4                                        ; $00DF0C
        asr.w        #$1, d4                                       ; $00DF0E
        sub.w        d3, d4                                        ; $00DF10
        beq.b        loc_00DF40                                    ; $00DF12
        bmi.b        loc_00DF40                                    ; $00DF14
        movem.l      a0/a5, -(a7)                                  ; $00DF16
        cmpi.w       #$50, d4                                      ; $00DF1A
        bls.b        loc_00DF24                                    ; $00DF1E
        move.w       #$50, d4                                      ; $00DF20

loc_00DF24:
        neg.w        d4                                            ; $00DF24
        addi.w       #$50, d4                                      ; $00DF26
        adda.w       d4, a5                                        ; $00DF2A
        lsl.w        #$2, d4                                       ; $00DF2C
        adda.w       d4, a0                                        ; $00DF2E
        movea.l      #ShiftedColumnCopyTails, a3                   ; $00DF30
        movea.l      (a3, d4.w), a3                                ; $00DF36
        jsr          (a3)                                          ; $00DF3A
        movem.l      (a7)+, a0/a5                                  ; $00DF3C

loc_00DF40:
        adda.w       d6, a5                                        ; $00DF40
        adda.w       #$140, a0                                     ; $00DF42
        movem.l      (a7)+, d0/d5                                  ; $00DF46
        add.l        d1, d2                                        ; $00DF4A
        suba.w       #$13f, a0                                     ; $00DF4C
        subq.w       #$1, d0                                       ; $00DF50
        bpl.b        loc_00DF5C                                    ; $00DF52
        move.w       #$3, d0                                       ; $00DF54
        adda.w       #$13c, a0                                     ; $00DF58

loc_00DF5C:
        subq.w       #$1, d5                                       ; $00DF5C
        bne.w        loc_00DEAE                                    ; $00DF5E
        rts                                                        ; $00DF62
        ifne *-$DF64
        fail "ROM end moved"
        endif
