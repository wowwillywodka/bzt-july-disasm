; $00DA28..$00DCBD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Draw one column with a nonzero face-height profile or player view offset.
; The same depth-word comparison gates the column; scaled and full-height
; paths then apply the vertical displacement and write at four-byte stride.
; Bounded instruction witnesses cover clipped 80-row output at X=0/1/126/127.
; See docs/WALL_PROJECTION.md and docs/RENDER_BUFFER_BOUNDS.md.
        ifne *-$DA28
        fail "ROM start moved"
        endif

DrawHeightAdjustedWallColumn:
        movem.l      d0/d5, -(a7)                                  ; $00DA28
        move.l       d2, d0                                        ; $00DA2C
        asr.l        #$8, d0                                       ; $00DA2E
        cmp.w        (a4), d0                                      ; $00DA30
        bcs.w        loc_00DA92                                    ; $00DA32
        move.w       d0, (a4)                                      ; $00DA36
        move.w       d0, d3                                        ; $00DA38
        muls.w       rPlayerViewOffsetZ(a6), d3                                ; $00DA3A
        move.w       rWallSlopeHeightAccumulator(a6), d4                                ; $00DA3E
        ext.l        d4                                            ; $00DA42
        add.l        d4, d3                                        ; $00DA44
        asr.l        #$6, d3                                       ; $00DA46
        cmpi.w       #$50, d0                                      ; $00DA48
        bhi.b        loc_00DAB4                                    ; $00DA4C
        move.w       d0, d4                                        ; $00DA4E
        asr.w        #$1, d4                                       ; $00DA50
        tst.w        d3                                            ; $00DA52
        bpl.b        loc_00DA60                                    ; $00DA54
        sub.w        d3, d4                                        ; $00DA56
        cmpi.w       #$28, d4                                      ; $00DA58
        bgt.b        loc_00DAB4                                    ; $00DA5C
        bra.b        loc_00DA68                                    ; $00DA5E

loc_00DA60:
        add.w        d3, d4                                        ; $00DA60
        cmpi.w       #$28, d4                                      ; $00DA62
        bgt.b        loc_00DAB4                                    ; $00DA66

loc_00DA68:
        asl.w        #$2, d3                                       ; $00DA68
        movea.l      #ShiftedColumnCopyTailCenter, a3              ; $00DA6A
        bclr.l       #$0, d0                                       ; $00DA70
        lsl.w        #$1, d0                                       ; $00DA74
        adda.w       d0, a3                                        ; $00DA76
        move.l       (a3, d3.w), -(a7)                             ; $00DA78
        neg.w        d3                                            ; $00DA7C
        move.l       (a3, d3.w), -(a7)                             ; $00DA7E
        movea.l      rWallColumnScalerTable(a6), a3                ; $00DA82
        movea.l      (a3, d0.w), a3                                ; $00DA86
; Push bottom then top suffix pointers. With JSR's return PC on the stack,
; the scaler reads the top pointer at 4(SP) and bottom at 8(SP).
        jsr          (a3)                                          ; $00DA8A
        addq.w       #$8, a7                                       ; $00DA8C
        bra.w        loc_00DC40                                    ; $00DA8E

loc_00DA92:
        lea.l        $50(a5), a5                                   ; $00DA92
        adda.w       #$140, a0                                     ; $00DA96
        bra.w        loc_00DC40                                    ; $00DA9A

loc_00DA9E:
        movea.l      a5, a3                                        ; $00DA9E
        move.w       #$4f, d7                                      ; $00DAA0

loc_00DAA4:
        move.b       (a3)+, (a0)                                   ; $00DAA4
        addq.w       #$4, a0                                       ; $00DAA6
        dbra         d7, loc_00DAA4                                ; $00DAA8
        lea.l        $50(a5), a5                                   ; $00DAAC
        bra.w        loc_00DC40                                    ; $00DAB0

