; $0091BE..$009237 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 901E] профиль ТРАНЗИТА ct 0x38-0x4B (семейство 8DB0-901E, направленные варианты)
        ifne *-$91BE
        fail "ROM start moved"
        endif

RendererRoutine_0091BE:
        tst.w        -$6e4c(a6)                                    ; $0091BE
        beq.b        loc_0091F2                                    ; $0091C2
        bmi.b        loc_0091DC                                    ; $0091C4
        move.l       #$40407f, -$6e46(a6)                          ; $0091C6
        move.l       #$7f004040, -$6e42(a6)                        ; $0091CE
        move.w       #$1, d3                                       ; $0091D6
        rts                                                        ; $0091DA

loc_0091DC:
        move.l       #$80c0c000, -$6e46(a6)                        ; $0091DC
        move.l       #$80c0c0, -$6e42(a6)                          ; $0091E4
        move.w       #$1, d3                                       ; $0091EC
        rts                                                        ; $0091F0

loc_0091F2:
        move.l       #$40c000, -$6e46(a6)                          ; $0091F2
        move.l       #loc_0040C0, -$6e42(a6)                       ; $0091FA
        move.w       #$1, d3                                       ; $009202
        rts                                                        ; $009206

loc_009208:
        move.l       a0, -$42a2(a6)                                ; $009208
        bsr.w        EnvironmentRoutine_00D166                     ; $00920C
        move.b       -$6e4b(a6), d3                                ; $009210
        bset.l       #$0, d3                                       ; $009214
        lsl.w        #$8, d3                                       ; $009218
        move.b       -$6e4b(a6), d3                                ; $00921A
        bset.l       #$0, d3                                       ; $00921E
        move.w       d3, -$6e46(a6)                                ; $009222
        move.w       d3, -$6e44(a6)                                ; $009226
        move.w       d3, -$6e42(a6)                                ; $00922A
        move.w       d3, -$6e40(a6)                                ; $00922E
        move.w       #$1, d3                                       ; $009232
        rts                                                        ; $009236
        ifne *-$9238
        fail "ROM end moved"
        endif
