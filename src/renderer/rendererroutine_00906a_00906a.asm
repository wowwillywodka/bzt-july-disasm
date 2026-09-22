; $00906A..$0090A3 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 8ECA] профиль ТРАНЗИТА ct 0x38-0x4B (семейство 8DB0-901E, направленные варианты)
        ifne *-$906A
        fail "ROM start moved"
        endif

RendererRoutine_00906A:
        tst.w        -$6e4c(a6)                                    ; $00906A
        beq.b        loc_00909E                                    ; $00906E
        bmi.b        loc_009088                                    ; $009070

loc_009072:
        move.l       #$40404040, -$6e46(a6)                        ; $009072
        move.l       #$40404040, -$6e42(a6)                        ; $00907A
        move.w       #$1, d3                                       ; $009082
        rts                                                        ; $009086

loc_009088:
        move.l       #$c0c0c0c0, -$6e46(a6)                        ; $009088
        move.l       #$c0c0c0c0, -$6e42(a6)                        ; $009090
        move.w       #$1, d3                                       ; $009098
        rts                                                        ; $00909C

loc_00909E:
        tst.w        d1                                            ; $00909E
        bmi.b        loc_009072                                    ; $0090A0
        bra.b        loc_009088                                    ; $0090A2
        ifne *-$90A4
        fail "ROM end moved"
        endif