loc_00DAB4:
        move.w       d0, d4                                        ; $00DAB4
        asr.w        #$1, d4                                       ; $00DAB6
        sub.w        d3, d4                                        ; $00DAB8
        cmpi.w       #$ffd8, d4                                    ; $00DABA
        ble.b        loc_00DA9E                                    ; $00DABE
        move.w       d0, d4                                        ; $00DAC0
        asr.w        #$1, d4                                       ; $00DAC2
        add.w        d3, d4                                        ; $00DAC4
        cmpi.w       #$ffd8, d4                                    ; $00DAC6
        ble.b        loc_00DA9E                                    ; $00DACA
        movem.l      d6/a1-a2/a5, -(a7)                            ; $00DACC
        asr.w        #$1, d0                                       ; $00DAD0
        move.w       d0, d6                                        ; $00DAD2
        move.w       d3, d0                                        ; $00DAD4
        clr.w        d3                                            ; $00DAD6
        cmpi.w       #$28, d0                                      ; $00DAD8
        bge.w        loc_00DB82                                    ; $00DADC
        cmpi.w       #$ffd8, d0                                    ; $00DAE0
        ble.w        loc_00DBDC                                    ; $00DAE4
        addi.w       #$28, d0                                      ; $00DAE8
        move.w       d6, d7                                        ; $00DAEC
        move.w       d7, d4                                        ; $00DAEE
        sub.w        d0, d7                                        ; $00DAF0
        neg.w        d7                                            ; $00DAF2
        ble.b        loc_00DB08                                    ; $00DAF4
        movea.l      a5, a3                                        ; $00DAF6
        add.w        d7, d3                                        ; $00DAF8
        subq.w       #$1, d7                                       ; $00DAFA

loc_00DAFC:
        move.b       (a3)+, (a0)                                   ; $00DAFC
        addq.w       #$4, a0                                       ; $00DAFE
        dbra         d7, loc_00DAFC                                ; $00DB00
        clr.w        d7                                            ; $00DB04
        bra.b        loc_00DB16                                    ; $00DB06

loc_00DB08:
        add.w        d7, d4                                        ; $00DB08
        neg.w        d7                                            ; $00DB0A
        ext.l        d7                                            ; $00DB0C
        lsl.l        #$5, d7                                       ; $00DB0E
        divu.w       d6, d7                                        ; $00DB10
        adda.w       d7, a1                                        ; $00DB12
        swap         d7                                            ; $00DB14

loc_00DB16:
        add.w        d4, d3                                        ; $00DB16
        sub.w        d6, d7                                        ; $00DB18
        move.w       #$20, d5                                      ; $00DB1A
        move.b       (a1)+, d0                                     ; $00DB1E
        subq.w       #$1, d4                                       ; $00DB20

loc_00DB22:
        move.b       d0, (a0)                                      ; $00DB22
        addq.w       #$4, a0                                       ; $00DB24
        add.w        d5, d7                                        ; $00DB26
        bmi.b        loc_00DB30                                    ; $00DB28

loc_00DB2A:
        move.b       (a1)+, d0                                     ; $00DB2A
        sub.w        d6, d7                                        ; $00DB2C
        bpl.b        loc_00DB2A                                    ; $00DB2E

loc_00DB30:
        dbra         d4, loc_00DB22                                ; $00DB30
        move.w       #$50, d4                                      ; $00DB34
        sub.w        d3, d4                                        ; $00DB38
        cmp.w        d6, d4                                        ; $00DB3A
        ble.b        loc_00DB40                                    ; $00DB3C
        move.w       d6, d4                                        ; $00DB3E

loc_00DB40:
        add.w        d4, d3                                        ; $00DB40
        move.w       d6, d7                                        ; $00DB42
        neg.w        d7                                            ; $00DB44
        move.w       #$20, d5                                      ; $00DB46
        move.b       (a2)+, d0                                     ; $00DB4A
        subq.w       #$1, d4                                       ; $00DB4C

loc_00DB4E:
        move.b       d0, (a0)                                      ; $00DB4E
        addq.w       #$4, a0                                       ; $00DB50
        add.w        d5, d7                                        ; $00DB52
        bmi.b        loc_00DB5C                                    ; $00DB54

loc_00DB56:
        move.b       (a2)+, d0                                     ; $00DB56
        sub.w        d6, d7                                        ; $00DB58
        bpl.b        loc_00DB56                                    ; $00DB5A

loc_00DB5C:
        dbra         d4, loc_00DB4E                                ; $00DB5C
        cmpi.w       #$50, d3                                      ; $00DB60
        bcc.w        loc_00DC38                                    ; $00DB64
        move.w       #$50, d4                                      ; $00DB68
        sub.w        d3, d4                                        ; $00DB6C
        lea.l        $50(a5), a3                                   ; $00DB6E
        suba.w       d4, a3                                        ; $00DB72
        subq.w       #$1, d4                                       ; $00DB74

