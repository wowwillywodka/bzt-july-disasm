; $008FEE..$009037 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 8E4E] профиль ТРАНЗИТА ct 0x38-0x4B (семейство 8DB0-901E, направленные варианты)
        ifne *-$8FEE
        fail "ROM start moved"
        endif

BuildTransitType3BFaceProfile:
; Visible cell type $3B: render-only height profile; collision table is NoOp.
        tst.w        rTransitHeightOffset(a6)                                    ; $008FEE
        beq.b        loc_009022                                    ; $008FF2
        bmi.b        loc_00900C                                    ; $008FF4
        move.l       #$7f004040, rWallFaceHeightProfile0(a6)                        ; $008FF6
        move.l       #$407f0040, rWallFaceHeightProfile2(a6)                        ; $008FFE
        move.w       #$1, d3                                       ; $009006
        rts                                                        ; $00900A

loc_00900C:
        move.l       #$80c0c0, rWallFaceHeightProfile0(a6)                          ; $00900C
        move.l       #$c00080c0, rWallFaceHeightProfile2(a6)                        ; $009014
        move.w       #$1, d3                                       ; $00901C
        rts                                                        ; $009020

loc_009022:
        move.l       #$40c0, rWallFaceHeightProfile0(a6)                       ; $009022
        move.l       #$c0000040, rWallFaceHeightProfile2(a6)                        ; $00902A
        move.w       #$1, d3                                       ; $009032
        rts                                                        ; $009036
        ifne *-$9038
        fail "ROM end moved"
        endif
