; $008E36..$008E67 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June] Профиль лестницы/перехода: по знаку TransitHeightOffset записывает в четыре слота WallFaceHeightProfile0..3 восемь упакованных знаковых высот концов граней.
        ifne *-$8E36
        fail "ROM start moved"
        endif

BuildStairProfile0D:
        tst.w        rTransitHeightOffset(a6)                                    ; $008E36
        ble.b        loc_008E52                                    ; $008E3A
        move.l       #$40404040, rWallFaceHeightProfile0(a6)                        ; $008E3C
        move.l       #$40404040, rWallFaceHeightProfile2(a6)                        ; $008E44
        move.w       #$1, d3                                       ; $008E4C
        rts                                                        ; $008E50

loc_008E52:
        move.l       #$c0c0c0c0, rWallFaceHeightProfile0(a6)                        ; $008E52
        move.l       #$c0c0c0c0, rWallFaceHeightProfile2(a6)                        ; $008E5A
        move.w       #$1, d3                                       ; $008E62
        rts                                                        ; $008E66
        ifne *-$8E68
        fail "ROM end moved"
        endif
