; $009152..$00918B | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 8FB2] профиль ТРАНЗИТА ct 0x38-0x4B (семейство 8DB0-901E, направленные варианты)
        ifne *-$9152
        fail "ROM start moved"
        endif

RendererRoutine_009152:
        tst.w        -$6e4c(a6)                                    ; $009152
        beq.b        loc_009186                                    ; $009156
        bmi.b        loc_009170                                    ; $009158

loc_00915A:
        move.l       #$40404040, -$6e46(a6)                        ; $00915A
        move.l       #$40404040, -$6e42(a6)                        ; $009162
        move.w       #$1, d3                                       ; $00916A
        rts                                                        ; $00916E

loc_009170:
        move.l       #$c0c0c0c0, -$6e46(a6)                        ; $009170
        move.l       #$c0c0c0c0, -$6e42(a6)                        ; $009178
        move.w       #$1, d3                                       ; $009180
        rts                                                        ; $009184

loc_009186:
        tst.w        d1                                            ; $009186
        bpl.b        loc_00915A                                    ; $009188
        bra.b        loc_009170                                    ; $00918A
        ifne *-$918C
        fail "ROM end moved"
        endif
