; $009038..$009069 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 8E98] профиль ТРАНЗИТА ct 0x38-0x4B (семейство 8DB0-901E, направленные варианты)
        ifne *-$9038
        fail "ROM start moved"
        endif

RendererRoutine_009038:
        tst.w        -$6e4c(a6)                                    ; $009038
        ble.b        loc_009054                                    ; $00903C
        move.l       #$407f7f40, -$6e46(a6)                        ; $00903E
        move.l       #$40407f7f, -$6e42(a6)                        ; $009046
        move.w       #$1, d3                                       ; $00904E
        rts                                                        ; $009052

loc_009054:
        move.l       #$c00000c0, -$6e46(a6)                        ; $009054
        move.l       #$c0c00000, -$6e42(a6)                        ; $00905C
        move.w       #$1, d3                                       ; $009064
        rts                                                        ; $009068
        ifne *-$906A
        fail "ROM end moved"
        endif
