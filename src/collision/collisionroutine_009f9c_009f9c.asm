; $009F9C..$00A009 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Шаг поворота игрока (вариант 2, зеркальный к 0x9f80): сдвиг угла (-0x71d8), сброс инерции, выставление флага направления поворота в (-0x7205) при установленном бите 7
        ifne *-$9F9C
        fail "ROM start moved"
        endif

CollisionRoutine_009F9C:
        asr.w        -$71d8(a6)                                    ; $009F9C
        clr.w        -$71d6(a6)                                    ; $009FA0
        clr.w        -$71d2(a6)                                    ; $009FA4
        btst.b       #$7, -$7205(a6)                               ; $009FA8
        beq.b        loc_009FB6                                    ; $009FAE
        move.b       #$80, -$7205(a6)                              ; $009FB0

loc_009FB6:
        rts                                                        ; $009FB6

loc_009FB8:
        move.b       $1(a0), d3                                    ; $009FB8
        cmpi.b       #$17, (a5, d3.w)                              ; $009FBC
        beq.b        loc_009F48                                    ; $009FC2
        move.b       -$1(a0), d3                                   ; $009FC4
        cmpi.b       #$3f, (a5, d3.w)                              ; $009FC8
        beq.b        loc_009F64                                    ; $009FCE
        move.b       $20(a0), d3                                   ; $009FD0
        cmpi.b       #$47, (a5, d3.w)                              ; $009FD4
        beq.b        CollisionRoutine_009F9C                       ; $009FDA
        bra.b        CollisionRoutine_009F80                       ; $009FDC

loc_009FDE:
        move.b       -$1(a0), d3                                   ; $009FDE
        cmpi.b       #$17, (a5, d3.w)                              ; $009FE2
        beq.w        loc_009F48                                    ; $009FE8
        move.b       $1(a0), d3                                    ; $009FEC
        cmpi.b       #$3f, (a5, d3.w)                              ; $009FF0
        beq.w        loc_009F64                                    ; $009FF6
        move.b       -$20(a0), d3                                  ; $009FFA
        cmpi.b       #$47, (a5, d3.w)                              ; $009FFE
        beq.b        CollisionRoutine_009F9C                       ; $00A004
        bra.w        CollisionRoutine_009F80                       ; $00A006
        ifne *-$A00A
        fail "ROM end moved"
        endif
