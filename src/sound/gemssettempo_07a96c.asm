; $07A96C..$07A973 | m68k
; Maintained assembly input; no extraction occurs during build.
; Z80 host command $05: set tempo from first stack argument.
        ifne *-$7A96C
        fail "ROM start moved"
        endif

GemsSetTempo:
        jsr          BeginGemsCommand(pc)                          ; $07A96C
        moveq        #$5, d0                                       ; $07A970
        bra.b        WriteGemsOneArgumentCommand                                    ; $07A972
        ifne *-$7A974
        fail "ROM end moved"
        endif