loc_00DB76:
        move.b       (a3)+, (a0)                                   ; $00DB76
        addq.w       #$4, a0                                       ; $00DB78
        dbra         d4, loc_00DB76                                ; $00DB7A
        bra.w        loc_00DC38                                    ; $00DB7E

loc_00DB82:
        addi.w       #$28, d0                                      ; $00DB82
        move.w       d6, d7                                        ; $00DB86
        move.w       d7, d4                                        ; $00DB88
        sub.w        d0, d7                                        ; $00DB8A
        neg.w        d7                                            ; $00DB8C
        ble.b        loc_00DBA2                                    ; $00DB8E
        movea.l      a5, a3                                        ; $00DB90
        add.w        d7, d3                                        ; $00DB92
        subq.w       #$1, d7                                       ; $00DB94

loc_00DB96:
        move.b       (a3)+, (a0)                                   ; $00DB96
        addq.w       #$4, a0                                       ; $00DB98
        dbra         d7, loc_00DB96                                ; $00DB9A
        clr.w        d7                                            ; $00DB9E
        bra.b        loc_00DBB0                                    ; $00DBA0

loc_00DBA2:
        add.w        d7, d4                                        ; $00DBA2
        neg.w        d7                                            ; $00DBA4
        ext.l        d7                                            ; $00DBA6
        lsl.l        #$5, d7                                       ; $00DBA8
        divu.w       d6, d7                                        ; $00DBAA
        adda.w       d7, a1                                        ; $00DBAC
        swap         d7                                            ; $00DBAE

loc_00DBB0:
        neg.w        d3                                            ; $00DBB0
        addi.w       #$50, d3                                      ; $00DBB2
        cmp.w        d3, d4                                        ; $00DBB6
        ble.b        loc_00DBBC                                    ; $00DBB8
        move.w       d3, d4                                        ; $00DBBA

loc_00DBBC:
        sub.w        d6, d7                                        ; $00DBBC
        move.w       #$20, d5                                      ; $00DBBE
        move.b       (a1)+, d0                                     ; $00DBC2
        subq.w       #$1, d4                                       ; $00DBC4

loc_00DBC6:
        move.b       d0, (a0)                                      ; $00DBC6
        addq.w       #$4, a0                                       ; $00DBC8
        add.w        d5, d7                                        ; $00DBCA
        bmi.b        loc_00DBD4                                    ; $00DBCC

loc_00DBCE:
        move.b       (a1)+, d0                                     ; $00DBCE
        sub.w        d6, d7                                        ; $00DBD0
        bpl.b        loc_00DBCE                                    ; $00DBD2

loc_00DBD4:
        dbra         d4, loc_00DBC6                                ; $00DBD4
        bra.w        loc_00DC38                                    ; $00DBD8

loc_00DBDC:
        addi.w       #$28, d0                                      ; $00DBDC
        move.w       d6, d4                                        ; $00DBE0
        add.w        d0, d4                                        ; $00DBE2
        neg.w        d0                                            ; $00DBE4
        ext.l        d0                                            ; $00DBE6
        lsl.l        #$5, d0                                       ; $00DBE8
        divu.w       d6, d0                                        ; $00DBEA
        adda.w       d0, a2                                        ; $00DBEC
        swap         d0                                            ; $00DBEE
        move.w       d0, d7                                        ; $00DBF0
        cmpi.w       #$50, d4                                      ; $00DBF2
        ble.b        loc_00DBFC                                    ; $00DBF6
        move.w       #$50, d4                                      ; $00DBF8

loc_00DBFC:
        add.w        d4, d3                                        ; $00DBFC
        sub.w        d6, d7                                        ; $00DBFE
        move.w       #$20, d5                                      ; $00DC00
        move.b       (a2)+, d0                                     ; $00DC04
        subq.w       #$1, d4                                       ; $00DC06

loc_00DC08:
        move.b       d0, (a0)                                      ; $00DC08
        addq.w       #$4, a0                                       ; $00DC0A
        add.w        d5, d7                                        ; $00DC0C
        bmi.b        loc_00DC16                                    ; $00DC0E

