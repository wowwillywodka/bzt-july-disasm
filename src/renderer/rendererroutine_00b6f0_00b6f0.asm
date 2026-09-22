; $00B6F0..$00B8E1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Отрисовка грани стены, зеркальный вариант 0xB5C0: по знаку D1/порогу 0x80 проецирует две вершины (d1d6/d232+sin/cos) и блитит квад текстурами $FF8EBA/$FF8EC2 или $FF8F32/$FF8F2A
        ifne *-$B6F0
        fail "ROM start moved"
        endif

RendererRoutine_00B6F0:
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00B6F0
        tst.w        d1                                            ; $00B6F4
        bmi.b        loc_00B706                                    ; $00B6F6
        bne.w        loc_00B778                                    ; $00B6F8
        cmpi.w       #$80, -$71e2(a6)                              ; $00B6FC
        bcs.w        loc_00B778                                    ; $00B702

loc_00B706:
        add.w        rPlayerCellX(a6), d0                          ; $00B706
        lsl.w        #$8, d0                                       ; $00B70A
        add.w        rPlayerCellY(a6), d1                          ; $00B70C
        lsl.w        #$8, d1                                       ; $00B710
        sub.w        d3, d0                                        ; $00B712
        addi.w       #$80, d1                                      ; $00B714
        move.w       d3, -(a7)                                     ; $00B718
        bsr.w        RendererRoutine_00D1D6                        ; $00B71A
        addi.w       #$80, d0                                      ; $00B71E
        bsr.w        RendererRoutine_00D232                        ; $00B722
        movem.w      d0-d1, -(a7)                                  ; $00B726
        move.l       #$ff8eba, rCurrentWallTilePair(a6)            ; $00B72A
        bsr.w        ProjectWallFaceOnly                           ; $00B732
        asr.w        -$717a(a6)                                    ; $00B736
        asr.w        -$7178(a6)                                    ; $00B73A
        bsr.w        DrawWallTextureSpan                           ; $00B73E
        movem.w      (a7)+, d0-d1                                  ; $00B742
        move.w       (a7)+, d3                                     ; $00B746
        add.w        d3, d0                                        ; $00B748
        add.w        d3, d0                                        ; $00B74A
        bsr.w        RendererRoutine_00D1D6                        ; $00B74C
        addi.w       #$80, d0                                      ; $00B750
        bsr.w        RendererRoutine_00D232                        ; $00B754
        move.l       #$ff8ec2, rCurrentWallTilePair(a6)            ; $00B758
        bsr.w        ProjectWallFaceOnly                           ; $00B760
        asr.w        -$717a(a6)                                    ; $00B764
        asr.w        -$7178(a6)                                    ; $00B768
        bsr.w        DrawWallTextureSpan                           ; $00B76C
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B770

loc_00B774:
        clr.w        d3                                            ; $00B774
        rts                                                        ; $00B776

loc_00B778:
        add.w        rPlayerCellX(a6), d0                          ; $00B778
        lsl.w        #$8, d0                                       ; $00B77C
        add.w        rPlayerCellY(a6), d1                          ; $00B77E
        lsl.w        #$8, d1                                       ; $00B782
        sub.w        d3, d0                                        ; $00B784
        addi.w       #$80, d1                                      ; $00B786
        move.w       d3, -(a7)                                     ; $00B78A
        bsr.w        RendererRoutine_00D232                        ; $00B78C
        addi.w       #$80, d0                                      ; $00B790
        bsr.w        RendererRoutine_00D1D6                        ; $00B794
        movem.w      d0-d1, -(a7)                                  ; $00B798
        move.l       #$ff8f32, rCurrentWallTilePair(a6)            ; $00B79C
        bsr.w        ProjectWallFaceOnly                           ; $00B7A4
        asr.w        -$717a(a6)                                    ; $00B7A8
        asr.w        -$7178(a6)                                    ; $00B7AC
        bsr.w        DrawWallTextureSpan                           ; $00B7B0
        movem.w      (a7)+, d0-d1                                  ; $00B7B4
        move.w       (a7)+, d3                                     ; $00B7B8
        add.w        d3, d0                                        ; $00B7BA
        add.w        d3, d0                                        ; $00B7BC
        bsr.w        RendererRoutine_00D232                        ; $00B7BE
        addi.w       #$80, d0                                      ; $00B7C2
        bsr.w        RendererRoutine_00D1D6                        ; $00B7C6
        move.l       #$ff8f2a, rCurrentWallTilePair(a6)            ; $00B7CA
        bsr.w        ProjectWallFaceOnly                           ; $00B7D2
        asr.w        -$717a(a6)                                    ; $00B7D6
        asr.w        -$7178(a6)                                    ; $00B7DA
        bsr.w        DrawWallTextureSpan                           ; $00B7DE
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B7E2
        clr.w        d3                                            ; $00B7E6
        rts                                                        ; $00B7E8

