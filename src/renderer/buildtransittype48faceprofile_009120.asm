; $009120..$009151 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 8F80] профиль ТРАНЗИТА ct 0x38-0x4B (семейство 8DB0-901E, направленные варианты)
        ifne *-$9120
        fail "ROM start moved"
        endif

BuildTransitType48FaceProfile:
; Visible cell type $48: render-only height profile; collision table is NoOp.
        tst.w        rTransitHeightOffset(a6)                                    ; $009120
        ble.b        loc_00913C                                    ; $009124
        move.l       #$7f40407f, rWallFaceHeightProfile0(a6)                        ; $009126
        move.l       #$7f7f4040, rWallFaceHeightProfile2(a6)                        ; $00912E
        move.w       #$1, d3                                       ; $009136
        rts                                                        ; $00913A

loc_00913C:
        move.l       #$c0c000, rWallFaceHeightProfile0(a6)                          ; $00913C
        move.l       #$c0c0, rWallFaceHeightProfile2(a6)                            ; $009144
        move.w       #$1, d3                                       ; $00914C
        rts                                                        ; $009150
        ifne *-$9152
        fail "ROM end moved"
        endif
