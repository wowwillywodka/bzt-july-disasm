; $0091BE..$009207 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 901E] профиль ТРАНЗИТА ct 0x38-0x4B (семейство 8DB0-901E, направленные варианты)
        ifne *-$91BE
        fail "ROM start moved"
        endif

BuildTransitType4BFaceProfile:
; Visible cell type $4B: render-only height profile; collision table is NoOp.
        tst.w        rTransitHeightOffset(a6)                                    ; $0091BE
        beq.b        loc_0091F2                                    ; $0091C2
        bmi.b        loc_0091DC                                    ; $0091C4
        move.l       #$40407f, rWallFaceHeightProfile0(a6)                          ; $0091C6
        move.l       #$7f004040, rWallFaceHeightProfile2(a6)                        ; $0091CE
        move.w       #$1, d3                                       ; $0091D6
        rts                                                        ; $0091DA

loc_0091DC:
        move.l       #$80c0c000, rWallFaceHeightProfile0(a6)                        ; $0091DC
        move.l       #$80c0c0, rWallFaceHeightProfile2(a6)                          ; $0091E4
        move.w       #$1, d3                                       ; $0091EC
        rts                                                        ; $0091F0

loc_0091F2:
        move.l       #$40c000, rWallFaceHeightProfile0(a6)                          ; $0091F2
        move.l       #$40c0, rWallFaceHeightProfile2(a6)                       ; $0091FA
        move.w       #$1, d3                                       ; $009202
        rts                                                        ; $009206

        ifne *-$9208
        fail "ROM end moved"
        endif
