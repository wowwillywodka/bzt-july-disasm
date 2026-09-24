; $07A964..$07A96B | m68k
; Maintained assembly input; no extraction occurs during build.
; Z80 host command $12: stop sequence ID from first stack argument.
        ifne *-$7A964
        fail "ROM start moved"
        endif

GemsStopSequence:
        jsr          BeginGemsCommand(pc)                          ; $07A964
        moveq        #$12, d0                                      ; $07A968
        bra.b        WriteGemsOneArgumentCommand                                    ; $07A96A
        ifne *-$7A96C
        fail "ROM end moved"
        endif
