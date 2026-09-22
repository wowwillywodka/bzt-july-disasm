; $00F8BC..$00FC17 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Программный блиттер/масштабатор спрайта объекта: клампит прямоугольник (D0=высота,D4=ширина,D1<0x80,D2<0x50), выбирает источник по таблице 0x101fc и колонки 0xfc56, dest-база 0xff8a4a — растеризация масштабированного спрайта в буфер кадра
        ifne *-$F8BC
        fail "ROM start moved"
        endif

ScaleAndDrawSoftwareSpriteTile:
        tst.w        d0                                            ; $00F8BC
        bgt.b        loc_00F8C2                                    ; $00F8BE
        rts                                                        ; $00F8C0

loc_00F8C2:
        tst.w        d4                                            ; $00F8C2
        bgt.b        loc_00F8C8                                    ; $00F8C4
        rts                                                        ; $00F8C6

loc_00F8C8:
        cmpi.w       #$80, d1                                      ; $00F8C8
        blt.b        loc_00F8D0                                    ; $00F8CC
        rts                                                        ; $00F8CE

loc_00F8D0:
        cmpi.w       #$50, d2                                      ; $00F8D0
        blt.b        loc_00F8D8                                    ; $00F8D4
        rts                                                        ; $00F8D6

loc_00F8D8:
        move.w       d1, d3                                        ; $00F8D8
        add.w        d4, d3                                        ; $00F8DA
        subq.w       #$1, d3                                       ; $00F8DC
        bpl.b        loc_00F8E2                                    ; $00F8DE
        rts                                                        ; $00F8E0

loc_00F8E2:
        move.w       d2, d3                                        ; $00F8E2
        add.w        d0, d3                                        ; $00F8E4
        subq.w       #$1, d3                                       ; $00F8E6
        bpl.b        loc_00F8EC                                    ; $00F8E8
        rts                                                        ; $00F8EA

loc_00F8EC:
        lea.l        rActiveSpriteColorRemaps(a6), a0              ; $00F8EC
        move.l       (a0), d3                                      ; $00F8F0
        cmp.l        rZoneSpriteColorRemaps(a6), d3                ; $00F8F2
        beq.b        loc_00F910                                    ; $00F8F6
        move.w       -$6f26(a6), d3                                ; $00F8F8
        asr.w        #$3, d3                                       ; $00F8FC
        subq.w       #$1, d3                                       ; $00F8FE
        bpl.b        loc_00F904                                    ; $00F900
        rts                                                        ; $00F902

loc_00F904:
        neg.w        d3                                            ; $00F904
        addq.w       #$4, d3                                       ; $00F906
        bpl.b        loc_00F90C                                    ; $00F908
        clr.w        d3                                            ; $00F90A

loc_00F90C:
        lsl.w        #$2, d3                                       ; $00F90C
        adda.w       d3, a0                                        ; $00F90E

loc_00F910:
        movea.l      (a0), a3                                      ; $00F910
        moveq        #$0, d3                                       ; $00F912
        move.w       d1, d3                                        ; $00F914
        lsl.w        #$1, d3                                       ; $00F916
        addi.l       #$ff8a4a, d3                                  ; $00F918
        move.l       d3, -$6f20(a6)                                ; $00F91E
        movea.l      #SpriteScaleSamplePointers, a4                ; $00F922
        move.w       d0, d3                                        ; $00F928
        lsl.w        #$2, d3                                       ; $00F92A
; Vertical source rows come from SpriteScaleSamplePointers[height], not floor(y*32/height). See docs/SPRITE_RENDER_REVIEW.md.
        movea.l      (a4, d3.w), a4                                ; $00F92C
        move.w       d0, d3                                        ; $00F930
        move.w       d2, -$6f28(a6)                                ; $00F932
        bpl.b        loc_00F93E                                    ; $00F936
        add.w        d2, d3                                        ; $00F938
        suba.w       d2, a4                                        ; $00F93A
        clr.w        d2                                            ; $00F93C

loc_00F93E:
        add.w        d2, d3                                        ; $00F93E
        cmpi.w       #$50, d3                                      ; $00F940
        bls.b        loc_00F94A                                    ; $00F944
        move.w       #$50, d3                                      ; $00F946

