; $07A99E..$07A9A5 | m68k
; Maintained assembly input; no extraction occurs during build.
; Z80 host command $1C: reserve the channel in first stack argument.
        ifne *-$7A99E
        fail "ROM start moved"
        endif

GemsReserveChannel:
        jsr          BeginGemsCommand(pc)                          ; $07A99E
        moveq        #$1c, d0                                      ; $07A9A2
        bra.b        WriteGemsOneArgumentCommand                                    ; $07A9A4
        ifne *-$7A9A6
        fail "ROM end moved"
        endif
