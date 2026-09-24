; $008EA2..$008ED3 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June] Профиль лестницы/перехода: по знаку TransitHeightOffset записывает в четыре слота WallFaceHeightProfile0..3 восемь упакованных знаковых высот концов граней.
        ifne *-$8EA2
        fail "ROM start moved"
        endif

BuildStairProfile0F:
        tst.w        rTransitHeightOffset(a6)                                    ; $008EA2
        bmi.b        loc_008EBE                                    ; $008EA6
        move.l       #$40404040, rWallFaceHeightProfile0(a6)                        ; $008EA8
        move.l       #$40404040, rWallFaceHeightProfile2(a6)                        ; $008EB0
        move.w       #$1, d3                                       ; $008EB8
        rts                                                        ; $008EBC

loc_008EBE:
        move.l       #$c0c0c0c0, rWallFaceHeightProfile0(a6)                        ; $008EBE
        move.l       #$c0c0c0c0, rWallFaceHeightProfile2(a6)                        ; $008EC6
        move.w       #$1, d3                                       ; $008ECE
        rts                                                        ; $008ED2
        ifne *-$8ED4
        fail "ROM end moved"
        endif