loc_00F94A:
        sub.w        d2, d3                                        ; $00F94A
        movea.l      #SpriteColumnEntryPointers, a5                ; $00F94C
        move.w       #$20, -$6f30(a6)                              ; $00F952
; Any nonzero attribute word selects horizontal mirror: reverse packed-byte columns and use nibble-swapped color lookup.
        tst.w        -$6f32(a6)                                    ; $00F958
        beq.b        loc_00F96A                                    ; $00F95C
        adda.w       #$1e0, a1                                     ; $00F95E
        neg.w        -$6f30(a6)                                    ; $00F962
        adda.w       #$c00, a3                                     ; $00F966

loc_00F96A:
        movea.l      #SpriteColumnEntryPointers, a5                ; $00F96A
        move.w       d3, -$6f2a(a6)                                ; $00F970
        lsl.w        #$2, d3                                       ; $00F974
        movea.l      (a5, d3.w), a5                                ; $00F976
        lea.l        -$1dba(a6), a0                                ; $00F97A
        lsl.w        #$2, d2                                       ; $00F97E
        adda.w       d2, a0                                        ; $00F980
        move.w       d1, d3                                        ; $00F982
        andi.w       #$fffc, d3                                    ; $00F984
        lsl.w        #$4, d3                                       ; $00F988
        adda.w       d3, a0                                        ; $00F98A
        lsl.w        #$2, d3                                       ; $00F98C
        adda.w       d3, a0                                        ; $00F98E
        move.w       d1, d3                                        ; $00F990
        andi.w       #$3, d3                                       ; $00F992
        adda.w       d3, a0                                        ; $00F996
        neg.w        d3                                            ; $00F998
        addq.w       #$4, d3                                       ; $00F99A
        cmpi.w       #$10, d4                                      ; $00F99C
        bcs.w        loc_00FAE2                                    ; $00F9A0
        clr.w        d5                                            ; $00F9A4
        move.w       d4, d7                                        ; $00F9A6
        subq.w       #$1, d7                                       ; $00F9A8
        tst.w        d1                                            ; $00F9AA
        bpl.b        loc_00F9D4                                    ; $00F9AC
        move.w       #$4, d3                                       ; $00F9AE
        lea.l        -$1dba(a6), a0                                ; $00F9B2
        adda.w       d2, a0                                        ; $00F9B6
        move.l       #$ff8a4a, -$6f20(a6)                          ; $00F9B8

loc_00F9C0:
        addi.w       #$10, d5                                      ; $00F9C0
        cmp.w        d4, d5                                        ; $00F9C4
        blt.b        loc_00F9CE                                    ; $00F9C6
        sub.w        d4, d5                                        ; $00F9C8
        adda.w       -$6f30(a6), a1                                ; $00F9CA

loc_00F9CE:
        subq.w       #$1, d7                                       ; $00F9CE
        addq.w       #$1, d1                                       ; $00F9D0
        bmi.b        loc_00F9C0                                    ; $00F9D2

loc_00F9D4:
        move.w       d1, d6                                        ; $00F9D4
        add.w        d7, d6                                        ; $00F9D6
        cmpi.w       #$7f, d6                                      ; $00F9D8
        bls.b        loc_00F9E4                                    ; $00F9DC
        move.w       #$7f, d7                                      ; $00F9DE
        sub.w        d1, d7                                        ; $00F9E2

loc_00F9E4:
        cmpi.w       #$50, d0                                      ; $00F9E4
        bls.b        loc_00FA1C                                    ; $00F9E8
        subq.w       #$1, -$6f2a(a6)                               ; $00F9EA
        move.l       #$200000, d6                                  ; $00F9EE
        divu.w       d0, d6                                        ; $00F9F4
        move.w       d6, -$6f2e(a6)                                ; $00F9F6
        lea.l        DrawLargeSpriteColumn(pc), a5                 ; $00F9FA
        clr.w        -$6f2c(a6)                                    ; $00F9FE
        move.w       -$6f28(a6), d2                                ; $00FA02
        bpl.b        loc_00FA1C                                    ; $00FA06
        neg.w        d2                                            ; $00FA08
        ext.l        d2                                            ; $00FA0A
        lsl.l        #$5, d2                                       ; $00FA0C
        divu.w       d0, d2                                        ; $00FA0E
        adda.w       d2, a1                                        ; $00FA10
        swap         d2                                            ; $00FA12
        mulu.w       d6, d2                                        ; $00FA14
        lsr.l        #$5, d2                                       ; $00FA16
        move.w       d2, -$6f2c(a6)                                ; $00FA18

