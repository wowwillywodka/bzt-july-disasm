; $008F06..$008F4F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June] Профиль лестницы/перехода: по знаку TransitHeightOffset записывает в четыре слота WallFaceHeightProfile0..3 восемь упакованных знаковых высот концов граней.
        ifne *-$8F06
        fail "ROM start moved"
        endif

BuildStairProfile11:
        tst.w        rTransitHeightOffset(a6)                                    ; $008F06
        beq.b        loc_008F3A                                    ; $008F0A
        bmi.b        loc_008F24                                    ; $008F0C
        move.l       #$40407f00, rWallFaceHeightProfile0(a6)                        ; $008F0E
        move.l       #$40407f, rWallFaceHeightProfile2(a6)                          ; $008F16
        move.w       #$1, d3                                       ; $008F1E
        rts                                                        ; $008F22

loc_008F24:
        move.l       #$c0c00080, rWallFaceHeightProfile0(a6)                        ; $008F24
        move.l       #$80c0c000, rWallFaceHeightProfile2(a6)                        ; $008F2C
        move.w       #$1, d3                                       ; $008F34
        rts                                                        ; $008F38

loc_008F3A:
        move.l       #$40c00000, rWallFaceHeightProfile0(a6)                        ; $008F3A
        move.l       #$40c000, rWallFaceHeightProfile2(a6)                          ; $008F42
        move.w       #$1, d3                                       ; $008F4A
        rts                                                        ; $008F4E
        ifne *-$8F50
        fail "ROM end moved"
        endif
