; $00A992..$00AB6B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Render type $2E opening: slide two half spans along Y using the transient amount. At $80 omit the face. Player/enemy collision class is already zero.
        ifne *-$A992
        fail "ROM start moved"
        endif

RenderOpeningWallAlongY:
; Render type $2E opening: slide two half spans along Y using the transient amount. At $80 omit the face. Player/enemy collision class is already zero.
        lea.l        rVisibleWallYCache(a6), a3                                ; $00A992
        cmpa.l       rVisibleWallYCacheEnd(a6), a3                                ; $00A996
        beq.b        loc_00A9A8                                    ; $00A99A

loc_00A99C:
        cmpa.l       (a3)+, a0                                     ; $00A99C
        beq.w        loc_00AA4C                                    ; $00A99E
        cmpa.l       rVisibleWallYCacheEnd(a6), a3                                ; $00A9A2
        bne.b        loc_00A99C                                    ; $00A9A6

loc_00A9A8:
        move.l       a0, (a3)+                                     ; $00A9A8
        move.l       a3, rVisibleWallYCacheEnd(a6)                                ; $00A9AA
        bsr.w        FindTransientWallOpeningAmount                ; $00A9AE
        cmpi.w       #$80, d3                                      ; $00A9B2
        bne.b        loc_00A9BC                                    ; $00A9B6
        clr.w        d3                                            ; $00A9B8
        rts                                                        ; $00A9BA

loc_00A9BC:
        clr.l        rWallFaceHeightProfile0(a6)                                    ; $00A9BC
        clr.l        rWallFaceHeightProfile2(a6)                                    ; $00A9C0
        clr.w        rCurrentWallFaceHeightProfile(a6)                                    ; $00A9C4
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00A9C8
        tst.w        d0                                            ; $00A9CC
        bmi.b        loc_00A9DE                                    ; $00A9CE
        bne.w        loc_00AA50                                    ; $00A9D0
        cmpi.w       #$80, rPlayerCellFractionX(a6)                              ; $00A9D4
        bcs.w        loc_00AA50                                    ; $00A9DA

loc_00A9DE:
        add.w        rPlayerCellX(a6), d0                          ; $00A9DE
        lsl.w        #$8, d0                                       ; $00A9E2
        add.w        rPlayerCellY(a6), d1                          ; $00A9E4
        lsl.w        #$8, d1                                       ; $00A9E8
        sub.w        d3, d1                                        ; $00A9EA
        addi.w       #$80, d0                                      ; $00A9EC
        move.w       d3, -(a7)                                     ; $00A9F0
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00A9F2
        addi.w       #$80, d1                                      ; $00A9F6
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00A9FA
        movem.w      d0-d1, -(a7)                                  ; $00A9FE
        move.l       #$ff8e12, rCurrentWallTilePair(a6)            ; $00AA02
        bsr.w        ProjectWallFaceOnly                           ; $00AA0A
        asr.w        rWallTextureUStart(a6)                                    ; $00AA0E
        asr.w        rWallTextureUEnd(a6)                                    ; $00AA12
        bsr.w        DrawWallTextureSpan                           ; $00AA16
        movem.w      (a7)+, d0-d1                                  ; $00AA1A
        move.w       (a7)+, d3                                     ; $00AA1E
        add.w        d3, d1                                        ; $00AA20
        add.w        d3, d1                                        ; $00AA22
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00AA24
        addi.w       #$80, d1                                      ; $00AA28
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00AA2C
        move.l       #$ff8e0a, rCurrentWallTilePair(a6)            ; $00AA30
        bsr.w        ProjectWallFaceOnly                           ; $00AA38
        asr.w        rWallTextureUStart(a6)                                    ; $00AA3C
        asr.w        rWallTextureUEnd(a6)                                    ; $00AA40
        bsr.w        DrawWallTextureSpan                           ; $00AA44
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00AA48

loc_00AA4C:
        clr.w        d3                                            ; $00AA4C
        rts                                                        ; $00AA4E