loc_00FA1C:
        move.w       -$6f2e(a6), d2                                ; $00FA1C
        clr.w        d0                                            ; $00FA20
        clr.w        d1                                            ; $00FA22
        move.w       -$6f26(a6), d6                                ; $00FA24
        tst.w        -$6f6c(a6)                                    ; $00FA28
        bpl.b        loc_00FA34                                    ; $00FA2C
        tst.w        -$6f6a(a6)                                    ; $00FA2E
        bpl.b        loc_00FA68                                    ; $00FA32

loc_00FA34:
        movea.l      -$6f20(a6), a2                                ; $00FA34
        addq.l       #$2, -$6f20(a6)                               ; $00FA38
        cmp.w        (a2), d6                                      ; $00FA3C
        blt.b        loc_00FA48                                    ; $00FA3E
        move.l       a0, -(a7)                                     ; $00FA40
        movea.l      a4, a2                                        ; $00FA42
        jsr          (a5)                                          ; $00FA44
        movea.l      (a7)+, a0                                     ; $00FA46

loc_00FA48:
        addq.w       #$1, a0                                       ; $00FA48
        subq.w       #$1, d3                                       ; $00FA4A
        bne.b        loc_00FA54                                    ; $00FA4C
        adda.w       #$13c, a0                                     ; $00FA4E
        moveq        #$4, d3                                       ; $00FA52

loc_00FA54:
        addi.w       #$10, d5                                      ; $00FA54
        cmp.w        d4, d5                                        ; $00FA58
        blt.b        loc_00FA62                                    ; $00FA5A
        sub.w        d4, d5                                        ; $00FA5C
        adda.w       -$6f30(a6), a1                                ; $00FA5E

loc_00FA62:
        dbra         d7, loc_00FA34                                ; $00FA62
        rts                                                        ; $00FA66

loc_00FA68:
        movea.l      -$6f20(a6), a2                                ; $00FA68
        cmpa.l       -$6f60(a6), a2                                ; $00FA6C
        bls.b        loc_00FA8A                                    ; $00FA70
        cmpa.l       -$6f5c(a6), a2                                ; $00FA72
        bhi.b        loc_00FA8A                                    ; $00FA76
        move.l       a3, rRenderPointerScratch(a6)                 ; $00FA78
        movea.l      rActiveSpriteColorRemaps(a6), a3              ; $00FA7C
        tst.w        -$6f32(a6)                                    ; $00FA80
        beq.b        loc_00FA8A                                    ; $00FA84
        adda.w       #$c00, a3                                     ; $00FA86

loc_00FA8A:
        movea.l      -$6f20(a6), a2                                ; $00FA8A
        cmpa.l       -$6f60(a6), a2                                ; $00FA8E
        bne.b        loc_00FAA8                                    ; $00FA92
        move.l       a3, rRenderPointerScratch(a6)                 ; $00FA94
        movea.l      rActiveSpriteColorRemaps(a6), a3              ; $00FA98
        tst.w        -$6f32(a6)                                    ; $00FA9C
        beq.b        loc_00FAB2                                    ; $00FAA0
        adda.w       #$c00, a3                                     ; $00FAA2
        bra.b        loc_00FAB2                                    ; $00FAA6

loc_00FAA8:
        cmpa.l       -$6f5c(a6), a2                                ; $00FAA8
        bne.b        loc_00FAB2                                    ; $00FAAC
        movea.l      rRenderPointerScratch(a6), a3                 ; $00FAAE

loc_00FAB2:
        addq.l       #$2, -$6f20(a6)                               ; $00FAB2
        cmp.w        (a2), d6                                      ; $00FAB6
        blt.b        loc_00FAC2                                    ; $00FAB8
        move.l       a0, -(a7)                                     ; $00FABA
        movea.l      a4, a2                                        ; $00FABC
        jsr          (a5)                                          ; $00FABE
        movea.l      (a7)+, a0                                     ; $00FAC0

