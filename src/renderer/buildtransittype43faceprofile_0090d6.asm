; $0090D6..$00911F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 8F36] профиль ТРАНЗИТА ct 0x38-0x4B (семейство 8DB0-901E, направленные варианты)
        ifne *-$90D6
        fail "ROM start moved"
        endif

BuildTransitType43FaceProfile:
; Visible cell type $43: render-only height profile; collision table is NoOp.
        tst.w        rTransitHeightOffset(a6)                                    ; $0090D6
        beq.b        loc_00910A                                    ; $0090DA
        bmi.b        loc_0090F4                                    ; $0090DC
        move.l       #$407f0040, rWallFaceHeightProfile0(a6)                        ; $0090DE
        move.l       #$40407f00, rWallFaceHeightProfile2(a6)                        ; $0090E6
        move.w       #$1, d3                                       ; $0090EE
        rts                                                        ; $0090F2

loc_0090F4:
        move.l       #$c00080c0, rWallFaceHeightProfile0(a6)                        ; $0090F4
        move.l       #$c0c00080, rWallFaceHeightProfile2(a6)                        ; $0090FC
        move.w       #$1, d3                                       ; $009104
        rts                                                        ; $009108

loc_00910A:
        move.l       #$c0000040, rWallFaceHeightProfile0(a6)                        ; $00910A
        move.l       #$40c00000, rWallFaceHeightProfile2(a6)                        ; $009112
        move.w       #$1, d3                                       ; $00911A
        rts                                                        ; $00911E
        ifne *-$9120
        fail "ROM end moved"
        endif
