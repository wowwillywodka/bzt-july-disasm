; $008E04..$008E35 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June] Профиль лестницы/перехода: по знаку TransitHeightOffset записывает в четыре слота WallFaceHeightProfile0..3 восемь упакованных знаковых высот концов граней.
        ifne *-$8E04
        fail "ROM start moved"
        endif

BuildStairProfile0C:
        tst.w        rTransitHeightOffset(a6)                                    ; $008E04
        ble.b        loc_008E20                                    ; $008E08
        move.l       #$40407f7f, rWallFaceHeightProfile0(a6)                        ; $008E0A
        move.l       #$7f40407f, rWallFaceHeightProfile2(a6)                        ; $008E12
        move.w       #$1, d3                                       ; $008E1A
        rts                                                        ; $008E1E

loc_008E20:
        move.l       #$c0c00000, rWallFaceHeightProfile0(a6)                        ; $008E20
        move.l       #$c0c000, rWallFaceHeightProfile2(a6)                          ; $008E28
        move.w       #$1, d3                                       ; $008E30
        rts                                                        ; $008E34
        ifne *-$8E36
        fail "ROM end moved"
        endif