loc_00FAC2:
        addq.w       #$1, a0                                       ; $00FAC2
        subq.w       #$1, d3                                       ; $00FAC4
        bne.b        loc_00FACE                                    ; $00FAC6
        adda.w       #$13c, a0                                     ; $00FAC8
        moveq        #$4, d3                                       ; $00FACC

loc_00FACE:
        addi.w       #$10, d5                                      ; $00FACE
        cmp.w        d4, d5                                        ; $00FAD2
        blt.b        loc_00FADC                                    ; $00FAD4
        sub.w        d4, d5                                        ; $00FAD6
        adda.w       -$6f30(a6), a1                                ; $00FAD8

loc_00FADC:
        dbra         d7, loc_00FA8A                                ; $00FADC
        rts                                                        ; $00FAE0

loc_00FAE2:
        move.l       a4, -(a7)                                     ; $00FAE2
; Below 16 packed columns use SpriteColumnSourceSteps[width + 16*mirror]. Width counts pixel pairs, not individual pixels.
        lea.l        SpriteColumnSourceSteps(pc), a4               ; $00FAE4
        move.w       d4, d5                                        ; $00FAE8
        tst.w        -$6f32(a6)                                    ; $00FAEA
        beq.b        loc_00FAF4                                    ; $00FAEE
        addi.w       #$10, d5                                      ; $00FAF0

loc_00FAF4:
        lsl.w        #$5, d5                                       ; $00FAF4
        adda.w       d5, a4                                        ; $00FAF6
        move.w       d4, d7                                        ; $00FAF8
        beq.w        loc_00FBA4                                    ; $00FAFA
        subq.w       #$1, d7                                       ; $00FAFE
        tst.w        d1                                            ; $00FB00
        bpl.b        loc_00FB1E                                    ; $00FB02
        move.w       #$4, d3                                       ; $00FB04
        lea.l        -$1dba(a6), a0                                ; $00FB08
        move.l       #$ff8a4a, -$6f20(a6)                          ; $00FB0C
        adda.w       d2, a0                                        ; $00FB14

loc_00FB16:
        adda.w       (a4)+, a1                                     ; $00FB16
        subq.w       #$1, d7                                       ; $00FB18
        addq.w       #$1, d1                                       ; $00FB1A
        bmi.b        loc_00FB16                                    ; $00FB1C

loc_00FB1E:
        move.w       d1, d6                                        ; $00FB1E
        add.w        d7, d6                                        ; $00FB20
        cmpi.w       #$7f, d6                                      ; $00FB22
        bls.b        loc_00FB2E                                    ; $00FB26
        move.w       #$7f, d7                                      ; $00FB28
        sub.w        d1, d7                                        ; $00FB2C

loc_00FB2E:
        cmpi.w       #$50, d0                                      ; $00FB2E
        bls.b        loc_00FB66                                    ; $00FB32
        subq.w       #$1, -$6f2a(a6)                               ; $00FB34
        move.l       #$200000, d6                                  ; $00FB38
        divu.w       d0, d6                                        ; $00FB3E
        move.w       d6, -$6f2e(a6)                                ; $00FB40
        lea.l        DrawLargeSpriteColumn(pc), a5                 ; $00FB44
        clr.w        -$6f2c(a6)                                    ; $00FB48
        move.w       -$6f28(a6), d2                                ; $00FB4C
        bpl.b        loc_00FB66                                    ; $00FB50
        neg.w        d2                                            ; $00FB52
        ext.l        d2                                            ; $00FB54
        lsl.l        #$5, d2                                       ; $00FB56
        divu.w       d0, d2                                        ; $00FB58
        adda.w       d2, a1                                        ; $00FB5A
        swap         d2                                            ; $00FB5C
        mulu.w       d6, d2                                        ; $00FB5E
        lsr.l        #$5, d2                                       ; $00FB60
        move.w       d2, -$6f2c(a6)                                ; $00FB62

loc_00FB66:
        move.w       -$6f2e(a6), d2                                ; $00FB66
        clr.w        d0                                            ; $00FB6A
        clr.w        d1                                            ; $00FB6C
        move.w       -$6f26(a6), d6                                ; $00FB6E
        tst.w        -$6f6c(a6)                                    ; $00FB72
        bpl.b        loc_00FB7E                                    ; $00FB76
        tst.w        -$6f6a(a6)                                    ; $00FB78
        bpl.b        loc_00FBA8                                    ; $00FB7C

