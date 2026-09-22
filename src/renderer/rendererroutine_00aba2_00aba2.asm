; $00ABA2..$00AC9B | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Рисует 3D-маркер цели по экранным координатам: складывает x/y с базой камеры (-0x71ec/-0x71ea,a6), масштабирует <<8, проверяет порог дальности (-0x71e2,a6)<$80, проецирует через $d1d6/$d232 и клипит $d26e/$d4e4 — вывод прицельной отметки объекта
        ifne *-$ABA2
        fail "ROM start moved"
        endif

RendererRoutine_00ABA2:
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00ABA2
        tst.w        d1                                            ; $00ABA6
        bmi.b        loc_00ABB8                                    ; $00ABA8
        bne.w        loc_00AC2A                                    ; $00ABAA
        cmpi.w       #$80, -$71e2(a6)                              ; $00ABAE
        bcs.w        loc_00AC2A                                    ; $00ABB4

loc_00ABB8:
        add.w        rPlayerCellX(a6), d0                          ; $00ABB8
        lsl.w        #$8, d0                                       ; $00ABBC
        add.w        rPlayerCellY(a6), d1                          ; $00ABBE
        lsl.w        #$8, d1                                       ; $00ABC2
        sub.w        d3, d0                                        ; $00ABC4
        addi.w       #$80, d1                                      ; $00ABC6
        move.w       d3, -(a7)                                     ; $00ABCA
        bsr.w        RendererRoutine_00D1D6                        ; $00ABCC
        addi.w       #$80, d0                                      ; $00ABD0
        bsr.w        RendererRoutine_00D232                        ; $00ABD4
        movem.w      d0-d1, -(a7)                                  ; $00ABD8
        move.l       #$ff8e0a, rCurrentWallTilePair(a6)            ; $00ABDC
        bsr.w        ProjectWallFaceOnly                           ; $00ABE4
        asr.w        -$717a(a6)                                    ; $00ABE8
        asr.w        -$7178(a6)                                    ; $00ABEC
        bsr.w        DrawWallTextureSpan                           ; $00ABF0
        movem.w      (a7)+, d0-d1                                  ; $00ABF4
        move.w       (a7)+, d3                                     ; $00ABF8
        add.w        d3, d0                                        ; $00ABFA
        add.w        d3, d0                                        ; $00ABFC
        bsr.w        RendererRoutine_00D1D6                        ; $00ABFE
        addi.w       #$80, d0                                      ; $00AC02
        bsr.w        RendererRoutine_00D232                        ; $00AC06
        move.l       #$ff8e12, rCurrentWallTilePair(a6)            ; $00AC0A
        bsr.w        ProjectWallFaceOnly                           ; $00AC12
        asr.w        -$717a(a6)                                    ; $00AC16
        asr.w        -$7178(a6)                                    ; $00AC1A
        bsr.w        DrawWallTextureSpan                           ; $00AC1E
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00AC22

loc_00AC26:
        clr.w        d3                                            ; $00AC26
        rts                                                        ; $00AC28

loc_00AC2A:
        add.w        rPlayerCellX(a6), d0                          ; $00AC2A
        lsl.w        #$8, d0                                       ; $00AC2E
        add.w        rPlayerCellY(a6), d1                          ; $00AC30
        lsl.w        #$8, d1                                       ; $00AC34
        sub.w        d3, d0                                        ; $00AC36
        addi.w       #$80, d1                                      ; $00AC38
        move.w       d3, -(a7)                                     ; $00AC3C
        bsr.w        RendererRoutine_00D232                        ; $00AC3E
        addi.w       #$80, d0                                      ; $00AC42
        bsr.w        RendererRoutine_00D1D6                        ; $00AC46
        movem.w      d0-d1, -(a7)                                  ; $00AC4A
        move.l       #$ff8e12, rCurrentWallTilePair(a6)            ; $00AC4E
        bsr.w        ProjectWallFaceOnly                           ; $00AC56
        asr.w        -$717a(a6)                                    ; $00AC5A
        asr.w        -$7178(a6)                                    ; $00AC5E
        bsr.w        DrawWallTextureSpan                           ; $00AC62
        movem.w      (a7)+, d0-d1                                  ; $00AC66
        move.w       (a7)+, d3                                     ; $00AC6A
        add.w        d3, d0                                        ; $00AC6C
        add.w        d3, d0                                        ; $00AC6E
        bsr.w        RendererRoutine_00D232                        ; $00AC70
        addi.w       #$80, d0                                      ; $00AC74
        bsr.w        RendererRoutine_00D1D6                        ; $00AC78
        move.l       #$ff8e0a, rCurrentWallTilePair(a6)            ; $00AC7C
        bsr.w        ProjectWallFaceOnly                           ; $00AC84
        asr.w        -$717a(a6)                                    ; $00AC88
        asr.w        -$7178(a6)                                    ; $00AC8C
        bsr.w        DrawWallTextureSpan                           ; $00AC90
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00AC94
        clr.w        d3                                            ; $00AC98
        rts                                                        ; $00AC9A
        ifne *-$AC9C
        fail "ROM end moved"
        endif
