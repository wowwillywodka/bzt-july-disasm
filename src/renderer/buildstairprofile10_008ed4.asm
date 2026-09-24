; $008ED4..$008F05 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June] Профиль лестницы/перехода: по знаку TransitHeightOffset записывает в четыре слота WallFaceHeightProfile0..3 восемь упакованных знаковых высот концов граней.
        ifne *-$8ED4
        fail "ROM start moved"
        endif

BuildStairProfile10:
        tst.w        rTransitHeightOffset(a6)                                    ; $008ED4
        bmi.b        loc_008EF0                                    ; $008ED8
        move.l       #$40400000, rWallFaceHeightProfile0(a6)                        ; $008EDA
        move.l       #$404000, rWallFaceHeightProfile2(a6)                          ; $008EE2
        move.w       #$1, d3                                       ; $008EEA
        rts                                                        ; $008EEE

loc_008EF0:
        move.l       #$c0c08080, rWallFaceHeightProfile0(a6)                        ; $008EF0
        move.l       #$80c0c080, rWallFaceHeightProfile2(a6)                        ; $008EF8
        move.w       #$1, d3                                       ; $008F00
        rts                                                        ; $008F04
        ifne *-$8F06
        fail "ROM end moved"
        endif