loc_00DC10:
        move.b       (a2)+, d0                                     ; $00DC10
        sub.w        d6, d7                                        ; $00DC12
        bpl.b        loc_00DC10                                    ; $00DC14

loc_00DC16:
        dbra         d4, loc_00DC08                                ; $00DC16
        cmpi.w       #$50, d3                                      ; $00DC1A
        bcc.w        loc_00DC38                                    ; $00DC1E
        move.w       #$50, d4                                      ; $00DC22
        sub.w        d3, d4                                        ; $00DC26
        lea.l        $50(a5), a3                                   ; $00DC28
        suba.w       d4, a3                                        ; $00DC2C
        subq.w       #$1, d4                                       ; $00DC2E

loc_00DC30:
        move.b       (a3)+, (a0)                                   ; $00DC30
        addq.w       #$4, a0                                       ; $00DC32
        dbra         d4, loc_00DC30                                ; $00DC34

loc_00DC38:
        movem.l      (a7)+, d6/a1-a2/a5                            ; $00DC38
        lea.l        $50(a5), a5                                   ; $00DC3C

loc_00DC40:
        movem.l      (a7)+, d0/d5                                  ; $00DC40
        add.l        d1, d2                                        ; $00DC44
        addq.w       #$2, a4                                       ; $00DC46
        add.w        d6, rWallTextureUStart(a6)                                ; $00DC48
        tst.b        rWallTextureUStart(a6)                                    ; $00DC4C
        beq.b        loc_00DCA6                                    ; $00DC50
        move.w       rWallTextureUStart(a6), d4                                ; $00DC52
        clr.b        rWallTextureUStart(a6)                                    ; $00DC56
        clr.b        d4                                            ; $00DC5A
        asr.w        #$3, d4                                       ; $00DC5C
        adda.w       d4, a1                                        ; $00DC5E
        adda.w       d4, a2                                        ; $00DC60
        asr.w        #$1, d4                                       ; $00DC62
        add.w        d4, rWallTextureColumnByteOffset(a6)                                ; $00DC64
        tst.b        rWallTextureColumnByteOffset(a6)                                    ; $00DC68
        beq.b        loc_00DCA6                                    ; $00DC6C
        clr.l        d4                                            ; $00DC6E
        move.b       rWallTextureColumnByteOffset(a6), d4                                ; $00DC70
        clr.b        rWallTextureColumnByteOffset(a6)                                    ; $00DC74
        lsl.b        #$2, d4                                       ; $00DC78
        add.l        d4, rCurrentWallTilePair(a6)                  ; $00DC7A
        movea.l      rCurrentWallTilePair(a6), a3                  ; $00DC7E
        move.w       (a3)+, d4                                     ; $00DC82
        ext.l        d4                                            ; $00DC84
        lsl.l        #$8, d4                                       ; $00DC86
        lsl.l        #$1, d4                                       ; $00DC88
        movea.l      rZoneWallTiles(a6), a1                        ; $00DC8A
        movea.l      a1, a2                                        ; $00DC8E
        adda.l       d4, a1                                        ; $00DC90
        move.w       (a3)+, d4                                     ; $00DC92
        ext.l        d4                                            ; $00DC94
        lsl.l        #$8, d4                                       ; $00DC96
        lsl.l        #$1, d4                                       ; $00DC98
        adda.l       d4, a2                                        ; $00DC9A
        move.w       rWallTextureColumnByteOffset(a6), d4                                ; $00DC9C
        lsl.w        #$1, d4                                       ; $00DCA0
        adda.w       d4, a1                                        ; $00DCA2
        adda.w       d4, a2                                        ; $00DCA4

loc_00DCA6:
        suba.w       #$13f, a0                                     ; $00DCA6
        subq.w       #$1, d0                                       ; $00DCAA
        bpl.b        loc_00DCB6                                    ; $00DCAC
        move.w       #$3, d0                                       ; $00DCAE
        adda.w       #$13c, a0                                     ; $00DCB2

loc_00DCB6:
        rts                                                        ; $00DCB6

; Separate external entry: active background profile changed even if Z did not.
ForceResampleSceneBackgroundForColorMode:
        move.w       rPlayerViewOffsetZ(a6), d0                                ; $00DCB8
        bra.b        ResampleSceneBackgroundProfile                ; $00DCBC
        ifne *-$DCBE
        fail "ROM end moved"
        endif