loc_00AA50:
        add.w        rPlayerCellX(a6), d0                          ; $00AA50
        lsl.w        #$8, d0                                       ; $00AA54
        add.w        rPlayerCellY(a6), d1                          ; $00AA56
        lsl.w        #$8, d1                                       ; $00AA5A
        sub.w        d3, d1                                        ; $00AA5C
        addi.w       #$80, d0                                      ; $00AA5E
        move.w       d3, -(a7)                                     ; $00AA62
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00AA64
        addi.w       #$80, d1                                      ; $00AA68
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00AA6C
        movem.w      d0-d1, -(a7)                                  ; $00AA70
        move.l       #$ff8e0a, rCurrentWallTilePair(a6)            ; $00AA74
        bsr.w        ProjectWallFaceOnly                           ; $00AA7C
        asr.w        rWallTextureUStart(a6)                                    ; $00AA80
        asr.w        rWallTextureUEnd(a6)                                    ; $00AA84
        bsr.w        DrawWallTextureSpan                           ; $00AA88
        movem.w      (a7)+, d0-d1                                  ; $00AA8C
        move.w       (a7)+, d3                                     ; $00AA90
        add.w        d3, d1                                        ; $00AA92
        add.w        d3, d1                                        ; $00AA94
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00AA96
        addi.w       #$80, d1                                      ; $00AA9A
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00AA9E
        move.l       #$ff8e12, rCurrentWallTilePair(a6)            ; $00AAA2
        bsr.w        ProjectWallFaceOnly                           ; $00AAAA
        asr.w        rWallTextureUStart(a6)                                    ; $00AAAE
        asr.w        rWallTextureUEnd(a6)                                    ; $00AAB2
        bsr.w        DrawWallTextureSpan                           ; $00AAB6
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00AABA
        clr.w        d3                                            ; $00AABE
        rts                                                        ; $00AAC0

loc_00AAC2:
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $00AAC2
        bsr.w        RecordVisibleCellRenderState                        ; $00AAC6
        st.b         rCellSideEffectsSuppressed(a6)                                    ; $00AACA
        lea.l        rVisibleWallXCache(a6), a3                                ; $00AACE
        cmpa.l       rVisibleWallXCacheEnd(a6), a3                                ; $00AAD2
        beq.b        loc_00AAE4                                    ; $00AAD6

loc_00AAD8:
        cmpa.l       (a3)+, a0                                     ; $00AAD8
        beq.w        loc_00AB38                                    ; $00AADA
        cmpa.l       rVisibleWallXCacheEnd(a6), a3                                ; $00AADE
        bne.b        loc_00AAD8                                    ; $00AAE2

loc_00AAE4:
        move.l       a0, (a3)+                                     ; $00AAE4
        move.l       a3, rVisibleWallXCacheEnd(a6)                                ; $00AAE6
        clr.l        rWallFaceHeightProfile0(a6)                                    ; $00AAEA
        clr.l        rWallFaceHeightProfile2(a6)                                    ; $00AAEE
        clr.w        rCurrentWallFaceHeightProfile(a6)                                    ; $00AAF2
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00AAF6
        tst.w        d1                                            ; $00AAFA
        bmi.b        loc_00AB0C                                    ; $00AAFC
        bne.w        loc_00AB3C                                    ; $00AAFE
        cmpi.w       #$80, rPlayerCellFractionY(a6)                              ; $00AB02
        bcs.w        loc_00AB3C                                    ; $00AB08

loc_00AB0C:
        add.w        rPlayerCellX(a6), d0                          ; $00AB0C
        lsl.w        #$8, d0                                       ; $00AB10
        add.w        rPlayerCellY(a6), d1                          ; $00AB12
        lsl.w        #$8, d1                                       ; $00AB16
        addi.w       #$80, d1                                      ; $00AB18
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00AB1C
        addi.w       #$100, d0                                     ; $00AB20
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00AB24
        move.l       #$ff8e0a, rCurrentWallTilePair(a6)            ; $00AB28
        bsr.w        ProjectAndDrawWallFace                        ; $00AB30
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00AB34

loc_00AB38:
        clr.w        d3                                            ; $00AB38
        rts                                                        ; $00AB3A

loc_00AB3C:
        add.w        rPlayerCellX(a6), d0                          ; $00AB3C
        lsl.w        #$8, d0                                       ; $00AB40
        add.w        rPlayerCellY(a6), d1                          ; $00AB42
        lsl.w        #$8, d1                                       ; $00AB46
        addi.w       #$80, d1                                      ; $00AB48
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00AB4C
        addi.w       #$100, d0                                     ; $00AB50
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00AB54
        move.l       #$ff8e0a, rCurrentWallTilePair(a6)            ; $00AB58
        bsr.w        ProjectAndDrawWallFace                        ; $00AB60
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00AB64
        clr.w        d3                                            ; $00AB68
        rts                                                        ; $00AB6A
        ifne *-$AB6C
        fail "ROM end moved"
        endif
