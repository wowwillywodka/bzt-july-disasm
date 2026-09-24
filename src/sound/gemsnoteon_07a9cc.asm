; $07A9CC..$07A9DB | m68k
; Maintained assembly input; no extraction occurs during build.
; Z80 host command $00: note on (channel, note) from two stack arguments.
; The second entry at $07A9D4 issues command $01: note off.
        ifne *-$7A9CC
        fail "ROM start moved"
        endif

GemsNoteOn:
        jsr          BeginGemsCommand(pc)                          ; $07A9CC
        moveq        #$0, d0                                       ; $07A9D0
        bra.b        WriteGemsTwoArgumentCommand                                    ; $07A9D2

; Reviewed call entry (procedure): Begins GEMS command $01 and shares the two-argument emitter.
GemsNoteOff:
; Both entries share the two-argument emitter at $07A9B4.
        jsr          BeginGemsCommand(pc)                          ; $07A9D4
        moveq        #$1, d0                                       ; $07A9D8
        bra.b        WriteGemsTwoArgumentCommand                                    ; $07A9DA
        ifne *-$7A9DC
        fail "ROM end moved"
        endif