loc_00B7EA:
        movea.l      rTransientCellRecordsEnd(a6), a3              ; $00B7EA
        cmpa.l       #$ff0fd0, a3                                  ; $00B7EE
        beq.b        loc_00B826                                    ; $00B7F4
        move.l       a0, (a3)+                                     ; $00B7F6
        move.w       #$20, (a3)+                                   ; $00B7F8
        clr.w        d0                                            ; $00B7FC
        move.b       (a0), d0                                      ; $00B7FE
        move.w       d0, (a3)+                                     ; $00B800
        cmpa.l       #$ffa5fa, a0                                  ; $00B802
        bcs.b        loc_00B812                                    ; $00B808
        cmpa.l       #$ffe5fa, a0                                  ; $00B80A
        bcs.b        loc_00B818                                    ; $00B810

loc_00B812:
        movea.l      #$ffa9fa, a0                                  ; $00B812

loc_00B818:
        move.b       $c7b(a6), (a0)                                ; $00B818
        jsr          CommitMapCellAndSendLink.l                    ; $00B81C
        bra.w        FinishPlayerWallOpeningRecord                 ; $00B822

loc_00B826:
        rts                                                        ; $00B826

loc_00B828:
        movea.l      rTransientCellRecordsEnd(a6), a3              ; $00B828
        cmpa.l       #$ff0fd0, a3                                  ; $00B82C
        beq.b        loc_00B864                                    ; $00B832
        move.l       a0, (a3)+                                     ; $00B834
        move.w       #$20, (a3)+                                   ; $00B836
        clr.w        d0                                            ; $00B83A
        move.b       (a0), d0                                      ; $00B83C
        move.w       d0, (a3)+                                     ; $00B83E
        cmpa.l       #$ffa5fa, a0                                  ; $00B840
        bcs.b        loc_00B850                                    ; $00B846
        cmpa.l       #$ffe5fa, a0                                  ; $00B848
        bcs.b        loc_00B856                                    ; $00B84E

loc_00B850:
        movea.l      #$ffa9fa, a0                                  ; $00B850

loc_00B856:
        move.b       $c7c(a6), (a0)                                ; $00B856
        jsr          CommitMapCellAndSendLink.l                    ; $00B85A
        bra.w        FinishPlayerWallOpeningRecord                 ; $00B860

loc_00B864:
        rts                                                        ; $00B864

loc_00B866:
        movea.l      rTransientCellRecordsEnd(a6), a3              ; $00B866
        cmpa.l       #$ff0fd0, a3                                  ; $00B86A
        beq.b        loc_00B8A2                                    ; $00B870
        move.l       a0, (a3)+                                     ; $00B872
        move.w       #$20, (a3)+                                   ; $00B874
        clr.w        d0                                            ; $00B878
        move.b       (a0), d0                                      ; $00B87A
        move.w       d0, (a3)+                                     ; $00B87C
        cmpa.l       #$ffa5fa, a0                                  ; $00B87E
        bcs.b        loc_00B88E                                    ; $00B884
        cmpa.l       #$ffe5fa, a0                                  ; $00B886
        bcs.b        loc_00B894                                    ; $00B88C

loc_00B88E:
        movea.l      #$ffa9fa, a0                                  ; $00B88E

loc_00B894:
        move.b       $c7d(a6), (a0)                                ; $00B894
        jsr          CommitMapCellAndSendLink.l                    ; $00B898
        bra.w        FinishPlayerWallOpeningRecord                 ; $00B89E

loc_00B8A2:
        rts                                                        ; $00B8A2

loc_00B8A4:
        movea.l      rTransientCellRecordsEnd(a6), a3              ; $00B8A4
        cmpa.l       #$ff0fd0, a3                                  ; $00B8A8
        beq.b        loc_00B8E0                                    ; $00B8AE
        move.l       a0, (a3)+                                     ; $00B8B0
        move.w       #$20, (a3)+                                   ; $00B8B2
        clr.w        d0                                            ; $00B8B6
        move.b       (a0), d0                                      ; $00B8B8
        move.w       d0, (a3)+                                     ; $00B8BA
        cmpa.l       #$ffa5fa, a0                                  ; $00B8BC
        bcs.b        loc_00B8CC                                    ; $00B8C2
        cmpa.l       #$ffe5fa, a0                                  ; $00B8C4
        bcs.b        loc_00B8D2                                    ; $00B8CA

loc_00B8CC:
        movea.l      #$ffa9fa, a0                                  ; $00B8CC

loc_00B8D2:
        move.b       $c7e(a6), (a0)                                ; $00B8D2
        jsr          CommitMapCellAndSendLink.l                    ; $00B8D6
        bra.w        FinishPlayerWallOpeningRecord                 ; $00B8DC

loc_00B8E0:
        rts                                                        ; $00B8E0
        ifne *-$B8E2
        fail "ROM end moved"
        endif
