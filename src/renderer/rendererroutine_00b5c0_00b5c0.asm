; $00B5C0..$00B6EF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Отрисовка вертикальной грани стены с учётом стороны взгляда: по знаку D1 и порогу 0x80 (-0x71e2) выбирает порядок проекции d1d6/d232 и текстуры $FF8F2A/$FF8F32 либо $FF8EBA/$FF8EC2, проецирует и блитит квад
        ifne *-$B5C0
        fail "ROM start moved"
        endif

RendererRoutine_00B5C0:
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00B5C0
        tst.w        d1                                            ; $00B5C4
        bmi.b        loc_00B5D6                                    ; $00B5C6
        bne.w        loc_00B648                                    ; $00B5C8
        cmpi.w       #$80, -$71e2(a6)                              ; $00B5CC
        bcs.w        loc_00B648                                    ; $00B5D2

loc_00B5D6:
        add.w        rPlayerCellX(a6), d0                          ; $00B5D6
        lsl.w        #$8, d0                                       ; $00B5DA
        add.w        rPlayerCellY(a6), d1                          ; $00B5DC
        lsl.w        #$8, d1                                       ; $00B5E0
        sub.w        d3, d0                                        ; $00B5E2
        addi.w       #$80, d1                                      ; $00B5E4
        move.w       d3, -(a7)                                     ; $00B5E8
        bsr.w        RendererRoutine_00D1D6                        ; $00B5EA
        addi.w       #$80, d0                                      ; $00B5EE
        bsr.w        RendererRoutine_00D232                        ; $00B5F2
        movem.w      d0-d1, -(a7)                                  ; $00B5F6
        move.l       #$ff8f2a, rCurrentWallTilePair(a6)            ; $00B5FA
        bsr.w        ProjectWallFaceOnly                           ; $00B602
        asr.w        -$717a(a6)                                    ; $00B606
        asr.w        -$7178(a6)                                    ; $00B60A
        bsr.w        DrawWallTextureSpan                           ; $00B60E
        movem.w      (a7)+, d0-d1                                  ; $00B612
        move.w       (a7)+, d3                                     ; $00B616
        add.w        d3, d0                                        ; $00B618
        add.w        d3, d0                                        ; $00B61A
        bsr.w        RendererRoutine_00D1D6                        ; $00B61C
        addi.w       #$80, d0                                      ; $00B620
        bsr.w        RendererRoutine_00D232                        ; $00B624
        move.l       #$ff8f32, rCurrentWallTilePair(a6)            ; $00B628
        bsr.w        ProjectWallFaceOnly                           ; $00B630
        asr.w        -$717a(a6)                                    ; $00B634
        asr.w        -$7178(a6)                                    ; $00B638
        bsr.w        DrawWallTextureSpan                           ; $00B63C
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B640

loc_00B644:
        clr.w        d3                                            ; $00B644
        rts                                                        ; $00B646

loc_00B648:
        add.w        rPlayerCellX(a6), d0                          ; $00B648
        lsl.w        #$8, d0                                       ; $00B64C
        add.w        rPlayerCellY(a6), d1                          ; $00B64E
        lsl.w        #$8, d1                                       ; $00B652
        sub.w        d3, d0                                        ; $00B654
        addi.w       #$80, d1                                      ; $00B656
        move.w       d3, -(a7)                                     ; $00B65A
        bsr.w        RendererRoutine_00D232                        ; $00B65C
        addi.w       #$80, d0                                      ; $00B660
        bsr.w        RendererRoutine_00D1D6                        ; $00B664
        movem.w      d0-d1, -(a7)                                  ; $00B668
        move.l       #$ff8ec2, rCurrentWallTilePair(a6)            ; $00B66C
        bsr.w        ProjectWallFaceOnly                           ; $00B674
        asr.w        -$717a(a6)                                    ; $00B678
        asr.w        -$7178(a6)                                    ; $00B67C
        bsr.w        DrawWallTextureSpan                           ; $00B680
        movem.w      (a7)+, d0-d1                                  ; $00B684
        move.w       (a7)+, d3                                     ; $00B688
        add.w        d3, d0                                        ; $00B68A
        add.w        d3, d0                                        ; $00B68C
        bsr.w        RendererRoutine_00D232                        ; $00B68E
        addi.w       #$80, d0                                      ; $00B692
        bsr.w        RendererRoutine_00D1D6                        ; $00B696
        move.l       #$ff8eba, rCurrentWallTilePair(a6)            ; $00B69A
        bsr.w        ProjectWallFaceOnly                           ; $00B6A2
        asr.w        -$717a(a6)                                    ; $00B6A6
        asr.w        -$7178(a6)                                    ; $00B6AA
        bsr.w        DrawWallTextureSpan                           ; $00B6AE
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B6B2
        clr.w        d3                                            ; $00B6B6
        rts                                                        ; $00B6B8

loc_00B6BA:
        lea.l        -$7030(a6), a3                                ; $00B6BA
        cmpa.l       -$711c(a6), a3                                ; $00B6BE
        beq.b        loc_00B6D0                                    ; $00B6C2

loc_00B6C4:
        cmpa.l       (a3)+, a0                                     ; $00B6C4
        beq.w        loc_00B774                                    ; $00B6C6
        cmpa.l       -$711c(a6), a3                                ; $00B6CA
        bne.b        loc_00B6C4                                    ; $00B6CE

loc_00B6D0:
        move.l       a0, (a3)+                                     ; $00B6D0
        move.l       a3, -$711c(a6)                                ; $00B6D2
        clr.l        -$6e46(a6)                                    ; $00B6D6
        clr.l        -$6e42(a6)                                    ; $00B6DA
        clr.w        -$6e48(a6)                                    ; $00B6DE
        bsr.w        FindTransientWallOpeningAmount                ; $00B6E2
        cmpi.w       #$80, d3                                      ; $00B6E6
        bne.b        RendererRoutine_00B6F0                        ; $00B6EA
        clr.w        d3                                            ; $00B6EC
        rts                                                        ; $00B6EE
        ifne *-$B6F0
        fail "ROM end moved"
        endif