loc_00FB7E:
        movea.l      -$6f20(a6), a2                                ; $00FB7E
        addq.l       #$2, -$6f20(a6)                               ; $00FB82
        cmp.w        (a2), d6                                      ; $00FB86
        blt.b        loc_00FB92                                    ; $00FB88
        movea.l      (a7), a2                                      ; $00FB8A
        move.l       a0, -(a7)                                     ; $00FB8C
        jsr          (a5)                                          ; $00FB8E
        movea.l      (a7)+, a0                                     ; $00FB90

loc_00FB92:
        addq.w       #$1, a0                                       ; $00FB92
        subq.w       #$1, d3                                       ; $00FB94
        bne.b        loc_00FB9E                                    ; $00FB96
        adda.w       #$13c, a0                                     ; $00FB98
        moveq        #$4, d3                                       ; $00FB9C

loc_00FB9E:
; Source step is applied AFTER drawing the current packed column. Initial column is 0 (normal) or 15 (mirror); do not replace this with generic image scaling.
        adda.w       (a4)+, a1                                     ; $00FB9E
        dbra         d7, loc_00FB7E                                ; $00FBA0

loc_00FBA4:
        addq.w       #$4, a7                                       ; $00FBA4
        rts                                                        ; $00FBA6

loc_00FBA8:
        movea.l      -$6f20(a6), a2                                ; $00FBA8
        cmpa.l       -$6f60(a6), a2                                ; $00FBAC
        bls.b        loc_00FBCA                                    ; $00FBB0
        cmpa.l       -$6f5c(a6), a2                                ; $00FBB2
        bhi.b        loc_00FBCA                                    ; $00FBB6
        move.l       a3, rRenderPointerScratch(a6)                 ; $00FBB8
        movea.l      rActiveSpriteColorRemaps(a6), a3              ; $00FBBC
        tst.w        -$6f32(a6)                                    ; $00FBC0
        beq.b        loc_00FBCA                                    ; $00FBC4
        adda.w       #$c00, a3                                     ; $00FBC6

loc_00FBCA:
        movea.l      -$6f20(a6), a2                                ; $00FBCA
        cmpa.l       -$6f60(a6), a2                                ; $00FBCE
        bne.b        loc_00FBE8                                    ; $00FBD2
        move.l       a3, rRenderPointerScratch(a6)                 ; $00FBD4
        movea.l      rActiveSpriteColorRemaps(a6), a3              ; $00FBD8
        tst.w        -$6f32(a6)                                    ; $00FBDC
        beq.b        loc_00FBF2                                    ; $00FBE0
        adda.w       #$c00, a3                                     ; $00FBE2
        bra.b        loc_00FBF2                                    ; $00FBE6

loc_00FBE8:
        cmpa.l       -$6f5c(a6), a2                                ; $00FBE8
        bne.b        loc_00FBF2                                    ; $00FBEC
        movea.l      rRenderPointerScratch(a6), a3                 ; $00FBEE

loc_00FBF2:
        addq.l       #$2, -$6f20(a6)                               ; $00FBF2
        cmp.w        (a2), d6                                      ; $00FBF6
        blt.b        loc_00FC02                                    ; $00FBF8
        movea.l      (a7), a2                                      ; $00FBFA
        move.l       a0, -(a7)                                     ; $00FBFC
        jsr          (a5)                                          ; $00FBFE
        movea.l      (a7)+, a0                                     ; $00FC00

loc_00FC02:
        addq.w       #$1, a0                                       ; $00FC02
        subq.w       #$1, d3                                       ; $00FC04
        bne.b        loc_00FC0E                                    ; $00FC06
        adda.w       #$13c, a0                                     ; $00FC08
        moveq        #$4, d3                                       ; $00FC0C

loc_00FC0E:
        adda.w       (a4)+, a1                                     ; $00FC0E
        dbra         d7, loc_00FBCA                                ; $00FC10
        addq.w       #$4, a7                                       ; $00FC14
        rts                                                        ; $00FC16
        ifne *-$FC18
        fail "ROM end moved"
        endif
