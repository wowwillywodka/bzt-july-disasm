; $008F82..$008FBB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 8DE2] профиль ТРАНЗИТА ct 0x38-0x4B (семейство 8DB0-901E, направленные варианты)
        ifne *-$8F82
        fail "ROM start moved"
        endif

BuildTransitType39FaceProfile:
; Visible cell type $39: render-only height profile; collision table is NoOp.
        tst.w        rTransitHeightOffset(a6)                                    ; $008F82
        beq.b        loc_008FB6                                    ; $008F86
        bmi.b        loc_008FA0                                    ; $008F88

loc_008F8A:
        move.l       #$40404040, rWallFaceHeightProfile0(a6)                        ; $008F8A
        move.l       #$40404040, rWallFaceHeightProfile2(a6)                        ; $008F92
        move.w       #$1, d3                                       ; $008F9A
        rts                                                        ; $008F9E

loc_008FA0:
        move.l       #$c0c0c0c0, rWallFaceHeightProfile0(a6)                        ; $008FA0
        move.l       #$c0c0c0c0, rWallFaceHeightProfile2(a6)                        ; $008FA8
        move.w       #$1, d3                                       ; $008FB0
        rts                                                        ; $008FB4

loc_008FB6:
        tst.w        d0                                            ; $008FB6
        bpl.b        loc_008F8A                                    ; $008FB8
        bra.b        loc_008FA0                                    ; $008FBA
        ifne *-$8FBC
        fail "ROM end moved"
        endif
